run "two_versioned_buckets_named_after_the_environment" {
  command = plan
  variables {
    env            = "dev"
    primary_region = "bhs"
    replica_region = "ca-east-tor"
  }
  assert {
    condition     = output.spec.primary_bucket == "docs-dev" && output.spec.replica_bucket == "docs-dev-replica"
    error_message = "Buckets are docs-<env> and docs-<env>-replica."
  }
  assert {
    condition     = output.spec.versioning && output.spec.tls_only && output.spec.replica_lock_days == 30
    error_message = "Versioned, TLS only, locked replica by default."
  }
  assert {
    condition     = output.spec.users.drills.primary == ["read"] && !contains(output.spec.users.service.replica, "delete")
    error_message = "Drills read only; nobody deletes on the replica."
  }
}

run "refuses_the_same_region_twice" {
  command = plan
  variables {
    env            = "prod"
    primary_region = "bhs"
    replica_region = "bhs"
  }
  expect_failures = [var.replica_region]
}

run "refuses_an_unknown_environment" {
  command = plan
  variables {
    env            = "staging"
    primary_region = "bhs"
    replica_region = "ca-east-tor"
  }
  expect_failures = [var.env]
}
