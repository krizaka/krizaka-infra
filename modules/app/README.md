# App module

Provider-neutral contract for an app containing one or more services or static sites. Each component takes a source
repository and branch, optional build or Dockerfile settings, service ports and health check, and a fixed instance size
and count. Plain environment values go in `env_vars`; values supplied separately in `sensitive_env_vars` are marked
sensitive by OpenTofu and can independently be marked as provider `SECRET` values.

## Inputs

| Input | Required | Description |
| --- | --- | --- |
| `name`, `region` | yes | App name and region; retain existing values when importing. |
| `components` | yes | Map of services/static sites and their source, build, port, health-check, sizing, and plain env settings. |
| `sensitive_env_vars` | no | Sensitive env values per component, each with a scope and an optional provider-secret flag. |
| `domains`, `ingress_rules` | no | Domain names and component/redirect routing rules. |
| `features`, `vpc_id` | no | Provider-supported features and optional private network identifier. |

## Outputs

`name`, `region`, `components`, `sensitive_env_vars`, `domains`, `ingress_rules`, `features`, and `vpc_id` expose the
validated role contract. The provider adapter publishes the provider's generated `default_url` and `app_id`.

## Example

```hcl
module "app" {
  source = "../../modules/app"

  name   = "example-dev"
  region = "tor"
  components = {
    web = {
      kind              = "service"
      source_repository = "owner/web"
      branch            = "main"
      build_command     = "npm run build"
      run_command       = "npm start"
      http_port         = 8080
      instance_size     = "apps-s-1vcpu-0.5gb"
      instance_count    = 1
    }
  }
}
```

Tests in `tests/app.tftest.hcl` cover required values, a static site, and a service health check.
