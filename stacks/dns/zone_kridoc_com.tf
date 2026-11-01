# kridoc.com: Kridoc (code name kachizaka, the managed storage): no host serves it yet — the share-link host joins with krizaka-internal#1933; until then the zone only says it sends no mail (krizaka-internal#2037, commercial names #2033).
# NOT APPLIED: the CTO applies it (README « Commercial domains »). No record here targets an app: ADR-022, a commercial name never serves a dev app; the app records arrive with the product's prod step, pointing at the prod app (krizaka-internal#2128).
locals {
  kridoc_com = {
    "apex-spf-txt" = { name = "@", type = "TXT", value = "v=spf1 -all", ttl = 600, prio = 0, kind = "mail", purpose = "kridoc.com sends no mail yet: every sender is refused (SPF -all)" }
    "dmarc-txt" = { name = "_dmarc", type = "TXT", value = "v=DMARC1; p=reject; adkim=s; aspf=s", ttl = 600, prio = 0, kind = "mail", purpose = "DMARC policy of kridoc.com: no mail is sent from it, a forged one is rejected" }
    "apex-null-mx" = { name = "@", type = "MX", value = ".", ttl = 600, prio = 0, kind = "mail", purpose = "kridoc.com receives no mail yet (null MX, RFC 7505)" }
    "apex-caa" = { name = "@", type = "CAA", value = "0 issue \"letsencrypt.org\"", ttl = 600, prio = 0, kind = "verification", purpose = "kridoc.com certificates: Let's Encrypt only (the issuer of App Platform)" }
  }
}
