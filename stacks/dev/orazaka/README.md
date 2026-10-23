# orazaka-dev

This stack describes the existing DigitalOcean App Platform app `orazaka-dev` in region `tor`. It preserves the live
`web`, `core`, and `gpu-relay` components, their source repositories/branches, sizing, env names, domains, VPC, and
ingress routes from `krizaka/orazaka`'s `infra/deploy/orazaka-dev.app.yaml`.

## Import and no-op plan

Supply the vault values as environment variables in the local shell before running OpenTofu. `DIGITALOCEAN_TOKEN` is
the provider credential; `TF_VAR_runtime_secrets` is a JSON object containing the keys below. Do not put these values
in a `.tfvars` file or commit them. For example, have the vault populate the variables, then run:

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

`TF_VAR_runtime_secrets` must contain these names:

`APP_IOS_TEAM_ID`, `APP_ANDROID_CERT_SHA256`, `NEXTAUTH_SECRET_WEB`, `NEXTAUTH_SECRET_ADMIN`, `CORE_REBUILD`,
`DATABASE_HOST`, `DATABASE_PASSWORD_ORAZAKA_DB`, `DATABASE_PASSWORD_KRIZAKA_USERS_DB`,
`DATABASE_PASSWORD_ORAZAKA_STUDIO_DB`, `DATABASE_PASSWORD_ORAZAKA_KNOWLEDGE_DB`,
`DATABASE_PASSWORD_ORAZAKA_AUTOMATION_DB`, `RABBITMQ_PASS`, `RABBITMQ_CA_CERT_BASE64`, `IDENTITY_JWT_SECRET`,
`CRYPTO_KEY`, `CRYPTO_SALT`, `MEDIA_ENCRYPTION_KEY`, `MEDIA_STORAGE_API_KEY`, `BILLING_DB_PASSWORD`,
`AI_INFERENCE_KEY`, `AI_INFERENCE_KEY_ALL`, and `AI_GPU_RELAY_PASSWORD`.
