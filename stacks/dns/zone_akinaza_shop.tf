# akinaza.shop: the shops' own domain (ADR-005 slice 5, krizaka/akinaza#538). Every shop is <slug>.akinaza.shop, served by the same
# App Platform app as www.akinaza.com but in another site (a separate registrable domain: no cookie of the app reaches a shop).
# NOT APPLIED by this pull request: Oussama applies it (README « akinaza.shop »), BEFORE the app spec lists the domain.
# The records are created, not imported: delete Porkbun's parking records (ALIAS @ and CNAME * to pixie/uixie.porkbun.com) first.
locals {
  akinaza_shop = {
    "apex-alias"     = { name = "@", type = "ALIAS", value = "akinaza-dev-hfdcl.ondigitalocean.app", ttl = 600, prio = 0, kind = "app", purpose = "akinaza.shop leads to the app (308 to www.akinaza.com, App Platform)" }
    "wildcard-cname" = { name = "*", type = "CNAME", value = "akinaza-dev-hfdcl.ondigitalocean.app", ttl = 600, prio = 0, kind = "app", purpose = "*.akinaza.shop serves the shops of the akinaza-dev app (App Platform)" }
    "www-cname"      = { name = "www", type = "CNAME", value = "akinaza-dev-hfdcl.ondigitalocean.app", ttl = 600, prio = 0, kind = "app", purpose = "www.akinaza.shop leads to the app (308 to www.akinaza.com, App Platform)" }
  }
}
