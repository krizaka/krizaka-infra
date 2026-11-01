# kridoc.com: Kridoc (code name kachizaka, the managed storage): no host serves it yet — the share-link host joins with krizaka-internal#1933; until then the zone only says it sends no mail (krizaka-internal#2037, commercial names #2033).
# NOT APPLIED by this pull request: the CTO applies it (README « Commercial domains »), BEFORE the app spec lists the domain.
# Porkbun's parking records (apex ALIAS, wildcard CNAME) are imported in imports.tf: the plan updates them, nothing is deleted by hand.
locals {
  kridoc_com = {
    "apex-spf-txt" = { name = "@", type = "TXT", value = "v=spf1 -all", ttl = 600, prio = 0, kind = "mail", purpose = "kridoc.com sends no mail yet: every sender is refused (SPF -all)" }
    "dmarc-txt"    = { name = "_dmarc", type = "TXT", value = "v=DMARC1; p=reject; adkim=s; aspf=s", ttl = 600, prio = 0, kind = "mail", purpose = "DMARC policy of kridoc.com: no mail is sent from it, a forged one is rejected" }
  }
}
