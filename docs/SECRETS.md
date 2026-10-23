# Secrets — names only

The values live in the Krizaka vault (never in this repository) and reach OpenTofu as environment variables at plan time:

| Variable | What |
| :--- | :--- |
| `DIGITALOCEAN_TOKEN` | DigitalOcean API token (read-only for plans where possible) |
| `TF_VAR_runtime_secrets` | Sensitive JSON map for `orazaka-dev` runtime configuration, including its allowlisted IP and VPC ID (key names are in its stack README) |
| `TF_VAR_imported_secret_ciphertext` | Sensitive JSON map of the existing DigitalOcean `EV[...]` ciphertexts for `orazaka-dev` SECRET environment values; do not substitute plaintext |
| `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY` | the S3-compatible state backend (Spaces keys) |
| `PORKBUN_API_KEY`, `PORKBUN_SECRET_API_KEY` | DNS |
| `BUNNY_API_KEY` | CDN and storage (read-only first) |

Imported `type: SECRET` values (database passwords, JWT secrets, provider keys) use their existing DigitalOcean
`EV[...]` ciphertext through `TF_VAR_imported_secret_ciphertext`; do not replace these with plaintext before the first
no-op plan. Other sensitive runtime configuration, including network identifiers, uses `TF_VAR_runtime_secrets`.
