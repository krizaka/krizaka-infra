# folioviv.shop: the shops' own domain, <shop>.folioviv.shop (a separate registrable domain: no cookie of the app reaches a shop) (krizaka-internal#2037, commercial names #2033).
# NOT APPLIED by this pull request: the CTO applies it (README « Commercial domains »), BEFORE the app spec lists the domain.
# The records are created, not imported: delete Porkbun's parking records (ALIAS @ and CNAME * to pixie/uixie.porkbun.com) first.
locals {
  folioviv_shop = {
    "apex-alias"     = { name = "@", type = "ALIAS", value = "akinaza-dev-hfdcl.ondigitalocean.app", ttl = 600, prio = 0, kind = "app", purpose = "folioviv.shop serves the akinaza-dev app (App Platform)" }
    "wildcard-cname" = { name = "*", type = "CNAME", value = "akinaza-dev-hfdcl.ondigitalocean.app", ttl = 600, prio = 0, kind = "app", purpose = "*.folioviv.shop serves the akinaza-dev app (App Platform)" }
    "www-cname"      = { name = "www", type = "CNAME", value = "akinaza-dev-hfdcl.ondigitalocean.app", ttl = 600, prio = 0, kind = "app", purpose = "www.folioviv.shop serves the akinaza-dev app (App Platform)" }
    "dmarc-txt"      = { name = "_dmarc", type = "TXT", value = "v=DMARC1; p=none; adkim=r; aspf=r", ttl = 600, prio = 0, kind = "mail", purpose = "DMARC policy of folioviv.shop (reports only, p=none until its sender's DKIM is live)" }
  }
}
