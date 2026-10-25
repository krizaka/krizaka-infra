output "spec" {
  description = "The normalized storage and pull zones."
  value       = local.spec

  precondition {
    condition     = alltrue([for z in var.pull_zones : z.storage_zone == null || contains(local.storage_names, z.storage_zone)])
    error_message = "pull_zones[*].storage_zone names a storage zone of the list."
  }
}
