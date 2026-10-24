# What runs today, imported into this stack's state (AGENTS.md « Import before change »). Ids are not secrets.
import {
  to = module.app_digitalocean.digitalocean_app.this
  id = "4f0f45c4-3e6f-4f75-9f47-2b4454ed4ab6"
}

import {
  to = module.database_digitalocean.digitalocean_database_cluster.this
  id = "3e31f066-262e-4dbd-9f72-aa5f39bcba6a"
}

import {
  for_each = toset(module.database.spec.databases)
  to       = module.database_digitalocean.digitalocean_database_db.this[each.value]
  id       = "3e31f066-262e-4dbd-9f72-aa5f39bcba6a,${each.value}"
}

import {
  to = module.broker_digitalocean.digitalocean_droplet.this
  id = "609157538"
}

import {
  to = module.broker_digitalocean.digitalocean_firewall.this
  id = "eb197883-3248-4dcb-9366-585212c55160"
}
