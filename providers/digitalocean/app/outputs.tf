output "id" {
  description = "The App Platform app id."
  value       = digitalocean_app.this.id
}

output "default_url" {
  description = "The app's default ingress URL (*.ondigitalocean.app)."
  value       = digitalocean_app.this.default_ingress
}

output "live_url" {
  description = "The app's live URL (its primary domain once set)."
  value       = digitalocean_app.this.live_url
}
