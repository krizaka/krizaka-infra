# yororis.com: 15 records, imported as they are at Porkbun (2026-10-25). Order: apps, mail, verification, ACME, nameservers.
locals {
  yororis_com = {
    # apps and sites
    "apex-alias" = { name = "@", type = "ALIAS", value = "yororis-qa-dym2p.ondigitalocean.app", ttl = 600, prio = 0, kind = "app", purpose = "yororis.com serves the yororis-qa app (App Platform)" }
    "dev-cname"  = { name = "dev", type = "CNAME", value = "yororis-qa-dym2p.ondigitalocean.app", ttl = 600, prio = 0, kind = "app", purpose = "dev.yororis.com serves the yororis-qa app (App Platform)" }
    "qa-cname"   = { name = "qa", type = "CNAME", value = "yororis-qa-dym2p.ondigitalocean.app", ttl = 600, prio = 0, kind = "app", purpose = "qa.yororis.com serves the yororis-qa app (App Platform)" }
    "www-cname"  = { name = "www", type = "CNAME", value = "yororis-qa-dym2p.ondigitalocean.app", ttl = 600, prio = 0, kind = "app", purpose = "www.yororis.com serves the yororis-qa app (App Platform)" }
    # MAIL (Mailgun, Resend, DKIM, SPF, DMARC, forwarding): do not touch without a mail test
    "apex-mx-1"  = { name = "@", type = "MX", value = "fwd1.porkbun.com", ttl = 600, prio = 10, kind = "mail", purpose = "Porkbun email forwarding for yororis.com (MX, priority 10)" }
    "apex-mx-2"  = { name = "@", type = "MX", value = "fwd2.porkbun.com", ttl = 600, prio = 20, kind = "mail", purpose = "Porkbun email forwarding for yororis.com (MX, priority 20)" }
    "apex-txt-1" = { name = "@", type = "TXT", value = "v=spf1 include:_spf.porkbun.com ~all", ttl = 600, kind = "mail", purpose = "SPF for Porkbun email forwarding of yororis.com" }
    "dmarc-txt"  = { name = "_dmarc", type = "TXT", value = "v=DMARC1; p=none; adkim=r; aspf=r", ttl = 600, prio = 0, kind = "mail", purpose = "DMARC policy of yororis.com (reports only, p=none)" }
    # VERIFICATION (search engines, GitHub, Maven Central): keep, the owner proves the domain with them
    "apex-txt-2" = { name = "@", type = "TXT", value = "google-site-verification=BjVUHqkU31pQd79c9tS95SjPgiTL05X2syxqrkhMkqg", ttl = 600, prio = 0, kind = "verification", purpose = "Google Search Console ownership of yororis.com" }
    # ACME challenges (certificates): kept as they are
    "acme-challenge-txt-1" = { name = "_acme-challenge", type = "TXT", value = "Y5ZRLx_aPH80EADBjB8X07bsGBjHLuD7MfwlaLAXPcY", ttl = 600, kind = "acme", purpose = "ACME DNS-01 challenge of yororis.com (certificate issuance), kept as is" }
    "acme-challenge-txt-2" = { name = "_acme-challenge", type = "TXT", value = "qoVm_JQFV6a-0b-LC46S4ltDHd_xSJCPV2A7x_Gs9as", ttl = 600, kind = "acme", purpose = "ACME DNS-01 challenge of yororis.com (certificate issuance), kept as is" }
    # NAMESERVERS (Porkbun defaults)
    "apex-ns-1" = { name = "@", type = "NS", value = "curitiba.porkbun.com", ttl = 86400, kind = "nameserver", purpose = "Porkbun default nameserver of the zone" }
    "apex-ns-2" = { name = "@", type = "NS", value = "fortaleza.porkbun.com", ttl = 86400, kind = "nameserver", purpose = "Porkbun default nameserver of the zone" }
    "apex-ns-3" = { name = "@", type = "NS", value = "maceio.porkbun.com", ttl = 86400, kind = "nameserver", purpose = "Porkbun default nameserver of the zone" }
    "apex-ns-4" = { name = "@", type = "NS", value = "salvador.porkbun.com", ttl = 86400, kind = "nameserver", purpose = "Porkbun default nameserver of the zone" }
  }
}
