output "record_ids" {
  description = "The Porkbun id of each record, by key."
  value       = { for k, r in porkbun_dns_record.this : k => r.id }
}
