# Secrets — names only

The values live in the Krizaka vault (never in this repository) and reach OpenTofu as environment variables at plan time:

| Variable | What |
| :--- | :--- |
| `DIGITALOCEAN_TOKEN` | DigitalOcean API token (read-only for plans where possible) |
| `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY` | the S3-compatible state backend (Spaces keys) |
| `PORKBUN_API_KEY`, `PORKBUN_SECRET_API_KEY` | DNS |
| `BUNNY_API_KEY` | CDN and storage (read-only first) |

Each app's runtime secrets (database passwords, JWT secrets, provider keys) stay `type: SECRET` values set by the existing
deploy scripts; the code here declares them `sensitive` and never reads them back.

## Per stack

| Variable | Stack | What |
| :--- | :--- | :--- |
| `TF_VAR_env_values` | `stacks/dev/orazaka` | JSON map `"<component>/<KEY>"` → value: orazaka-dev's SECRET envs and the values kept out of git (database URLs, the broker's CA, app identifiers). Read from the running app with `scripts/env-values-from-live.py` (README), or from the vault. |
