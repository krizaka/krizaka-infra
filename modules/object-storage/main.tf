# The provider-neutral interface of a private object-storage bucket: no resource, one normalized `spec` for an adapter.
# Credentials never appear here (no input and no output carries one).
locals {
  spec = {
    name                       = var.name
    region                     = var.region
    versioning                 = var.versioning
    noncurrent_expiration_days = var.noncurrent_expiration_days
    abort_multipart_days       = var.abort_multipart_days
    tls_only                   = true
    key_name                   = coalesce(var.key_name, "${var.name}-app")
  }
}
