output "app_id" {
  value       = digitalocean_app.app.id
  description = "The DigitalOcean app ID."
}

output "default_url" {
  value       = digitalocean_app.app.default_ingress
  description = "The generated default app URL."
}
