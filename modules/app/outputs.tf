output "name" {
  value       = var.name
  description = "The logical app name."
}

output "region" {
  value       = var.region
  description = "The deployment region."
}

output "components" {
  value       = var.components
  description = "The configured services and static sites."
}

output "sensitive_env_vars" {
  value       = var.sensitive_env_vars
  sensitive   = true
  description = "Sensitive component env vars."
}

output "domains" {
  value       = var.domains
  description = "The configured custom domains."
}

output "ingress_rules" {
  value       = var.ingress_rules
  description = "The configured ingress routes."
}

output "features" {
  value       = var.features
  description = "App-level features."
}

output "vpc_id" {
  value       = var.vpc_id
  description = "The private network identifier, when configured."
}
