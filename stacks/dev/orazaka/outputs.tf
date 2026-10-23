output "app_id" {
  value       = module.orazaka.app_id
  description = "The DigitalOcean ID of the imported `orazaka-dev` app."
}

output "default_url" {
  value       = module.orazaka.default_url
  description = "The app's DigitalOcean default ingress URL."
}
