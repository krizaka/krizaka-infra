# The interface has no provider: plans run offline.

run "requires_a_name_and_a_region" {
  command = plan
  variables {
    name   = "Not_A_Name"
    region = "tor"
  }
  expect_failures = [var.name]
}

run "requires_a_component" {
  command = plan
  variables {
    name   = "empty-app"
    region = "tor"
  }
  expect_failures = [output.spec]
}

run "static_site" {
  command = plan
  variables {
    name   = "krizaka-site"
    region = "tor"
    static_sites = [{
      name          = "site"
      source        = { repo = "krizaka/krizaka-com" }
      build_command = "npm run build"
      output_dir    = "out"
      envs          = [{ key = "NEXT_PUBLIC_MEDIA_CDN_URL", value = "https://cdn.example" }]
    }]
    domains = [{ name = "www.example.com", type = "PRIMARY" }]
  }
  assert {
    condition     = output.spec.static_sites[0].envs[0].scope == "BUILD_TIME"
    error_message = "A static site's env defaults to BUILD_TIME."
  }
  assert {
    condition     = length(output.required_env_values) == 0
    error_message = "No secret, nothing required."
  }
}

run "service_with_health_check_and_a_secret" {
  command = plan
  variables {
    name   = "api-dev"
    region = "tor"
    services = [{
      name            = "core"
      source          = { repo = "krizaka/orazaka" }
      dockerfile_path = "Dockerfile"
      http_port       = 8088
      instance_size   = "basic-s"
      health_check    = { http_path = "/actuator/health", failure_threshold = 9 }
      envs = [
        { key = "LOG_LEVEL", value = "INFO" },
        { key = "DB_PASSWORD", secret = true },
      ]
    }]
    ingress_rules = [{ path_prefix = "/", component = "core" }]
    env_values    = { "core/DB_PASSWORD" = "s3cret" }
  }
  assert {
    condition     = output.spec.services[0].health_check.http_path == "/actuator/health"
    error_message = "The health check is kept."
  }
  assert {
    condition     = output.required_env_values == tolist(["core/DB_PASSWORD"])
    error_message = "The secret is listed as required."
  }
  assert {
    condition     = !strcontains(jsonencode(output.spec), "s3cret")
    error_message = "A secret value never appears in the spec."
  }
}

run "refuses_a_missing_secret" {
  command = plan
  variables {
    name   = "api-dev"
    region = "tor"
    services = [{
      name            = "core"
      source          = { repo = "krizaka/orazaka" }
      dockerfile_path = "Dockerfile"
      instance_size   = "basic-s"
      envs            = [{ key = "DB_PASSWORD", secret = true }]
    }]
  }
  expect_failures = [output.spec]
}

run "refuses_a_rule_to_an_unknown_component" {
  command = plan
  variables {
    name   = "api-dev"
    region = "tor"
    services = [{
      name             = "web"
      source           = { repo = "krizaka/orazaka-web-client" }
      environment_slug = "node-js"
      instance_size    = "apps-s-1vcpu-0.5gb"
    }]
    ingress_rules = [{ path_prefix = "/", component = "nope" }]
  }
  expect_failures = [output.spec]
}
