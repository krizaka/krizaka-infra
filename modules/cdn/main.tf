# The provider-neutral interface of a CDN: storage zones and the pull zones in front. The adapter (Bunny, docs/PLAN.md
# step 7, read-only first) comes with its stack.
locals {
  storage_names = [for z in var.storage_zones : z.name]
  spec = {
    storage_zones = var.storage_zones
    pull_zones    = var.pull_zones
  }
}
