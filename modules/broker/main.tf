# The provider-neutral interface of a message broker host: one machine and its firewall. No resource here.
locals {
  spec = {
    name               = var.name
    region             = var.region
    size               = var.size
    image              = var.image
    private_network_id = var.private_network_id
    tags               = var.tags
    monitoring         = var.monitoring
    firewall           = var.firewall
  }
}
