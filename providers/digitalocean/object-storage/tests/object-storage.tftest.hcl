mock_provider "digitalocean" {}

run "a_private_versioned_bucket_in_toronto" {
  command = plan
  variables {
    bucket = {
      name                       = "yomizaka-documents-prod"
      region                     = "tor1"
      versioning                 = true
      noncurrent_expiration_days = 30
      abort_multipart_days       = 1
      tls_only                   = true
      key_name                   = "yomizaka-documents-prod-app"
    }
  }
  assert {
    condition     = digitalocean_spaces_bucket.this.acl == "private" && digitalocean_spaces_bucket.this.region == "tor1"
    error_message = "Private, in Toronto."
  }
  assert {
    condition     = length(digitalocean_spaces_bucket.this.lifecycle_rule) == 2
    error_message = "One rule for unfinished uploads, one for previous versions."
  }
  assert {
    condition     = digitalocean_spaces_key.app.grant[0].permission == "readwrite" && digitalocean_spaces_key.app.grant[0].bucket == "yomizaka-documents-prod"
    error_message = "The key is limited to this bucket."
  }
  assert {
    condition     = strcontains(digitalocean_spaces_bucket_policy.tls_only.policy, "aws:SecureTransport")
    error_message = "Plain HTTP is refused."
  }
  assert {
    condition     = output.endpoint == "https://tor1.digitaloceanspaces.com"
    error_message = "The endpoint is the one the admin screen takes."
  }
}

run "without_versioning_there_is_no_version_rule" {
  command = plan
  variables {
    bucket = {
      name                       = "yomizaka-documents-prod"
      region                     = "tor1"
      versioning                 = false
      noncurrent_expiration_days = 30
      abort_multipart_days       = 1
      tls_only                   = true
      key_name                   = "k"
    }
  }
  assert {
    condition     = length(digitalocean_spaces_bucket.this.lifecycle_rule) == 1
    error_message = "Only the unfinished-uploads rule."
  }
}
