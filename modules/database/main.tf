# The provider-neutral interface of a managed database cluster: no resource, one normalized `spec` for an adapter.
# Passwords never leave the adapter (no output carries one).
locals {
  spec = {
    name               = var.name
    engine             = var.engine
    engine_version     = var.engine_version
    size               = var.size
    region             = var.region
    node_count         = var.node_count
    private_network_id = var.private_network_id
    tags               = var.tags
    databases          = sort(distinct(var.databases))
    maintenance_window = var.maintenance_window
  }
}
