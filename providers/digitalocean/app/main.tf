module "app" {
  source = "../../../modules/app"

  name               = var.name
  region             = var.region
  components         = var.components
  service_order      = var.service_order
  sensitive_env_vars = var.sensitive_env_vars
  domains            = var.domains
  ingress_rules      = var.ingress_rules
  features           = var.features
  vpc_id             = var.vpc_id
}

locals {
  env_keys = {
    for name, component in module.app.components :
    name => toset(concat(
      keys(component.env_vars),
      nonsensitive(keys(lookup(module.app.sensitive_env_vars, name, {})))
    ))
  }
}

resource "digitalocean_app" "app" {
  spec {
    name     = module.app.name
    region   = module.app.region
    features = module.app.features

    dynamic "domain" {
      for_each = module.app.domains
      content {
        name = domain.value.domain
        type = domain.value.type
      }
    }

    dynamic "service" {
      for_each = [
        for name in module.app.service_order : {
          name      = name
          component = module.app.components[name]
        }
      ]

      content {
        name               = service.value.name
        instance_count     = service.value.component.instance_count
        instance_size_slug = service.value.component.instance_size
        environment_slug   = service.value.component.environment_slug
        build_command      = service.value.component.build_command
        dockerfile_path    = service.value.component.dockerfile_path
        source_dir         = service.value.component.source_dir
        run_command        = service.value.component.run_command
        http_port          = service.value.component.http_port
        internal_ports     = service.value.component.internal_ports

        github {
          repo           = service.value.component.source_repository
          branch         = service.value.component.branch
          deploy_on_push = service.value.component.deploy_on_push
        }

        dynamic "health_check" {
          for_each = service.value.component.health_check == null ? [] : [service.value.component.health_check]
          content {
            http_path             = health_check.value.http_path
            initial_delay_seconds = health_check.value.initial_delay_seconds
            period_seconds        = health_check.value.period_seconds
            timeout_seconds       = health_check.value.timeout_seconds
            success_threshold     = health_check.value.success_threshold
            failure_threshold     = health_check.value.failure_threshold
            port                  = health_check.value.port
          }
        }

        dynamic "env" {
          for_each = local.env_keys[service.value.name]
          content {
            key = env.value
            value = contains(keys(service.value.component.env_vars), env.value) ? (
              service.value.component.env_vars[env.value].value
              ) : (
              module.app.sensitive_env_vars[service.value.name][env.value].value
            )
            scope = contains(keys(service.value.component.env_vars), env.value) ? (
              service.value.component.env_vars[env.value].scope
              ) : (
              module.app.sensitive_env_vars[service.value.name][env.value].scope
            )
            type = contains(keys(service.value.component.env_vars), env.value) ? "GENERAL" : (
              module.app.sensitive_env_vars[service.value.name][env.value].secret ? "SECRET" : "GENERAL"
            )
          }
        }
      }
    }

    dynamic "static_site" {
      for_each = {
        for name, component in module.app.components : name => component
        if component.kind == "static_site"
      }

      content {
        name             = static_site.key
        build_command    = static_site.value.build_command
        dockerfile_path  = static_site.value.dockerfile_path
        environment_slug = static_site.value.environment_slug
        output_dir       = static_site.value.output_dir
        source_dir       = static_site.value.source_dir

        github {
          repo           = static_site.value.source_repository
          branch         = static_site.value.branch
          deploy_on_push = static_site.value.deploy_on_push
        }

        dynamic "env" {
          for_each = local.env_keys[static_site.key]
          content {
            key = env.value
            value = contains(keys(static_site.value.env_vars), env.value) ? (
              static_site.value.env_vars[env.value].value
              ) : (
              module.app.sensitive_env_vars[static_site.key][env.value].value
            )
            scope = contains(keys(static_site.value.env_vars), env.value) ? (
              static_site.value.env_vars[env.value].scope
              ) : (
              module.app.sensitive_env_vars[static_site.key][env.value].scope
            )
            type = contains(keys(static_site.value.env_vars), env.value) ? "GENERAL" : (
              module.app.sensitive_env_vars[static_site.key][env.value].secret ? "SECRET" : "GENERAL"
            )
          }
        }
      }
    }

    dynamic "ingress" {
      for_each = length(module.app.ingress_rules) == 0 ? [] : [module.app.ingress_rules]
      content {
        dynamic "rule" {
          for_each = ingress.value
          content {
            dynamic "component" {
              for_each = rule.value.component == null ? [] : [rule.value.component]
              content {
                name = component.value
              }
            }

            dynamic "match" {
              for_each = [rule.value]
              content {
                dynamic "path" {
                  for_each = match.value.path_prefix == null ? [] : [match.value.path_prefix]
                  content {
                    prefix = path.value
                  }
                }

                dynamic "authority" {
                  for_each = match.value.authority_exact == null ? [] : [match.value.authority_exact]
                  content {
                    exact = authority.value
                  }
                }
              }
            }

            dynamic "redirect" {
              for_each = rule.value.redirect_authority == null ? [] : [rule.value]
              content {
                authority     = redirect.value.redirect_authority
                redirect_code = redirect.value.redirect_code
              }
            }
          }
        }
      }
    }

    dynamic "vpc" {
      for_each = nonsensitive(module.app.vpc_id) == null ? [] : [true]
      content {
        id = module.app.vpc_id
      }
    }
  }
}
