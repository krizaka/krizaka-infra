run "records" {
  command = plan
  variables {
    zone = "orazaka.com"
    records = {
      "www-cname" = { name = "www", type = "CNAME", value = "orazaka-dev.ondigitalocean.app", purpose = "www serves orazaka-dev" }
      "apex-spf"  = { name = "@", type = "TXT", value = "v=spf1 ~all", kind = "mail", purpose = "SPF" }
    }
  }
  assert {
    condition     = output.spec.records["www-cname"].ttl == 600
    error_message = "TTL defaults to 600."
  }
  assert {
    condition     = output.spec.records["www-cname"].kind == "app"
    error_message = "A record is an app record unless it says otherwise."
  }
  assert {
    condition     = output.spec.records["www-cname"].managed
    error_message = "A record is managed unless it says otherwise."
  }
  assert {
    condition     = length(output.mail_records) == 1 && output.mail_records[0] == "apex-spf"
    error_message = "The mail records are listed apart."
  }
}

run "refuses_an_unknown_type" {
  command = plan
  variables {
    zone    = "orazaka.com"
    records = { x = { name = "x", type = "SPF", value = "v=spf1", purpose = "x" } }
  }
  expect_failures = [var.records]
}

run "refuses_a_record_without_purpose" {
  command = plan
  variables {
    zone    = "orazaka.com"
    records = { x = { name = "x", type = "A", value = "10.0.0.1", purpose = " " } }
  }
  expect_failures = [var.records]
}

run "refuses_a_cname_at_the_apex" {
  command = plan
  variables {
    zone    = "orazaka.com"
    records = { x = { name = "@", type = "CNAME", value = "a.example.com", purpose = "x" } }
  }
  expect_failures = [var.records]
}

run "refuses_a_short_ttl" {
  command = plan
  variables {
    zone    = "orazaka.com"
    records = { x = { name = "x", type = "A", value = "10.0.0.1", ttl = 30, purpose = "x" } }
  }
  expect_failures = [var.records]
}
