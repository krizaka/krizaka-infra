# verikora.com: Verikora (code name yomizaka): the product's site and dev site (krizaka-internal#2037, commercial names #2033).
# NOT APPLIED by this pull request: the CTO applies it (README « Commercial domains »), BEFORE the app spec lists the domain.
# Porkbun's parking records (apex ALIAS, wildcard CNAME) are imported in imports.tf: the plan updates them, nothing is deleted by hand.
locals {
  verikora_com = {
    "apex-alias"  = { name = "@", type = "ALIAS", value = "yomizaka-dev-q2huf.ondigitalocean.app", ttl = 600, prio = 0, kind = "app", purpose = "verikora.com serves the yomizaka-dev app (App Platform)" }
    "www-cname"   = { name = "www", type = "CNAME", value = "yomizaka-dev-q2huf.ondigitalocean.app", ttl = 600, prio = 0, kind = "app", purpose = "www.verikora.com serves the yomizaka-dev app (App Platform)" }
    "dev-cname"   = { name = "dev", type = "CNAME", value = "yomizaka-dev-q2huf.ondigitalocean.app", ttl = 600, prio = 0, kind = "app", purpose = "dev.verikora.com serves the yomizaka-dev app (App Platform)" }
    "admin-cname" = { name = "admin", type = "CNAME", value = "yomizaka-dev-q2huf.ondigitalocean.app", ttl = 600, prio = 0, kind = "app", purpose = "admin.verikora.com serves the yomizaka-dev app (App Platform)" }
    "dmarc-txt"   = { name = "_dmarc", type = "TXT", value = "v=DMARC1; p=none; adkim=r; aspf=r", ttl = 600, prio = 0, kind = "mail", purpose = "DMARC policy of verikora.com (reports only, p=none until its sender's DKIM is live)" }
  }
}
