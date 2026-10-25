output "id" {
  description = "The droplet id."
  value       = digitalocean_droplet.this.id
}

output "private_ip" {
  description = "The droplet's address inside the VPC."
  value       = digitalocean_droplet.this.ipv4_address_private
}

output "firewall_id" {
  description = "The firewall id."
  value       = digitalocean_firewall.this.id
}
