# akinaza.com: 15 records, imported as they are at Porkbun (2026-10-25). Order: apps, mail, verification, ACME, nameservers.
locals {
  akinaza_com = {
    # apps and sites
    "apex-alias"     = { name = "@", type = "ALIAS", value = "akinaza-dev-hfdcl.ondigitalocean.app", ttl = 600, prio = 0, kind = "app", purpose = "akinaza.com serves the akinaza-dev app (App Platform)" }
    "wildcard-cname" = { name = "*", type = "CNAME", value = "akinaza-dev-hfdcl.ondigitalocean.app", ttl = 600, prio = 0, kind = "app", purpose = "*.akinaza.com serves the akinaza-dev app (App Platform)" }
    "admin-cname"    = { name = "admin", type = "CNAME", value = "akinaza-dev-hfdcl.ondigitalocean.app", ttl = 600, prio = 0, kind = "app", purpose = "admin.akinaza.com serves the akinaza-dev app (App Platform)" }
    "dev-cname"      = { name = "dev", type = "CNAME", value = "akinaza-dev-hfdcl.ondigitalocean.app", ttl = 600, prio = 0, kind = "app", purpose = "dev.akinaza.com serves the akinaza-dev app (App Platform)" }
    "www-cname"      = { name = "www", type = "CNAME", value = "akinaza-dev-hfdcl.ondigitalocean.app", ttl = 600, prio = 0, kind = "app", purpose = "www.akinaza.com serves the akinaza-dev app (App Platform)" }
    # MAIL (Mailgun, Resend, DKIM, SPF, DMARC, forwarding): do not touch without a mail test
    "apex-mx-1" = { name = "@", type = "MX", value = "fwd1.porkbun.com", ttl = 600, prio = 10, kind = "mail", purpose = "Porkbun email forwarding for akinaza.com (MX, priority 10)" }
    "apex-mx-2" = { name = "@", type = "MX", value = "fwd2.porkbun.com", ttl = 600, prio = 20, kind = "mail", purpose = "Porkbun email forwarding for akinaza.com (MX, priority 20)" }
    "apex-txt"  = { name = "@", type = "TXT", value = "v=spf1 include:_spf.porkbun.com ~all", ttl = 600, kind = "mail", purpose = "SPF for Porkbun email forwarding of akinaza.com" }
    # ACME challenges (certificates): kept as they are
    "acme-challenge-txt-1" = { name = "_acme-challenge", type = "TXT", value = "B7UBWC4p824lHeWxfzHgaqzbgcVdtX_51BClppAwSEA", ttl = 600, prio = 0, kind = "acme", purpose = "ACME DNS-01 challenge of akinaza.com (certificate issuance), kept as is" }
    "acme-challenge-txt-2" = { name = "_acme-challenge", type = "TXT", value = "R9AMnIn9MqQnwb1-1ap9HZOeZPJwDQL1PT6RsQ_4O3k", ttl = 600, kind = "acme", purpose = "ACME DNS-01 challenge of akinaza.com (certificate issuance), kept as is" }
    "acme-challenge-txt-3" = { name = "_acme-challenge", type = "TXT", value = "xYDossY_TuC8wirJWMMvgGavygRR5x4kJ9o9noK-NGQ", ttl = 600, kind = "acme", purpose = "ACME DNS-01 challenge of akinaza.com (certificate issuance), kept as is" }
    # NAMESERVERS (Porkbun defaults)
    "apex-ns-1" = { name = "@", type = "NS", value = "curitiba.porkbun.com", ttl = 86400, kind = "nameserver", purpose = "Porkbun default nameserver of the zone" }
    "apex-ns-2" = { name = "@", type = "NS", value = "fortaleza.porkbun.com", ttl = 86400, kind = "nameserver", purpose = "Porkbun default nameserver of the zone" }
    "apex-ns-3" = { name = "@", type = "NS", value = "maceio.porkbun.com", ttl = 86400, kind = "nameserver", purpose = "Porkbun default nameserver of the zone" }
    "apex-ns-4" = { name = "@", type = "NS", value = "salvador.porkbun.com", ttl = 86400, kind = "nameserver", purpose = "Porkbun default nameserver of the zone" }
  }
}
