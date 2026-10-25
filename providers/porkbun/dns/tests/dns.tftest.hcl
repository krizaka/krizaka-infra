mock_provider "porkbun" {}

run "the_apex_is_an_empty_subdomain" {
  command = plan
  variables {
    zone = "orazaka.com"
    records = {
      apex = { name = "@", type = "ALIAS", value = "orazaka-dev.ondigitalocean.app", ttl = 600 }
      www  = { name = "www", type = "CNAME", value = "orazaka-dev.ondigitalocean.app", ttl = 600 }
      mx   = { name = "@", type = "MX", value = "fwd1.porkbun.com", ttl = 600, prio = 10 }
    }
  }
  assert {
    condition     = porkbun_dns_record.this["apex"].subdomain == ""
    error_message = "The apex is an empty subdomain."
  }
  assert {
    condition     = porkbun_dns_record.this["www"].subdomain == "www" && porkbun_dns_record.this["www"].domain == "orazaka.com"
    error_message = "A subdomain keeps its label, in the zone."
  }
  assert {
    condition     = porkbun_dns_record.this["mx"].prio == 10
    error_message = "The MX priority is kept."
  }
}

run "an_unmanaged_record_is_skipped" {
  command = plan
  variables {
    zone = "krizaka.com"
    records = {
      kept   = { name = "a", type = "CNAME", value = "x.example.com", ttl = 600 }
      listed = { name = "b", type = "CNAME", value = "y.example.com", ttl = 300, managed = false }
    }
  }
  assert {
    condition     = length(porkbun_dns_record.this) == 1 && contains(keys(porkbun_dns_record.this), "kept")
    error_message = "A record with managed = false is never created."
  }
}

run "refuses_a_short_ttl_on_a_managed_record" {
  command = plan
  variables {
    zone    = "krizaka.com"
    records = { short = { name = "a", type = "CNAME", value = "x.example.com", ttl = 300 } }
  }
  expect_failures = [var.records]
}
