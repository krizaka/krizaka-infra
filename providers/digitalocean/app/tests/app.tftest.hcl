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
    vpc_id = "mock-vpc"
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

run "preserves_service_and_ingress_order" {
  command = plan

  variables {
    name   = "ordered-app"
    region = "tor"
    components = {
      web = {
        kind              = "service"
        source_repository = "owner/web"
        branch            = "main"
        instance_size     = "apps-s-1vcpu-0.5gb"
        instance_count    = 1
      }
      core = {
        kind              = "service"
        source_repository = "owner/core"
        branch            = "main"
        instance_size     = "apps-s-1vcpu-0.5gb"
        instance_count    = 1
      }
      gpu-relay = {
        kind              = "service"
        source_repository = "owner/gpu-relay"
        branch            = "main"
        instance_size     = "apps-s-1vcpu-0.5gb"
        instance_count    = 1
      }
    }
    service_order = ["web", "core", "gpu-relay"]
    ingress_rules = [
      for index in range(12) : {
        component   = "web"
        path_prefix = "/route-${index}"
      }
    ]
  }

  assert {
    condition = [
      for service in digitalocean_app.app.spec[0].service : service.name
    ] == ["web", "core", "gpu-relay"]
    error_message = "Service blocks should preserve the configured service order."
  }

  assert {
    condition     = digitalocean_app.app.spec[0].ingress[0].rule[11].match[0].path[0].prefix == "/route-11"
    error_message = "Ingress rules should preserve caller order beyond ten rules."
  }
}

run "preserves_static_site_build_settings" {
  command = plan

  variables {
    name   = "static-app"
    region = "tor"
    components = {
      site = {
        kind              = "static_site"
        source_repository = "owner/site"
        branch            = "main"
        environment_slug  = "node-js"
        dockerfile_path   = "infra/Dockerfile"
        source_dir        = "site"
        build_command     = "npm run build"
        output_dir        = "dist"
        instance_size     = "apps-s-1vcpu-0.5gb"
        instance_count    = 1
      }
    }
  }

  assert {
    condition = (
      digitalocean_app.app.spec[0].static_site[0].dockerfile_path == "infra/Dockerfile" &&
      digitalocean_app.app.spec[0].static_site[0].environment_slug == "node-js"
    )
    error_message = "Static sites should preserve Dockerfile and build environment settings."
  }
}
