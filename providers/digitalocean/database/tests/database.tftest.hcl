mock_provider "digitalocean" {}

run "a_cluster_and_its_databases" {
  command = plan
  variables {
    database = {
      name               = "krizaka-dev-pg"
      engine             = "pg"
      engine_version     = "18"
      size               = "db-s-1vcpu-1gb"
      region             = "tor1"
      node_count         = 1
      private_network_id = "vpc-1"
      tags               = []
      databases          = ["krizaka_users_db", "orazaka_db"]
      maintenance_window = null
    }
  }
  assert {
    condition     = digitalocean_database_cluster.this.version == "18"
    error_message = "The engine version is mapped."
  }
  assert {
    condition     = length(digitalocean_database_db.this) == 2
    error_message = "One database resource per database."
  }
  assert {
    condition     = output.databases == tolist(["krizaka_users_db", "orazaka_db"])
    error_message = "The databases are listed."
  }
}
