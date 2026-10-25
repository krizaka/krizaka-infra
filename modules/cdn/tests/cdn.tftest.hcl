run "a_storage_zone_and_its_pull_zone" {
  command = plan
  variables {
    storage_zones = [{ name = "krizaka-assets", region = "NY" }]
    pull_zones    = [{ name = "krizaka-assets", storage_zone = "krizaka-assets" }]
  }
  assert {
    condition     = length(output.spec.pull_zones) == 1
    error_message = "The pull zone is kept."
  }
}

run "refuses_an_unknown_storage_zone" {
  command = plan
  variables {
    pull_zones = [{ name = "x", storage_zone = "nope" }]
  }
  expect_failures = [output.spec]
}
