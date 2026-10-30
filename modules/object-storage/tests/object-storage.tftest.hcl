run "a_private_bucket_with_defaults" {
  command = plan
  variables {
    name   = "yomizaka-documents-prod"
    region = "tor1"
  }
  assert {
    condition     = output.spec.versioning && output.spec.tls_only
    error_message = "Versioned and TLS only by default."
  }
  assert {
    condition     = output.spec.noncurrent_expiration_days == 30 && output.spec.abort_multipart_days == 1
    error_message = "The lifecycle defaults."
  }
  assert {
    condition     = output.spec.key_name == "yomizaka-documents-prod-app"
    error_message = "The key is named after the bucket."
  }
}

run "refuses_a_region_outside_canada" {
  command = plan
  variables {
    name   = "yomizaka-documents-prod"
    region = "nyc3"
  }
  expect_failures = [var.region]
}

run "refuses_a_bad_name" {
  command = plan
  variables {
    name   = "Bad_Name"
    region = "tor1"
  }
  expect_failures = [var.name]
}

run "refuses_a_forever_noncurrent_version" {
  command = plan
  variables {
    name                       = "x-bucket"
    region                     = "tor1"
    noncurrent_expiration_days = 365
  }
  expect_failures = [var.noncurrent_expiration_days]
}
