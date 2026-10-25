run "records" {
  command = plan
  variables {
    zone    = "orazaka.com"
    records = [{ name = "www", type = "CNAME", value = "orazaka-dev.ondigitalocean.app." }]
  }
  assert {
    condition     = output.spec.records[0].ttl == 600
    error_message = "TTL defaults to 600."
  }
}

run "refuses_an_unknown_type" {
  command = plan
  variables {
    zone    = "orazaka.com"
    records = [{ name = "x", type = "SPF", value = "v=spf1" }]
  }
  expect_failures = [var.records]
}
