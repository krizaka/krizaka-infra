# Plan — the Krizaka infrastructure, as portable code

Asked by Oussama (2026-10-23): « pense aussi à un infra as code à créer pour la portabilité ».

## 1. What runs today (inventory, 2026-10-23)

| Kind | Name | Where | Source of truth today |
| :--- | :--- | :--- | :--- |
| App Platform | `orazaka-dev` | tor1 | `krizaka/orazaka` `infra/deploy/orazaka-dev.app.yaml` (+ `scripts/dev-deploy.mjs`) |
| App Platform | `orazaka-admin-dev` | tor1 | `krizaka/orazaka` `infra/deploy/orazaka-admin-dev.app.yaml` |
| App Platform | `yomizaka-dev`, `akinaza-dev`, `kachizaka-dev`, `yasakia-dev`, `yororis-qa`, `orochia-dev`, `orochia-admin-dev` | tor1 | each product repository's app spec (`.do/` or `infra/`) |
| App Platform (static) | `krizaka-com`, `krizaka-blog`, `krizaka-ui-site`, `krizaka-java-site`, `krizaka-ts-site` | tor1 | each site's repository |
| Managed PostgreSQL | `krizaka-dev-pg` (pg 18, db-s-1vcpu-1gb) | tor1 | created by hand; databases and roles by the products' migrations and `dev-deploy.mjs` |
| Droplet | `orazaka-broker-dev` (RabbitMQ, TLS) | tor1 | `krizaka/orazaka` `scripts/dev-deploy.mjs broker` |
| DNS | `krizaka.com`, `orazaka.com`, `yomizaka.com`, `akinaza.com`, … | Porkbun | by hand and scripts (API v3) |
| CDN / storage | zone `krizaka-assets`, `orochia-dev` | Bunny | `krizaka/krizaka-com` `scripts/bunny-layout.mjs`, `cdn-assets.mjs` |

Find every app spec with `doctl apps spec get <id>` (read-only) and the repositories' `*.app.yaml`.

## 2. Target

- **OpenTofu**, with S3-compatible state (DigitalOcean Spaces, or any S3) and state locking. The backend is configured
  per environment, with credentials from the environment.
- **Roles (provider-neutral modules):**
  - `app`: a container or static service, with env, domains, health check and scaling;
  - `database`: a managed Postgres cluster, its databases and roles (passwords never in state outputs);
  - `broker`: a VM and its service;
  - `dns`: records;
  - `cdn`: a pull zone and storage;
  - `object-store`.
- **Adapters:** `providers/digitalocean/*` first, mapping one-to-one to what runs (App Platform specs as
  `digitalocean_app`). `providers/porkbun/dns` (community provider, or an HTTP-based module) and `providers/bunny/cdn`.
  A second provider (for example Hetzner or Scaleway) comes later, for the `app` and `database` roles only, as the proof
  of portability.
- **Stacks:** `stacks/dev/<product>`, one per product, plus `stacks/dev/shared` for the cluster, the broker and DNS.

## 3. Order of work (one PR each)

1. The repository's CI: `tofu fmt`, `validate`, `tflint` and `tofu test` with mocked providers. A `.tool-versions` / `mise.toml` pinning OpenTofu.
2. `modules/app` and `providers/digitalocean/app`. Translate `orazaka-dev.app.yaml` into a stack with **the same** spec.
   Write the import commands in the stack's README. Acceptance: the plan is a no-op (run by Oussama).
3. The same for the other App Platform apps, one stack per product.
4. `modules/database` and `providers/digitalocean/database` for `krizaka-dev-pg`: the cluster and the database list. Users
   and passwords stay with the products' migrations.
5. `modules/dns` and `providers/porkbun/dns`, for the records the apps need (CNAME, TXT verification).
6. `modules/broker`: the droplet, firewall and VPC, imported as is.
7. `modules/cdn` (Bunny): the zones, read-only first.
8. `docs/PORTABILITY.md`: what moving a product to another provider takes, proved on one app with a second adapter that is validated only, never applied.

## 4. Never

- Apply from CI or from an agent.
- Put a secret in a file, an output or a commit.
- Recreate a running resource (renames, region changes).
- Add a paid resource without Oussama's go.
