# folioviv.com: Folioviv (code name akinaza): the marketing site and explore pages (krizaka-internal#2037, commercial names #2033).
# NOT APPLIED: the CTO applies it (README « Commercial domains »). No record here targets an app: ADR-022, a commercial name never serves a dev app; the app records arrive with the product's prod step, pointing at the prod app (krizaka-internal#2128).
locals {
  folioviv_com = {
    "apex-spf-txt" = { name = "@", type = "TXT", value = "v=spf1 -all", ttl = 600, prio = 0, kind = "mail", purpose = "folioviv.com sends no mail yet: every sender is refused (SPF -all)" }
    "dmarc-txt" = { name = "_dmarc", type = "TXT", value = "v=DMARC1; p=reject; adkim=s; aspf=s", ttl = 600, prio = 0, kind = "mail", purpose = "DMARC policy of folioviv.com: no mail is sent from it, a forged one is rejected" }
    "apex-null-mx" = { name = "@", type = "MX", value = ".", ttl = 600, prio = 0, kind = "mail", purpose = "folioviv.com receives no mail yet (null MX, RFC 7505)" }
    "apex-caa" = { name = "@", type = "CAA", value = "0 issue \"letsencrypt.org\"", ttl = 600, prio = 0, kind = "verification", purpose = "folioviv.com certificates: Let's Encrypt only (the issuer of App Platform)" }
  }
}
