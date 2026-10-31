output "primary_bucket" {
  description = "The writable bucket's name."
  value       = ovh_cloud_project_storage.primary.name
}

output "replica_bucket" {
  description = "The replica bucket's name."
  value       = ovh_cloud_project_storage.replica.name
}

output "access_key_ids" {
  description = "The access key id of each user (service, drills). Secrets are never outputs: they stay sensitive in the state and are copied once to the vault (docs/SECRETS.md)."
  value       = { for k, c in ovh_cloud_project_user_s3_credential.this : k => c.access_key_id }
}

output "okms_root_key_id" {
  description = "The id of the environment's root key in OKMS."
  value       = ovh_okms_service_key.root.id
}
