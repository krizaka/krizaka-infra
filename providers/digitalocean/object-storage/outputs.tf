output "bucket" {
  description = "The bucket's name."
  value       = digitalocean_spaces_bucket.this.name
}

output "endpoint" {
  description = "The S3 endpoint to type in the admin storage screen (no credential)."
  value       = "https://${digitalocean_spaces_bucket.this.region}.digitaloceanspaces.com"
}

output "region" {
  description = "The region to type in the admin storage screen."
  value       = digitalocean_spaces_bucket.this.region
}

output "access_key_id" {
  description = "The id of the application's key. Its secret is never an output: read it once from the state or the DigitalOcean account (docs/SECRETS.md)."
  value       = digitalocean_spaces_key.app.access_key
}
