# Secrets — names only

The values live in the Krizaka vault (never in this repository) and reach OpenTofu as environment variables at plan time:

| Variable | What |
| :--- | :--- |
| `DIGITALOCEAN_TOKEN` | DigitalOcean API token (read-only for plans where possible) |
| `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY` | the S3-compatible state backend (Spaces keys) |
| `PORKBUN_API_KEY`, `PORKBUN_SECRET_API_KEY` | DNS (Porkbun). The vault and the GitHub secret of this repository call the second one `PORKBUN_SECRET_KEY`; the provider reads `PORKBUN_SECRET_API_KEY`, so the workflow and the commands map one onto the other. Read-only plans only. |
| `BUNNY_API_KEY` | CDN and storage (read-only first) |

Each app's runtime secrets (database passwords, JWT secrets, provider keys) stay `type: SECRET` values set by the existing
deploy scripts; the code here declares them `sensitive` and never reads them back.

## Per stack

| Variable | Stack | What |
| :--- | :--- | :--- |
| `TF_VAR_env_values` | `stacks/dev/orazaka` | JSON map `"<component>/<KEY>"` → value: orazaka-dev's SECRET envs and the values kept out of git (database URLs, the broker's CA, app identifiers). Read from the running app with `scripts/env-values-from-live.py` (README), or from the vault. |
| `SPACES_ACCESS_KEY_ID`, `SPACES_SECRET_ACCESS_KEY` | `stacks/prod/yomizaka-documents` | The operator's Spaces keys, which the DigitalOcean provider needs to create the bucket and its policy. Not the application's key (that one is created by the stack, limited to the bucket, and is typed once in Yomizaka's admin screen). |
