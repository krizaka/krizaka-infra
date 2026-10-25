# orazaka.com: 16 records, imported as they are at Porkbun (2026-10-25). Order: apps, mail, verification, ACME, nameservers.
locals {
  orazaka_com = {
    # apps and sites
    "apex-alias"   = { name = "@", type = "ALIAS", value = "orazaka-dev-averr.ondigitalocean.app", ttl = 600, prio = 0, kind = "app", purpose = "orazaka.com serves the orazaka-dev app (App Platform)" }
    "admin-cname"  = { name = "admin", type = "CNAME", value = "orazaka-dev-averr.ondigitalocean.app", ttl = 600, prio = 0, kind = "app", purpose = "admin.orazaka.com serves the orazaka-dev app (App Platform)" }
    "broker-dev-a" = { name = "broker-dev", type = "A", value = "10.118.0.8", ttl = 600, prio = 0, kind = "app", purpose = "private address of orazaka-broker-dev (RabbitMQ) in the DigitalOcean VPC" }
    "dev-cname"    = { name = "dev", type = "CNAME", value = "orazaka-dev-averr.ondigitalocean.app", ttl = 600, prio = 0, kind = "app", purpose = "dev.orazaka.com serves the orazaka-dev app (App Platform)" }
    "www-cname"    = { name = "www", type = "CNAME", value = "orazaka-dev-averr.ondigitalocean.app", ttl = 600, prio = 0, kind = "app", purpose = "www.orazaka.com serves the orazaka-dev app (App Platform)" }
    # MAIL (Mailgun, Resend, DKIM, SPF, DMARC, forwarding): do not touch without a mail test
    "apex-mx-1"  = { name = "@", type = "MX", value = "fwd1.porkbun.com", ttl = 600, prio = 10, kind = "mail", purpose = "Porkbun email forwarding for orazaka.com (MX, priority 10)" }
    "apex-mx-2"  = { name = "@", type = "MX", value = "fwd2.porkbun.com", ttl = 600, prio = 20, kind = "mail", purpose = "Porkbun email forwarding for orazaka.com (MX, priority 20)" }
    "apex-txt-1" = { name = "@", type = "TXT", value = "v=spf1 include:_spf.porkbun.com ~all", ttl = 600, kind = "mail", purpose = "SPF for Porkbun email forwarding of orazaka.com" }
    "dmarc-txt"  = { name = "_dmarc", type = "TXT", value = "v=DMARC1; p=none; adkim=r; aspf=r", ttl = 600, prio = 0, kind = "mail", purpose = "DMARC policy of orazaka.com (reports only, p=none)" }
    # VERIFICATION (search engines, GitHub, Maven Central): keep, the owner proves the domain with them
    "apex-txt-2" = { name = "@", type = "TXT", value = "google-site-verification=XTNRjsXwGQA0uCwFSGts8WhMar8vB386QSFqLpQzQWc", ttl = 600, prio = 0, kind = "verification", purpose = "Google Search Console ownership of orazaka.com" }
    # ACME challenges (certificates): kept as they are
    "acme-challenge-txt-1" = { name = "_acme-challenge", type = "TXT", value = "Xo99X_teUpUkFEcr0H48-rrF81FJwsjlv_rUjR4KnF0", ttl = 600, kind = "acme", purpose = "ACME DNS-01 challenge of orazaka.com (certificate issuance), kept as is" }
    "acme-challenge-txt-2" = { name = "_acme-challenge", type = "TXT", value = "hPRLEMpSOJazberkoSGbTEVmuoxHf42g5h2m-JOHcr0", ttl = 600, kind = "acme", purpose = "ACME DNS-01 challenge of orazaka.com (certificate issuance), kept as is" }
    # NAMESERVERS (Porkbun defaults)
    "apex-ns-1" = { name = "@", type = "NS", value = "curitiba.porkbun.com", ttl = 86400, kind = "nameserver", purpose = "Porkbun default nameserver of the zone" }
    "apex-ns-2" = { name = "@", type = "NS", value = "fortaleza.porkbun.com", ttl = 86400, kind = "nameserver", purpose = "Porkbun default nameserver of the zone" }
    "apex-ns-3" = { name = "@", type = "NS", value = "maceio.porkbun.com", ttl = 86400, kind = "nameserver", purpose = "Porkbun default nameserver of the zone" }
    "apex-ns-4" = { name = "@", type = "NS", value = "salvador.porkbun.com", ttl = 86400, kind = "nameserver", purpose = "Porkbun default nameserver of the zone" }
  }
}
