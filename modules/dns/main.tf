# The provider-neutral interface of DNS records. The adapter is providers/porkbun/dns; the family's records are in stacks/dns.
locals {
  spec = {
    zone    = var.zone
    records = var.records
  }
}
