# The Porkbun adapter of the dns role: one porkbun_dns_record per record of the spec. The apex is "@" in the spec and
# an empty subdomain at Porkbun. Credentials come from PORKBUN_API_KEY and PORKBUN_SECRET_API_KEY (docs/SECRETS.md).
resource "porkbun_dns_record" "this" {
  for_each = { for k, r in var.records : k => r if r.managed }

  domain    = var.zone
  subdomain = each.value.name == "@" ? "" : each.value.name
  type      = each.value.type
  content   = each.value.value
  ttl       = each.value.ttl
  prio      = each.value.prio
}
