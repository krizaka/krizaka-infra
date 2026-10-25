# The DigitalOcean adapter of the broker role: a droplet, and the firewall that applies to its tags.
resource "digitalocean_droplet" "this" {
  # checkov:skip=CKV_DIO_2: the SSH keys are set when the droplet is created and never read back (ignore_changes below); an imported droplet keeps its own.
  name       = var.broker.name
  region     = var.broker.region
  size       = var.broker.size
  image      = var.broker.image
  vpc_uuid   = var.broker.private_network_id
  tags       = var.broker.tags
  monitoring = var.broker.monitoring

  lifecycle {
    prevent_destroy = true
    # The image, the SSH keys and the first-boot script only matter at creation; the provider cannot read the last two
    # back, and the image's slug moves to newer builds. Changing any of them would recreate the machine.
    ignore_changes = [image, ssh_keys, user_data]
  }
}

resource "digitalocean_firewall" "this" {
  name = var.broker.firewall.name
  tags = var.broker.tags

  dynamic "inbound_rule" {
    for_each = var.broker.firewall.inbound
    content {
      protocol         = inbound_rule.value.protocol
      port_range       = inbound_rule.value.ports
      source_addresses = inbound_rule.value.sources
    }
  }

  dynamic "outbound_rule" {
    for_each = var.broker.firewall.outbound
    content {
      protocol              = outbound_rule.value.protocol
      port_range            = outbound_rule.value.ports
      destination_addresses = outbound_rule.value.destinations
    }
  }

  lifecycle {
    prevent_destroy = true
  }
}
