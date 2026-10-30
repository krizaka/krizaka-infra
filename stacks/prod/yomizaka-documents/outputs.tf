output "admin_screen" {
  description = "What to type in Yomizaka's admin storage screen (kind s3, preset DigitalOcean Spaces). The secret key is read once from the DigitalOcean account, never from here."
  value = {
    endpoint      = module.documents_digitalocean.endpoint
    region        = module.documents_digitalocean.region
    bucket        = module.documents_digitalocean.bucket
    access_key_id = module.documents_digitalocean.access_key_id
  }
}
