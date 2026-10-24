# The provider-neutral interface of DNS records. The adapter (Porkbun, docs/PLAN.md step 5) comes with its stack.
locals {
  spec = {
    zone    = var.zone
    records = var.records
  }
}
