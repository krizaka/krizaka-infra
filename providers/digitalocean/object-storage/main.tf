# The DigitalOcean adapter of the object-storage role: a private Spaces bucket and one key
# that can only read and write this bucket (least privilege: it cannot list, create or delete any other bucket).
resource "digitalocean_spaces_bucket" "this" {
  name   = var.bucket.name
  region = var.bucket.region
  acl    = "private"

  versioning {
    enabled = var.bucket.versioning
  }

  lifecycle_rule {
    id                                     = "abort-unfinished-uploads"
    enabled                                = true
    abort_incomplete_multipart_upload_days = var.bucket.abort_multipart_days
  }

  dynamic "lifecycle_rule" {
    for_each = var.bucket.versioning ? [1] : []
    content {
      id      = "expire-previous-versions"
      enabled = true
      noncurrent_version_expiration {
        days = var.bucket.noncurrent_expiration_days
      }
    }
  }

  # A bucket that holds personal documents is never destroyed by a plan (AGENTS.md « Import before change »).
  lifecycle {
    prevent_destroy = true
  }
}

# No bucket policy on purpose: DigitalOcean refuses a bucket-scoped key on a bucket that has one (README).
resource "digitalocean_spaces_key" "app" {
  name = var.bucket.key_name

  grant {
    bucket     = digitalocean_spaces_bucket.this.name
    permission = "readwrite"
  }
}
