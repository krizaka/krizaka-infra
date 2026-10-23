mock_provider "digitalocean" {}

run "mocked_app_spec" {
  command = plan

  variables {
    name   = "mock-app"
    region = "tor"
    components = {
      api = {
        kind              = "service"
        source_repository = "owner/api"
        branch            = "main"
        http_port         = 8080
        instance_size     = "apps-s-1vcpu-0.5gb"
        instance_count    = 1
        health_check = {
          http_path = "/health"
        }
      }
    }
    sensitive_env_vars = {
      api = {
        API_KEY = {
          value = "mock-secret"
          scope = "RUN_TIME"
        }
      }
    }
    domains = [{
      domain = "example.com"
      type   = "PRIMARY"
    }]
    ingress_rules = [{
      component   = "api"
      path_prefix = "/"
    }]
  }

  assert {
    condition     = output.app_id != "" && output.default_url != ""
    error_message = "The adapter should expose the provider app ID and default URL."
  }

}
