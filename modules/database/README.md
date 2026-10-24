# modules/database — a managed database cluster (role)

The provider-neutral interface of a managed database cluster and the databases kept on it. Users, roles and passwords
stay with the products' migrations; no output ever carries a password. No resource here: one `spec` for an adapter
(`providers/digitalocean/database`).

| Input | Type | |
| :--- | :--- | :--- |
| `name`, `engine`, `engine_version`, `size`, `region` | string | required; a live cluster keeps its name and region |
| `node_count` | number | 1 to 3, default 1 |
| `private_network_id` | string | optional |
| `tags` | list(string) | default `[]` |
| `databases` | list(string) | lowercase identifiers |
| `maintenance_window` | {day, hour} | optional |

Output: `spec`.

```hcl
module "database" {
  source         = "../../../modules/database"
  name           = "krizaka-dev-pg"
  engine         = "pg"
  engine_version = "18"
  size           = "db-s-1vcpu-1gb"
  region         = "tor1"
  databases      = ["orazaka_db"]
}

module "database_digitalocean" {
  source   = "../../../providers/digitalocean/database"
  database = module.database.spec
}
```

Tests: `tofu test` (offline).
