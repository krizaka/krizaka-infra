# modules/app — a deployable app (role)

The provider-neutral interface of an app: services (a Dockerfile or a buildpack, an HTTP port, internal ports, a health
check, a size and a count) and static sites, their envs, domains and ingress rules. **No resource here**: it validates the
inputs and outputs one `spec` for an adapter (`providers/digitalocean/app` today).

Secret values never enter the spec. An env is either a public `value` in code, or `secret = true` (a SECRET env) /
`external = true` (a value kept out of git: a host, a certificate), and then its value comes from the sensitive
`env_values` map, keyed `"<component>/<KEY>"`, given through the environment (`TF_VAR_env_values`).

| Input | Type | |
| :--- | :--- | :--- |
| `name`, `region` | string | required; a live app keeps its name and region |
| `vpc_id` | string | optional |
| `features` | list(string) | provider feature flags |
| `domains` | list({name, type}) | at most one `PRIMARY` |
| `ingress_rules` | list({path_prefix, authority, component \| redirect}) | ordered |
| `services`, `static_sites` | list(object) | at least one component in all |
| `env_values` | map(string), sensitive | the secret and external values |

| Output | |
| :--- | :--- |
| `spec` | the normalized app, without secrets |
| `env_values` | passed through to the adapter (sensitive) |
| `required_env_values` | the keys `env_values` must hold |

```hcl
module "app" {
  source   = "../../../modules/app"
  name     = "api-dev"
  region   = "tor"
  services = [{
    name            = "core"
    source          = { repo = "krizaka/orazaka" }
    dockerfile_path = "Dockerfile"
    http_port       = 8088
    instance_size   = "basic-s"
    health_check    = { http_path = "/actuator/health" }
    envs            = [{ key = "LOG_LEVEL", value = "INFO" }, { key = "DB_PASSWORD", secret = true }]
  }]
  env_values = var.env_values
}

module "app_digitalocean" {
  source     = "../../../providers/digitalocean/app"
  app        = module.app.spec
  env_values = module.app.env_values
}
```

Tests: `tofu test` (offline: required inputs, a static site, a service with a health check and a secret).
