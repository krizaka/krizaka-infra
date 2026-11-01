#!/usr/bin/env bash
# ADR-022 (krizaka-internal#2128): a commercial name never serves a dev app. No record of a commercial zone (verikora,
# folioviv, sovkora, kridoc) targets an App Platform host or a code-name host, or is an app record on a web host.
# A tofu test cannot hold this: the stack's import blocks are not supported in the test context. Run by check.sh and CI.
set -euo pipefail
cd "$(dirname "$0")/../stacks/dns"
bad=0
for f in zone_verikora_com.tf zone_folioviv_com.tf zone_folioviv_app.tf zone_folioviv_shop.tf zone_sovkora_com.tf zone_kridoc_com.tf; do
  while IFS= read -r line; do
    case "$line" in
      \#*) continue ;;
      *) ;;
    esac
    if printf '%s' "$line" | grep -Eiq 'ondigitalocean\.app|yomizaka|akinaza|orazaka|kachizaka|kind *= *"app"|type *= *"(A|AAAA|CNAME|ALIAS)"'; then
      echo "commercial DNS guard: $f points at an app: $line" >&2
      bad=1
    fi
  done < "$f"
done
[ "$bad" = 0 ] || { echo "ADR-022: a commercial name never serves a dev app; records arrive with the product's prod step." >&2; exit 1; }
echo "commercial DNS guard: ok"
