# yasakia.com: 15 records, imported as they are at Porkbun (2026-10-25). Order: apps, mail, verification, ACME, nameservers.
locals {
  yasakia_com = {
    # apps and sites
    "apex-alias"  = { name = "@", type = "ALIAS", value = "yasakia-dev-4vnow.ondigitalocean.app", ttl = 600, prio = 0, kind = "app", purpose = "yasakia.com serves the yasakia-dev app (App Platform)" }
    "admin-cname" = { name = "admin", type = "CNAME", value = "yasakia-dev-4vnow.ondigitalocean.app", ttl = 600, prio = 0, kind = "app", purpose = "admin.yasakia.com serves the yasakia-dev app (App Platform)" }
    "dev-cname"   = { name = "dev", type = "CNAME", value = "yasakia-dev-4vnow.ondigitalocean.app", ttl = 600, prio = 0, kind = "app", purpose = "dev.yasakia.com serves the yasakia-dev app (App Platform)" }
    "www-cname"   = { name = "www", type = "CNAME", value = "yasakia-dev-4vnow.ondigitalocean.app", ttl = 600, prio = 0, kind = "app", purpose = "www.yasakia.com serves the yasakia-dev app (App Platform)" }
    # MAIL (Mailgun, Resend, DKIM, SPF, DMARC, forwarding): do not touch without a mail test
    "apex-mx-1"  = { name = "@", type = "MX", value = "fwd1.porkbun.com", ttl = 600, prio = 10, kind = "mail", purpose = "Porkbun email forwarding for yasakia.com (MX, priority 10)" }
    "apex-mx-2"  = { name = "@", type = "MX", value = "fwd2.porkbun.com", ttl = 600, prio = 20, kind = "mail", purpose = "Porkbun email forwarding for yasakia.com (MX, priority 20)" }
    "apex-txt-1" = { name = "@", type = "TXT", value = "v=spf1 include:_spf.porkbun.com ~all", ttl = 600, kind = "mail", purpose = "SPF for Porkbun email forwarding of yasakia.com" }
    "dmarc-txt"  = { name = "_dmarc", type = "TXT", value = "v=DMARC1; p=none; adkim=r; aspf=r", ttl = 600, prio = 0, kind = "mail", purpose = "DMARC policy of yasakia.com (reports only, p=none)" }
    # VERIFICATION (search engines, GitHub, Maven Central): keep, the owner proves the domain with them
    "apex-txt-2" = { name = "@", type = "TXT", value = "google-site-verification=XW4dTI_xJpZUZEcVibZJSEpZkfHPxLSo-223CBmBqcs", ttl = 600, prio = 0, kind = "verification", purpose = "Google Search Console ownership of yasakia.com" }
    # ACME challenges (certificates): kept as they are
    "acme-challenge-txt-1" = { name = "_acme-challenge", type = "TXT", value = "4zVfkZK9SH8DH9zoo9sd2sXbaRc4da2iNm-okmqJPew", ttl = 600, kind = "acme", purpose = "ACME DNS-01 challenge of yasakia.com (certificate issuance), kept as is" }
    "acme-challenge-txt-2" = { name = "_acme-challenge", type = "TXT", value = "JFMnl8aD7aHQ3Y6K9yU8CCNgj5GYCXXRH35X1oec3Kw", ttl = 600, kind = "acme", purpose = "ACME DNS-01 challenge of yasakia.com (certificate issuance), kept as is" }
    # NAMESERVERS (Porkbun defaults)
    "apex-ns-1" = { name = "@", type = "NS", value = "curitiba.porkbun.com", ttl = 86400, kind = "nameserver", purpose = "Porkbun default nameserver of the zone" }
    "apex-ns-2" = { name = "@", type = "NS", value = "fortaleza.porkbun.com", ttl = 86400, kind = "nameserver", purpose = "Porkbun default nameserver of the zone" }
    "apex-ns-3" = { name = "@", type = "NS", value = "maceio.porkbun.com", ttl = 86400, kind = "nameserver", purpose = "Porkbun default nameserver of the zone" }
    "apex-ns-4" = { name = "@", type = "NS", value = "salvador.porkbun.com", ttl = 86400, kind = "nameserver", purpose = "Porkbun default nameserver of the zone" }
  }
}
