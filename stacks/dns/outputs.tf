output "mail_records" {
  description = "By zone, the keys of the mail records: not to be touched without a mail test."
  value       = { for zone, m in module.dns : zone => m.mail_records }
}
