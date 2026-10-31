mock_provider "ovh" {}

variables {
  project_id = "00000000000000000000000000000000"
  storage = {
    env                        = "dev"
    primary_bucket             = "docs-dev"
    replica_bucket             = "docs-dev-replica"
    primary_region             = "bhs"
    replica_region             = "ca-east-tor"
    versioning                 = true
    tls_only                   = true
    noncurrent_expiration_days = 30
    trash_prefix               = "trash/"
    trash_expiration_days      = 30
    abort_multipart_days       = 1
    replica_lock_days          = 30
    users = {
      service = { primary = ["read", "write", "delete"], replica = ["read"] }
      drills  = { primary = ["read"], replica = ["read"] }
    }
  }
}

run "replicated_versioned_buckets_and_two_users" {
  command = plan
  assert {
    condition     = ovh_cloud_project_storage.primary.name == "docs-dev" && ovh_cloud_project_storage.replica.name == "docs-dev-replica"
    error_message = "Two buckets named after the environment."
  }
  assert {
    condition     = ovh_cloud_project_storage.replica.object_lock.rule.mode == "governance" && ovh_cloud_project_storage.replica.object_lock.rule.period == "P30D"
    error_message = "The replica is under a 30-day governance lock."
  }
  assert {
    condition     = length(ovh_cloud_project_user.this) == 2
    error_message = "One user per role of the spec."
  }
}

run "refuses_a_region_outside_canada" {
  command = plan
  variables {
    storage = {
      env                        = "dev"
      primary_bucket             = "docs-dev"
      replica_bucket             = "docs-dev-replica"
      primary_region             = "gra"
      replica_region             = "ca-east-tor"
      versioning                 = true
      tls_only                   = true
      noncurrent_expiration_days = 30
      trash_prefix               = "trash/"
      trash_expiration_days      = 30
      abort_multipart_days       = 1
      replica_lock_days          = 30
      users                      = {}
    }
  }
  expect_failures = [ovh_cloud_project_storage.primary]
}
