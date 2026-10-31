locals {
  spec = {
    env                        = var.env
    primary_bucket             = "docs-${var.env}"
    replica_bucket             = "docs-${var.env}-replica"
    primary_region             = var.primary_region
    replica_region             = var.replica_region
    versioning                 = true
    tls_only                   = true
    noncurrent_expiration_days = var.noncurrent_expiration_days
    trash_prefix               = var.trash_prefix
    trash_expiration_days      = var.trash_expiration_days
    abort_multipart_days       = var.abort_multipart_days
    replica_lock_days          = var.replica_lock_days
    # Least privilege: the service reads and writes the primary; drills only read; nobody deletes on the replica.
    users = {
      service = { primary = ["read", "write", "delete"], replica = ["read"] }
      drills  = { primary = ["read"], replica = ["read"] }
    }
  }
}
