# The DNS of the Krizaka family: the domains held at Porkbun, one `zone_<domain>.tf` of records each. A subdomain is
# one entry in its zone's file (README « Add a subdomain »). Imported (imports.tf), never recreated.
locals {
  zones = {
    "krizaka.com"  = local.krizaka_com
    "orazaka.com"  = local.orazaka_com
    "yomizaka.com" = local.yomizaka_com
    "akinaza.com"  = local.akinaza_com
    "akinaza.shop" = local.akinaza_shop
    # The commercial names (krizaka-internal#2037): created, not imported — README « Commercial domains ».
    "verikora.com"  = local.verikora_com
    "folioviv.com"  = local.folioviv_com
    "folioviv.app"  = local.folioviv_app
    "folioviv.shop" = local.folioviv_shop
    "sovkora.com"   = local.sovkora_com
    "kridoc.com"    = local.kridoc_com
  }
}

module "dns" {
  source   = "../../modules/dns"
  for_each = local.zones

  zone    = each.key
  records = each.value
}

module "dns_porkbun" {
  source   = "../../providers/porkbun/dns"
  for_each = module.dns

  zone    = each.value.spec.zone
  records = each.value.spec.records
}
