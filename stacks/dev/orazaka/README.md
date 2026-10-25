# stacks/dev/orazaka — orazaka-dev as code

What runs today (2026-10-24), described with the roles and the DigitalOcean adapters:

| Resource | Live id | Role |
| :--- | :--- | :--- |
| App Platform `orazaka-dev` (web, core, gpu-relay; tor) — from `krizaka/orazaka` `infra/deploy/orazaka-dev.app.yaml` | `4f0f45c4-3e6f-4f75-9f47-2b4454ed4ab6` | `app` |
| Managed PostgreSQL `krizaka-dev-pg` (pg 18, db-s-1vcpu-1gb, tor1) and the six databases orazaka-dev uses | `3e31f066-262e-4dbd-9f72-aa5f39bcba6a` | `database` |
| Droplet `orazaka-broker-dev` (RabbitMQ, TLS) and its firewall | `609157538`, `eb197883-3248-4dcb-9366-585212c55160` | `broker` |

`imports.tf` imports them (10 resources); every resource has `prevent_destroy`. The cluster is shared by the family: it
moves to `stacks/dev/shared` (docs/PLAN.md §2) with a `moved` block when the second product stack lands.

**Never apply from an agent or from CI.** An apply is Oussama's step, after a reviewed plan.

## Plan it (read-only)

State stays local, **outside the repository** (no remote backend yet); nothing here is committed but the code.

```sh
cd stacks/dev/orazaka
export TF_DATA_DIR="$HOME/.krizaka-infra/dev-orazaka.terraform"
tofu init -backend-config="path=$HOME/.krizaka-infra/state/dev-orazaka.tfstate"

# A DigitalOcean token (read-only scope if you have one), never printed nor written down.
export DIGITALOCEAN_TOKEN="$(…)"
# The secret and external env values, read from the running app: SECRET values come back encrypted (EV[…]),
# which keeps them unchanged. Never write this to a file in the repository.
export TF_VAR_env_values="$(doctl apps spec get 4f0f45c4-3e6f-4f75-9f47-2b4454ed4ab6 --format json \
  | ../../../scripts/env-values-from-live.py .)"

tofu plan -lock=false
```

The keys `TF_VAR_env_values` holds are the `required_env_values` output (`"<component>/<KEY>"`): every SECRET env, and
the values kept out of git (the database URLs with their host, the broker's CA, the mobile app identifiers,
`CORE_REBUILD`). To set a secret from the vault instead, give its plain value: App Platform re-encrypts it.

`tofu plan` imports through the `import` blocks, in the plan only. `tofu import <address> <id>` writes the same into the
local state if you want it there; it never changes a live resource.

## The first plan (2026-10-24, OpenTofu 1.13.2, provider digitalocean 2.106.0)

```
Plan: 10 to import, 0 to add, 1 to change, 0 to destroy.
```

Nothing to add or destroy; the cluster, the six databases, the droplet and the firewall are imported unchanged; all 84
envs match. The one change is an **import artifact**, not a difference with what runs: on `orazaka-dev`, the four
`spec.domain` blocks (`www.orazaka.com` PRIMARY, `orazaka.com`, `dev.orazaka.com`, `admin.orazaka.com` ALIAS) show as
added, because the provider fills `spec.domain` on read only when the state already holds it, and an import starts from
none (`flattenAppSpec`, terraform-provider-digitalocean 2.106.0). The live spec lists the same four domains with the
same types (`spec.domains`, unchanged in the plan), so the first apply would send App Platform the spec it runs, and
every plan after it says « No changes ». That apply is Oussama's call.
