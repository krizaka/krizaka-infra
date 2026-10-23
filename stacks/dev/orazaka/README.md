# orazaka-dev

This stack describes the existing DigitalOcean App Platform app `orazaka-dev` in region `tor`. It preserves the live
`web`, `core`, and `gpu-relay` components, their source repositories/branches, sizing, env names, domains, VPC, and
ingress routes from `krizaka/orazaka`'s `infra/deploy/orazaka-dev.app.yaml`.

## Import and no-op plan

Supply the vault values as environment variables in the local shell before running OpenTofu. `DIGITALOCEAN_TOKEN` is
the provider credential; `TF_VAR_runtime_secrets` and `TF_VAR_imported_secret_ciphertext` are sensitive JSON objects
containing the keys below. Do not put these values in a `.tfvars` file or commit them. The ciphertext map must hold the
exact existing `EV[...]` values for SECRET env vars returned by DigitalOcean; plaintext secrets would cause an update
after import. Have the vault populate both variables, then run:

```sh
cd stacks/dev/orazaka
tofu init
APP_ID="replace-with-existing-app-id"
tofu import module.orazaka.digitalocean_app.app "$APP_ID"
tofu plan
```

Set `APP_ID` to the existing app's ID (for example, from `doctl apps list`). Review the plan with Oussama; the first
plan must be a no-op. **Never run `tofu apply` from this stack as an agent.**

## Vault keys

`TF_VAR_runtime_secrets` must contain these names (including the allowlisted IP and VPC ID, which identify network
information and must not be stored in Terraform files):

`APP_IOS_TEAM_ID`, `APP_ANDROID_CERT_SHA256`, `AUTH_ALLOWED_IPS`, `CORE_REBUILD`, `DATABASE_HOST`,
`RABBITMQ_CA_CERT_BASE64`, and `VPC_ID`.

`TF_VAR_imported_secret_ciphertext` must contain the existing encrypted values for:

`NEXTAUTH_SECRET`, `AUTH_CONSOLE_SECRET`, `SPRING_DATASOURCE_PASSWORD`, `IDENTITY_DB_PASSWORD`,
`STUDIO_DB_PASSWORD`, `KNOWLEDGE_DB_PASSWORD`, `AUTOMATION_DB_PASSWORD`, `RABBITMQ_PASS`,
`IDENTITY_JWT_SECRET`, `CRYPTO_KEY`, `CRYPTO_SALT`, `MEDIA_ENCRYPTION_KEY`, `MEDIA_STORAGE_API_KEY`,
`BILLING_DB_PASSWORD`, `AI_INFERENCE_KEY`, `AI_INFERENCE_KEY_ALL`, and `AI_GPU_RELAY_PASSWORD`.
