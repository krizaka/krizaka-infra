# akinaza.shop: the shops' own domain (ADR-005 slice 5, krizaka/akinaza#538). Every shop is <slug>.akinaza.shop, served by the same
# App Platform app as www.akinaza.com but in another site (a separate registrable domain: no cookie of the app reaches a shop).
# NOT APPLIED by this pull request: Oussama applies it (README « akinaza.shop »), BEFORE the app spec lists the domain.
# Porkbun's parking records (apex ALIAS, wildcard CNAME) are imported in imports.tf: the plan updates them, nothing is deleted by hand.
locals {
  akinaza_shop = {
    "apex-alias"     = { name = "@", type = "ALIAS", value = "akinaza-dev-hfdcl.ondigitalocean.app", ttl = 600, prio = 0, kind = "app", purpose = "akinaza.shop leads to the app (308 to www.akinaza.com, App Platform)" }
    "wildcard-cname" = { name = "*", type = "CNAME", value = "akinaza-dev-hfdcl.ondigitalocean.app", ttl = 600, prio = 0, kind = "app", purpose = "*.akinaza.shop serves the shops of the akinaza-dev app (App Platform)" }
    "apex-txt-gsc"   = { name = "@", type = "TXT", value = "google-site-verification=hHdCh8J-52vCxL90ezxg-wfF8SUQrn-PmG9jfJEPJwQ", ttl = 600, prio = 0, kind = "verification", purpose = "Google Search Console ownership of akinaza.shop (the shops' pages)" }
    "www-cname"      = { name = "www", type = "CNAME", value = "akinaza-dev-hfdcl.ondigitalocean.app", ttl = 600, prio = 0, kind = "app", purpose = "www.akinaza.shop leads to the app (308 to www.akinaza.com, App Platform)" }
  }
}
