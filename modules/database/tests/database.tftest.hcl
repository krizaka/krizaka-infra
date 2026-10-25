run "a_cluster_and_its_databases" {
  command = plan
  variables {
    name           = "krizaka-dev-pg"
    engine         = "pg"
    engine_version = "18"
    size           = "db-s-1vcpu-1gb"
    region         = "tor1"
    databases      = ["orazaka_db", "krizaka_users_db", "orazaka_db"]
  }
  assert {
    condition     = output.spec.databases == tolist(["krizaka_users_db", "orazaka_db"])
    error_message = "Databases are sorted and unique."
  }
}

run "refuses_an_unknown_engine" {
  command = plan
  variables {
    name           = "x"
    engine         = "oracle"
    engine_version = "1"
    size           = "s"
    region         = "tor1"
  }
  expect_failures = [var.engine]
}

run "refuses_a_bad_database_name" {
  command = plan
  variables {
    name           = "x"
    engine         = "pg"
    engine_version = "18"
    size           = "s"
    region         = "tor1"
    databases      = ["Bad-Name"]
  }
  expect_failures = [var.databases]
}
