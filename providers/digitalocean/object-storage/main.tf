# The DigitalOcean adapter of the object-storage role: a private Spaces bucket, a policy that refuses plain HTTP, and one key
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

resource "digitalocean_spaces_bucket_policy" "tls_only" {
  region = digitalocean_spaces_bucket.this.region
  bucket = digitalocean_spaces_bucket.this.name
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Sid       = "DenyPlainHttp"
      Effect    = "Deny"
      Principal = "*"
      Action    = "s3:*"
      Resource = [
        "arn:aws:s3:::${digitalocean_spaces_bucket.this.name}",
        "arn:aws:s3:::${digitalocean_spaces_bucket.this.name}/*",
      ]
      Condition = { Bool = { "aws:SecureTransport" = "false" } }
    }]
  })
}

resource "digitalocean_spaces_key" "app" {
  name = var.bucket.key_name

  grant {
    bucket     = digitalocean_spaces_bucket.this.name
    permission = "readwrite"
  }
}
