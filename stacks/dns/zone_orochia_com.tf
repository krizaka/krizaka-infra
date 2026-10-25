# orochia.com: 18 records, imported as they are at Porkbun (2026-10-25). Order: apps, mail, verification, ACME, nameservers.
locals {
  orochia_com = {
    # apps and sites
    "apex-alias"  = { name = "@", type = "ALIAS", value = "orochia-dev-khrnh.ondigitalocean.app", ttl = 600, prio = 0, kind = "app", purpose = "orochia.com serves the orochia-dev app (App Platform)" }
    "admin-cname" = { name = "admin", type = "CNAME", value = "orochia-dev-khrnh.ondigitalocean.app", ttl = 600, prio = 0, kind = "app", purpose = "admin.orochia.com serves the orochia-dev app (App Platform)" }
    "dev-cname"   = { name = "dev", type = "CNAME", value = "orochia-dev-khrnh.ondigitalocean.app", ttl = 600, prio = 0, kind = "app", purpose = "dev.orochia.com serves the orochia-dev app (App Platform)" }
    "www-cname"   = { name = "www", type = "CNAME", value = "orochia-dev-khrnh.ondigitalocean.app", ttl = 600, prio = 0, kind = "app", purpose = "www.orochia.com serves the orochia-dev app (App Platform)" }
    # MAIL (Mailgun, Resend, DKIM, SPF, DMARC, forwarding): do not touch without a mail test
    "apex-mx-1"                = { name = "@", type = "MX", value = "fwd1.porkbun.com", ttl = 600, prio = 10, kind = "mail", purpose = "Porkbun email forwarding for orochia.com (MX, priority 10)" }
    "apex-mx-2"                = { name = "@", type = "MX", value = "fwd2.porkbun.com", ttl = 600, prio = 20, kind = "mail", purpose = "Porkbun email forwarding for orochia.com (MX, priority 20)" }
    "apex-txt-1"               = { name = "@", type = "TXT", value = "v=spf1 include:_spf.porkbun.com ~all", ttl = 600, kind = "mail", purpose = "SPF for Porkbun email forwarding of orochia.com" }
    "dmarc-txt"                = { name = "_dmarc", type = "TXT", value = "v=DMARC1; p=none; adkim=r; aspf=r", ttl = 600, prio = 0, kind = "mail", purpose = "DMARC policy of orochia.com (reports only, p=none)" }
    "resend--domainkey-mg-txt" = { name = "resend._domainkey.mg", type = "TXT", value = "p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCt8SU5a0Rx4yrsUz/mCOXQ8KJkNZ9wpXpGK7mOjW32l6v+JjQRY4n0nIn4m7Obkn2rAfEps68K+AVaCvk+sM6JSHwzm42+tC1ReTr+QNh3lZTGesELkJiI8A9PRgcu2N/KVOC/hav78AeP5UC7foGndt+SG8nhpCIPZfxYBjHcNQIDAQAB", ttl = 600, prio = 0, kind = "mail", purpose = "DKIM public key (Resend) for mg.orochia.com" }
    "rsend-mg-cname"           = { name = "rsend.mg", type = "CNAME", value = "rsend-euw1.forge.rmta.net", ttl = 600, prio = 0, kind = "mail", purpose = "Resend sending/tracking domain rsend.mg.orochia.com" }
    "send-mg-cname"            = { name = "send.mg", type = "CNAME", value = "send.forge.rmta.net", ttl = 600, prio = 0, kind = "mail", purpose = "Resend sending/tracking domain send.mg.orochia.com" }
    # VERIFICATION (search engines, GitHub, Maven Central): keep, the owner proves the domain with them
    "apex-txt-2" = { name = "@", type = "TXT", value = "google-site-verification=LzNuJkXZQunurGxqEis1tT0vfob1hAyVfvqyiZrP_qc", ttl = 600, prio = 0, kind = "verification", purpose = "Google Search Console ownership of orochia.com" }
    # ACME challenges (certificates): kept as they are
    "acme-challenge-txt-1" = { name = "_acme-challenge", type = "TXT", value = "-DcXqws93dGb_upk5Q3RlrDuJ-LdWv3e99vTQNH0saA", ttl = 600, kind = "acme", purpose = "ACME DNS-01 challenge of orochia.com (certificate issuance), kept as is" }
    "acme-challenge-txt-2" = { name = "_acme-challenge", type = "TXT", value = "xmVdzmqvlryFPhaTi52aBrfHYIRkVFGmtcW9JS_i-So", ttl = 600, kind = "acme", purpose = "ACME DNS-01 challenge of orochia.com (certificate issuance), kept as is" }
    # NAMESERVERS (Porkbun defaults)
    "apex-ns-1" = { name = "@", type = "NS", value = "curitiba.porkbun.com", ttl = 86400, kind = "nameserver", purpose = "Porkbun default nameserver of the zone" }
    "apex-ns-2" = { name = "@", type = "NS", value = "fortaleza.porkbun.com", ttl = 86400, kind = "nameserver", purpose = "Porkbun default nameserver of the zone" }
    "apex-ns-3" = { name = "@", type = "NS", value = "maceio.porkbun.com", ttl = 86400, kind = "nameserver", purpose = "Porkbun default nameserver of the zone" }
    "apex-ns-4" = { name = "@", type = "NS", value = "salvador.porkbun.com", ttl = 86400, kind = "nameserver", purpose = "Porkbun default nameserver of the zone" }
  }
}
