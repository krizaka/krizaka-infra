# The DigitalOcean adapter of the database role: a managed cluster and the databases kept on it.
resource "digitalocean_database_cluster" "this" {
  name                 = var.database.name
  engine               = var.database.engine
  version              = var.database.engine_version
  size                 = var.database.size
  region               = var.database.region
  node_count           = var.database.node_count
  private_network_uuid = var.database.private_network_id
  tags                 = var.database.tags

  dynamic "maintenance_window" {
    for_each = var.database.maintenance_window == null ? [] : [var.database.maintenance_window]
    content {
      day  = maintenance_window.value.day
      hour = maintenance_window.value.hour
    }
  }

  # A running cluster is never recreated from here (AGENTS.md « Import before change »).
  lifecycle {
    prevent_destroy = true
  }
}

resource "digitalocean_database_db" "this" {
  for_each   = toset(var.database.databases)
  cluster_id = digitalocean_database_cluster.this.id
  name       = each.value

  lifecycle {
    prevent_destroy = true
  }
}
