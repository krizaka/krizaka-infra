# folioviv.app: Folioviv's merchant dashboard, POS and client app (.app is HSTS-preloaded: TLS from the first request) (krizaka-internal#2037, commercial names #2033).
# NOT APPLIED by this pull request: the CTO applies it (README « Commercial domains »), BEFORE the app spec lists the domain.
# Porkbun's parking records (apex ALIAS, wildcard CNAME) are imported in imports.tf: the plan updates them, nothing is deleted by hand.
locals {
  folioviv_app = {
    "apex-alias" = { name = "@", type = "ALIAS", value = "akinaza-dev-hfdcl.ondigitalocean.app", ttl = 600, prio = 0, kind = "app", purpose = "folioviv.app serves the akinaza-dev app (App Platform)" }
    "www-cname"  = { name = "www", type = "CNAME", value = "akinaza-dev-hfdcl.ondigitalocean.app", ttl = 600, prio = 0, kind = "app", purpose = "www.folioviv.app serves the akinaza-dev app (App Platform)" }
    "dmarc-txt"  = { name = "_dmarc", type = "TXT", value = "v=DMARC1; p=none; adkim=r; aspf=r", ttl = 600, prio = 0, kind = "mail", purpose = "DMARC policy of folioviv.app (reports only, p=none until its sender's DKIM is live)" }
  }
}
