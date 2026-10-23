# DigitalOcean app adapter

Maps the provider-neutral `modules/app` contract to one `digitalocean_app` resource. The adapter uses GitHub source
components, service/static-site settings, env var visibility, custom domains, ingress, features, and an optional VPC.
DigitalOcean credentials are read from the standard `DIGITALOCEAN_TOKEN` environment variable; this module does not
configure or require credentials during validation.

## Inputs and outputs

Inputs mirror `modules/app`: `name`, `region`, `components`, `service_order`, `sensitive_env_vars`, `domains`,
`ingress_rules`, `features`, and optional sensitive `vpc_id`. Supply `service_order` to preserve service order on import.
Outputs are `app_id` (provider ID) and `default_url` (provider-generated default ingress URL).

## Example

```hcl
module "orazaka" {
  source = "../../../providers/digitalocean/app"

  name       = "orazaka-dev"
  region     = "tor"
  components = var.components
}
```

The adapter's `tofu test` uses a mocked DigitalOcean provider and never contacts a live account.
