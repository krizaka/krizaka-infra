#!/usr/bin/env bash
# Read-only plan of stacks/dns against the live Porkbun zones. Never applies. Needs PORKBUN_API_KEY and
# PORKBUN_SECRET_API_KEY in the environment (docs/SECRETS.md). The state is empty (the import blocks bring the live
# records into the plan), so the same command works on a laptop and in CI.
#
# Prints one summary line, e.g. « Plan: 134 to import, 0 to add, 0 to change, 0 to destroy. », and exits 1 when the
# live DNS differs from the code (a record to add, change or destroy), 0 when it does not.
set -euo pipefail
cd "$(dirname "$0")/../stacks/dns"

work=$(mktemp -d)
trap 'rm -rf "$work"' EXIT
export TF_DATA_DIR="$work/data"
: "${PORKBUN_API_KEY:?PORKBUN_API_KEY is not set}"
: "${PORKBUN_SECRET_API_KEY:?PORKBUN_SECRET_API_KEY is not set}"

tofu init -input=false -no-color -backend-config="path=$work/state.tfstate" >/dev/null
tofu plan -input=false -no-color -lock=false -parallelism=2 -out="$work/plan.bin" >"$work/plan.txt" || { tail -n 25 "$work/plan.txt"; exit 2; }
tofu show -json "$work/plan.bin" >"$work/plan.json"

read -r imp add chg del < <(jq -r '
  [.resource_changes[]? | {a: .change.actions, i: (.change.importing != null)}] as $c
  | [ ($c | map(select(.i)) | length),
      ($c | map(select(.a == ["create"])) | length),
      ($c | map(select(.a == ["update"] or .a == ["delete","create"] or .a == ["create","delete"])) | length),
      ($c | map(select(.a | index("delete"))) | length) ] | @tsv' "$work/plan.json")

echo "Plan: $imp to import, $add to add, $chg to change, $del to destroy."
if [ "$add" != 0 ] || [ "$chg" != 0 ] || [ "$del" != 0 ]; then
  echo "The live DNS differs from the code. Changed records:"
  jq -r '.resource_changes[] | select(.change.actions != ["no-op"] and .change.actions != ["read"]) | select(.change.actions | index("no-op") | not) | "  \(.address): \(.change.actions | join(","))"' "$work/plan.json" | head -n 40
  exit 1
fi
