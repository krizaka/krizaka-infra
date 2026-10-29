# The DNS of the Krizaka family: the 4 domains held at Porkbun, one `zone_<domain>.tf` of records each. A subdomain is
# one entry in its zone's file (README « Add a subdomain »). Imported (imports.tf), never recreated.
locals {
  zones = {
    "krizaka.com"  = local.krizaka_com
    "orazaka.com"  = local.orazaka_com
    "yomizaka.com" = local.yomizaka_com
    "akinaza.com"  = local.akinaza_com
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
