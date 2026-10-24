#!/usr/bin/env bash
# Runs what CI runs on every directory that holds OpenTofu code: init (no backend), validate, and `tofu test` where a
# tests/ folder exists. No credentials: modules are tested with mocked providers, stacks are only validated.
set -euo pipefail
cd "$(dirname "$0")/.."

dirs=$(find modules providers stacks -name '*.tf' -not -path '*/.terraform/*' -not -path '*/tests/*' \
  -exec dirname {} \; 2>/dev/null | sort -u || true)
if [ -z "$dirs" ]; then echo "no OpenTofu code yet"; exit 0; fi

for d in $dirs; do
  echo "::group::$d"
  tofu -chdir="$d" init -backend=false -input=false -no-color >/dev/null
  tofu -chdir="$d" validate -no-color
  if [ -d "$d/tests" ]; then tofu -chdir="$d" test -no-color; fi
  echo "::endgroup::"
done
