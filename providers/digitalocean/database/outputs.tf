output "id" {
  description = "The cluster id."
  value       = digitalocean_database_cluster.this.id
}

output "private_host" {
  description = "The cluster's host inside the VPC (no credential)."
  value       = digitalocean_database_cluster.this.private_host
}

output "port" {
  description = "The cluster's port."
  value       = digitalocean_database_cluster.this.port
}

output "databases" {
  description = "The databases kept on the cluster."
  value       = sort(keys(digitalocean_database_db.this))
}
