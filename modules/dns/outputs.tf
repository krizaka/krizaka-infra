output "spec" {
  description = "The normalized zone and records."
  value       = local.spec
}

output "mail_records" {
  description = "The keys of the mail records (Mailgun, Resend, DKIM, SPF, DMARC, forwarding): not to be touched without a mail test."
  value       = sort([for k, r in var.records : k if r.kind == "mail"])
}
