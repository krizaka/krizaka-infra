# kachizaka.com: 13 records, imported as they are at Porkbun (2026-10-25). Order: apps, mail, verification, ACME, nameservers.
locals {
  kachizaka_com = {
    # apps and sites
    "apex-alias"  = { name = "@", type = "ALIAS", value = "kachizaka-dev-smmnz.ondigitalocean.app", ttl = 600, prio = 0, kind = "app", purpose = "kachizaka.com serves the kachizaka-dev app (App Platform)" }
    "admin-cname" = { name = "admin", type = "CNAME", value = "kachizaka-dev-smmnz.ondigitalocean.app", ttl = 600, prio = 0, kind = "app", purpose = "admin.kachizaka.com serves the kachizaka-dev app (App Platform)" }
    "dev-cname"   = { name = "dev", type = "CNAME", value = "kachizaka-dev-smmnz.ondigitalocean.app", ttl = 600, prio = 0, kind = "app", purpose = "dev.kachizaka.com serves the kachizaka-dev app (App Platform)" }
    "www-cname"   = { name = "www", type = "CNAME", value = "kachizaka-dev-smmnz.ondigitalocean.app", ttl = 600, prio = 0, kind = "app", purpose = "www.kachizaka.com serves the kachizaka-dev app (App Platform)" }
    # MAIL (Mailgun, Resend, DKIM, SPF, DMARC, forwarding): do not touch without a mail test
    "apex-mx-1" = { name = "@", type = "MX", value = "fwd1.porkbun.com", ttl = 600, prio = 10, kind = "mail", purpose = "Porkbun email forwarding for kachizaka.com (MX, priority 10)" }
    "apex-mx-2" = { name = "@", type = "MX", value = "fwd2.porkbun.com", ttl = 600, prio = 20, kind = "mail", purpose = "Porkbun email forwarding for kachizaka.com (MX, priority 20)" }
    "apex-txt"  = { name = "@", type = "TXT", value = "v=spf1 include:_spf.porkbun.com ~all", ttl = 600, kind = "mail", purpose = "SPF for Porkbun email forwarding of kachizaka.com" }
    # ACME challenges (certificates): kept as they are
    "acme-challenge-txt-1" = { name = "_acme-challenge", type = "TXT", value = "O03a3ErkvR6RUyHLtO1HsgGzhAedPqUeSjNOeGzkmZg", ttl = 600, kind = "acme", purpose = "ACME DNS-01 challenge of kachizaka.com (certificate issuance), kept as is" }
    "acme-challenge-txt-2" = { name = "_acme-challenge", type = "TXT", value = "OVjEx1uca5L3lGQFZfJg8Jvl0W5B9vVcVXL2U6ooNKo", ttl = 600, kind = "acme", purpose = "ACME DNS-01 challenge of kachizaka.com (certificate issuance), kept as is" }
    # NAMESERVERS (Porkbun defaults)
    "apex-ns-1" = { name = "@", type = "NS", value = "curitiba.porkbun.com", ttl = 86400, kind = "nameserver", purpose = "Porkbun default nameserver of the zone" }
    "apex-ns-2" = { name = "@", type = "NS", value = "fortaleza.porkbun.com", ttl = 86400, kind = "nameserver", purpose = "Porkbun default nameserver of the zone" }
    "apex-ns-3" = { name = "@", type = "NS", value = "maceio.porkbun.com", ttl = 86400, kind = "nameserver", purpose = "Porkbun default nameserver of the zone" }
    "apex-ns-4" = { name = "@", type = "NS", value = "salvador.porkbun.com", ttl = 86400, kind = "nameserver", purpose = "Porkbun default nameserver of the zone" }
  }
}
