# The DigitalOcean adapter of the app role: one App Platform app (`digitalocean_app`), mapped one to one from the spec.
# A SECRET env keeps the value App Platform holds: give the encrypted `EV[…]` value it returns (doctl apps spec get) for
# a no-op plan, or the plain value to change it.
resource "digitalocean_app" "this" {
  spec {
    name     = var.app.name
    region   = var.app.region
    features = var.app.features

    dynamic "domain" {
      for_each = var.app.domains
      content {
        name = domain.value.name
        type = domain.value.type
      }
    }

    dynamic "vpc" {
      for_each = var.app.vpc_id == null ? [] : [var.app.vpc_id]
      content {
        id = vpc.value
      }
    }

    dynamic "ingress" {
      for_each = length(var.app.ingress_rules) == 0 ? [] : [1]
      content {
        dynamic "rule" {
          for_each = var.app.ingress_rules
          content {
            match {
              dynamic "path" {
                for_each = rule.value.path_prefix == null ? [] : [rule.value.path_prefix]
                content {
                  prefix = path.value
                }
              }
              dynamic "authority" {
                for_each = rule.value.authority == null ? [] : [rule.value.authority]
                content {
                  exact = authority.value
                }
              }
            }
            dynamic "component" {
              for_each = rule.value.component == null ? [] : [rule.value.component]
              content {
                name = component.value
              }
            }
            dynamic "redirect" {
              for_each = rule.value.redirect == null ? [] : [rule.value.redirect]
              content {
                authority     = redirect.value.authority
                redirect_code = redirect.value.code
              }
            }
          }
        }
      }
    }

    dynamic "service" {
      for_each = var.app.services
      content {
        name               = service.value.name
        dockerfile_path    = service.value.dockerfile_path
        environment_slug   = service.value.environment_slug
        build_command      = service.value.build_command
        run_command        = service.value.run_command
        source_dir         = service.value.source.dir
        http_port          = service.value.http_port
        internal_ports     = service.value.internal_ports
        instance_size_slug = service.value.instance_size
        instance_count     = service.value.instance_count

        github {
          repo           = service.value.source.repo
          branch         = service.value.source.branch
          deploy_on_push = service.value.source.deploy_on_push
        }

        dynamic "health_check" {
          for_each = service.value.health_check == null ? [] : [service.value.health_check]
          content {
            http_path             = health_check.value.http_path
            port                  = health_check.value.port
            initial_delay_seconds = health_check.value.initial_delay_seconds
            period_seconds        = health_check.value.period_seconds
            timeout_seconds       = health_check.value.timeout_seconds
            success_threshold     = health_check.value.success_threshold
            failure_threshold     = health_check.value.failure_threshold
          }
        }

        dynamic "env" {
          for_each = service.value.envs
          content {
            key   = env.value.key
            scope = env.value.scope
            type  = env.value.secret ? "SECRET" : "GENERAL"
            value = env.value.secret || env.value.external ? var.env_values["${service.value.name}/${env.value.key}"] : env.value.value
          }
        }
      }
    }

    dynamic "static_site" {
      for_each = var.app.static_sites
      content {
        name             = static_site.value.name
        environment_slug = static_site.value.environment_slug
        build_command    = static_site.value.build_command
        output_dir       = static_site.value.output_dir
        index_document   = static_site.value.index_document
        error_document   = static_site.value.error_document
        source_dir       = static_site.value.source.dir

        github {
          repo           = static_site.value.source.repo
          branch         = static_site.value.source.branch
          deploy_on_push = static_site.value.source.deploy_on_push
        }

        dynamic "env" {
          for_each = static_site.value.envs
          content {
            key   = env.value.key
            scope = env.value.scope
            type  = env.value.secret ? "SECRET" : "GENERAL"
            value = env.value.secret || env.value.external ? var.env_values["${static_site.value.name}/${env.value.key}"] : env.value.value
          }
        }
      }
    }
  }

  lifecycle {
    # A running app is never recreated from here (AGENTS.md « Import before change »).
    prevent_destroy = true
    # A paging option of the provider's reads, never sent to App Platform; an import leaves it unset.
    ignore_changes = [deployment_per_page]
  }
}
