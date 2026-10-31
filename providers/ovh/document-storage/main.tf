locals {
  s3_actions = {
    read   = ["s3:GetObject", "s3:GetObjectVersion", "s3:ListBucket", "s3:ListBucketVersions"]
    write  = ["s3:PutObject", "s3:AbortMultipartUpload", "s3:ListMultipartUploadParts"]
    delete = ["s3:DeleteObject", "s3:DeleteObjectVersion"]
  }
  buckets = {
    primary = { name = var.storage.primary_bucket, region = upper(var.storage.primary_region) }
    replica = { name = var.storage.replica_bucket, region = upper(var.storage.replica_region) }
  }
  canadian_regions = ["BHS", "CA-EAST-TOR"]
}

# The replica first: the primary's replication rule names it.
resource "ovh_cloud_project_storage" "replica" {
  service_name = var.project_id
  name         = local.buckets.replica.name
  region_name  = local.buckets.replica.region

  versioning = {
    status = "enabled"
  }

  encryption = {
    sse_algorithm = "AES256"
  }

  object_lock = var.storage.replica_lock_days == 0 ? null : {
    status = "enabled"
    rule = {
      mode   = "governance"
      period = "P${var.storage.replica_lock_days}D"
    }
  }

  lifecycle {
    prevent_destroy = true
    precondition {
      condition     = contains(local.canadian_regions, local.buckets.replica.region)
      error_message = "replica_region: personal information stays in Canada (BHS or CA-EAST-TOR)."
    }
  }
}

resource "ovh_cloud_project_storage" "primary" {
  service_name = var.project_id
  name         = local.buckets.primary.name
  region_name  = local.buckets.primary.region

  versioning = {
    status = "enabled"
  }

  encryption = {
    sse_algorithm = "AES256"
  }

  replication = {
    rules = [{
      id                        = "to-replica"
      status                    = "enabled"
      priority                  = 1
      delete_marker_replication = "disabled"
      destination = {
        name   = ovh_cloud_project_storage.replica.name
        region = ovh_cloud_project_storage.replica.region_name
      }
    }]
  }

  lifecycle {
    prevent_destroy = true
    precondition {
      condition     = contains(local.canadian_regions, local.buckets.primary.region)
      error_message = "primary_region: personal information stays in Canada (BHS or CA-EAST-TOR)."
    }
  }
}

resource "ovh_cloud_project_storage_object_bucket_lifecycle_configuration" "this" {
  for_each = local.buckets

  service_name   = var.project_id
  container_name = each.value.name
  region_name    = each.value.region

  rules = [
    {
      id     = "abort-unfinished-uploads"
      status = "enabled"
      abort_incomplete_multipart_upload = {
        days_after_initiation = var.storage.abort_multipart_days
      }
    },
    {
      id     = "expire-previous-versions"
      status = "enabled"
      noncurrent_version_expiration = {
        noncurrent_days = var.storage.noncurrent_expiration_days
      }
    },
    {
      id     = "expire-trash"
      status = "enabled"
      filter = {
        prefix = var.storage.trash_prefix
      }
      expiration = {
        days = var.storage.trash_expiration_days
      }
    },
  ]

  depends_on = [ovh_cloud_project_storage.primary, ovh_cloud_project_storage.replica]
}

# One S3 user per role of spec.users; each gets exactly the actions the spec grants on each bucket.
resource "ovh_cloud_project_user" "this" {
  for_each = var.storage.users

  service_name = var.project_id
  description  = "docs-${var.storage.env}-${each.key}"
  role_names   = ["objectstore_operator"]
}

resource "ovh_cloud_project_user_s3_credential" "this" {
  for_each = var.storage.users

  service_name = var.project_id
  user_id      = ovh_cloud_project_user.this[each.key].id
}

resource "ovh_cloud_project_user_s3_policy" "this" {
  for_each = var.storage.users

  service_name = var.project_id
  user_id      = ovh_cloud_project_user.this[each.key].id
  policy = jsonencode({
    Statement = [for side, grants in each.value : {
      Sid      = "${each.key}-${side}"
      Effect   = "Allow"
      Action   = distinct(flatten([for g in grants : local.s3_actions[g]]))
      Resource = ["arn:aws:s3:::${local.buckets[side].name}", "arn:aws:s3:::${local.buckets[side].name}/*"]
    }]
  })
}

# The root key of the environment, in the key-management service (OKMS). The region is the primary's.
resource "ovh_okms" "this" {
  ovh_subsidiary = var.okms_subsidiary
  region         = var.okms_region
  display_name   = "docs-${var.storage.env}"

  lifecycle {
    prevent_destroy = true
  }
}

resource "ovh_okms_service_key" "root" {
  okms_id    = ovh_okms.this.id
  name       = "docs-${var.storage.env}-root"
  type       = "oct"
  size       = 256
  operations = ["encrypt", "decrypt"]

  lifecycle {
    prevent_destroy = true
  }
}
