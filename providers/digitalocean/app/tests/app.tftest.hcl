# Mocked provider: no credential, no call to DigitalOcean.
mock_provider "digitalocean" {}

run "maps_a_service_and_its_secret" {
  command = plan
  variables {
    app = {
      name          = "api-dev"
      region        = "tor"
      vpc_id        = "vpc-1"
      features      = []
      domains       = [{ name = "www.example.com", type = "PRIMARY" }]
      ingress_rules = [{ path_prefix = "/", authority = null, component = "core", redirect = null }]
      static_sites  = []
      services = [{
        name             = "core"
        source           = { repo = "krizaka/orazaka", branch = "main", deploy_on_push = false, dir = "/" }
        dockerfile_path  = "Dockerfile"
        environment_slug = null
        build_command    = null
        run_command      = null
        http_port        = 8088
        internal_ports   = [8090]
        instance_size    = "basic-s"
        instance_count   = 1
        health_check     = { http_path = "/actuator/health", port = null, initial_delay_seconds = 240, period_seconds = 20, timeout_seconds = 5, success_threshold = null, failure_threshold = 9 }
        envs = [
          { key = "LOG_LEVEL", scope = "RUN_TIME", value = "INFO", secret = false, external = false },
          { key = "DB_PASSWORD", scope = "RUN_TIME", value = null, secret = true, external = false },
        ]
      }]
    }
    env_values = { "core/DB_PASSWORD" = "s3cret" }
  }
  assert {
    condition     = digitalocean_app.this.spec[0].service[0].health_check[0].initial_delay_seconds == 240
    error_message = "The health check reaches the app."
  }
  assert {
    condition     = one([for e in digitalocean_app.this.spec[0].service[0].env : e.type if e.key == "DB_PASSWORD"]) == "SECRET"
    error_message = "A secret env is typed SECRET."
  }
  assert {
    condition     = digitalocean_app.this.spec[0].vpc[0].id == "vpc-1"
    error_message = "The VPC is kept."
  }
  assert {
    condition     = digitalocean_app.this.spec[0].ingress[0].rule[0].component[0].name == "core"
    error_message = "The ingress rule routes to its component."
  }
}

run "maps_a_static_site" {
  command = plan
  variables {
    app = {
      name          = "krizaka-site"
      region        = "tor"
      vpc_id        = null
      features      = []
      domains       = []
      ingress_rules = []
      services      = []
      static_sites = [{
        name             = "site"
        source           = { repo = "krizaka/krizaka-com", branch = "main", deploy_on_push = true, dir = null }
        environment_slug = "node-js"
        build_command    = "npm run build"
        output_dir       = "out"
        index_document   = null
        error_document   = null
        envs             = []
      }]
    }
  }
  assert {
    condition     = digitalocean_app.this.spec[0].static_site[0].output_dir == "out"
    error_message = "The static site is mapped."
  }
  assert {
    condition     = length(digitalocean_app.this.spec[0].vpc) == 0
    error_message = "No VPC when none is given."
  }
}
