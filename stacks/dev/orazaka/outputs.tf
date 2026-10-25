output "app_id" {
  description = "orazaka-dev's App Platform id."
  value       = module.app_digitalocean.id
}

output "app_default_url" {
  description = "orazaka-dev's default ingress URL."
  value       = module.app_digitalocean.default_url
}

output "required_env_values" {
  description = "The keys TF_VAR_env_values must hold."
  value       = module.app.required_env_values
}
