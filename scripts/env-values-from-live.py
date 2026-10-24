#!/usr/bin/env python3
"""Prints, as JSON, the values a stack's TF_VAR_env_values needs, read from the running app (read-only).

Usage: TF_VAR_env_values="$(doctl apps spec get <app-id> --format json | scripts/env-values-from-live.py <stack-dir>)"

The keys are the stack's `required_env_values` ("<component>/<KEY>", read from its main.tf through `tofu console` would
need state, so they come from the spec's own secret and placeholder envs: every SECRET env, and every key the stack marks
`external = true`). App Platform returns SECRET values encrypted (`EV[…]`): handing them back keeps the secret unchanged,
so the plan is a no-op. Never write the output to a file in the repository; never print it.
"""
import json
import re
import sys
from pathlib import Path

if len(sys.argv) != 2:
    sys.exit(__doc__)

spec = json.load(sys.stdin)
stack = Path(sys.argv[1])
source = "\n".join(p.read_text() for p in stack.glob("*.tf"))
external = set(re.findall(r'key = "([A-Z0-9_]+)",[^}\n]*external = true', source))

values = {}
for kind in ("services", "static_sites", "workers", "jobs"):
    for component in spec.get(kind) or []:
        for env in component.get("envs") or []:
            if env.get("type") == "SECRET" or env["key"] in external:
                values[f'{component["name"]}/{env["key"]}'] = env.get("value", "")
json.dump(values, sys.stdout)
