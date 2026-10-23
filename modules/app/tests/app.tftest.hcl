run "required_inputs" {
  command = plan

  variables {
    name       = ""
    region     = ""
    components = {}
  }

  expect_failures = [
    var.name,
    var.region,
    var.components,
  ]
}

run "static_site" {
  command = plan

  variables {
    name   = "static-example"
    region = "tor"
    components = {
      site = {
        kind              = "static_site"
        source_repository = "owner/site"
        branch            = "main"
        build_command     = "npm run build"
        output_dir        = "dist"
        instance_size     = "apps-s-1vcpu-0.5gb"
        instance_count    = 1
      }
    }
    domains = [{
      domain = "example.com"
      type   = "PRIMARY"
    }]
  }

  assert {
    condition     = output.components.site.kind == "static_site" && output.components.site.output_dir == "dist"
    error_message = "Static-site source and output settings should be retained."
  }

  assert {
    condition     = output.domains[0].domain == "example.com"
    error_message = "The app domain should be retained."
  }
}

run "service_health_check" {
  command = plan

  variables {
    name   = "service-example"
    region = "tor"
    components = {
      api = {
        kind              = "service"
        source_repository = "owner/api"
        branch            = "main"
        run_command       = "bin/api"
        http_port         = 8080
        internal_ports    = [8090]
        instance_size     = "apps-s-1vcpu-0.5gb"
        instance_count    = 1
        health_check = {
          http_path             = "/health"
          initial_delay_seconds = 30
          period_seconds        = 10
        }
      }
    }
    service_order = ["api"]
    sensitive_env_vars = {
      api = {
        API_KEY = {
          value  = "EV[existing-encrypted-value]"
          scope  = "RUN_TIME"
          secret = true
        }
      }
    }
    ingress_rules = [{
      component   = "api"
      path_prefix = "/"
    }]
  }

  assert {
    condition     = output.components.api.health_check.http_path == "/health"
    error_message = "The service health check should be retained."
  }

  assert {
    condition     = length(output.service_order) == 1 && output.service_order[0] == "api"
    error_message = "The configured service order should be retained."
  }

  assert {
    condition     = output.sensitive_env_vars.api.API_KEY.value == "EV[existing-encrypted-value]"
    error_message = "Imported secret ciphertext should pass through the provider-neutral module unchanged."
  }
}
