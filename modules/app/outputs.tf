output "spec" {
  description = "The normalized app, without any secret value: what an adapter turns into provider resources."
  value       = local.spec

  precondition {
    condition     = length(local.components) > 0
    error_message = "An app has at least one service or static site."
  }
  precondition {
    condition     = length(local.components) == length(distinct(local.components))
    error_message = "Component names are unique within an app."
  }
  precondition {
    condition     = alltrue([for e in local.all_envs : contains(local.env_scopes, e.scope)])
    error_message = "envs[*].scope: RUN_TIME, BUILD_TIME or RUN_AND_BUILD_TIME."
  }
  precondition {
    condition     = alltrue([for e in local.all_envs : (e.secret || e.external) == (e.value == null)])
    error_message = "An env has a value in code, or is secret/external and takes it from env_values: never both."
  }
  precondition {
    condition     = alltrue([for r in var.ingress_rules : r.component == null || contains(local.components, r.component)])
    error_message = "ingress_rules[*].component names a component of the app."
  }
  precondition {
    condition     = length(local.missing_env_values) == 0
    error_message = "env_values lacks: ${join(", ", sort(local.missing_env_values))}."
  }
}

output "env_values" {
  description = "The secret and external env values, passed through to the adapter (sensitive)."
  value       = var.env_values
  sensitive   = true
}

output "required_env_values" {
  description = "The \"<component>/<KEY>\" names the caller must give in env_values."
  value       = local.required_env_values
}
