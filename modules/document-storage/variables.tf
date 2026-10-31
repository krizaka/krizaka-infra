variable "env" {
  description = "The environment the buckets belong to (dev or prod). Buckets are named docs-<env> and docs-<env>-replica."
  type        = string
  validation {
    condition     = contains(["dev", "prod"], var.env)
    error_message = "env: dev or prod."
  }
}

variable "primary_region" {
  description = "The logical region of the writable bucket. The adapter maps it to its provider and validates that the region is in Canada."
  type        = string
}

variable "replica_region" {
  description = "The logical region of the replica bucket (a second Canadian region, asynchronous replication)."
  type        = string
  validation {
    condition     = var.replica_region != var.primary_region
    error_message = "replica_region: must differ from primary_region."
  }
}

variable "noncurrent_expiration_days" {
  description = "Days a previous version is kept before it is purged (personal data: the retention policy names this delay)."
  type        = number
  default     = 30
  validation {
    condition     = var.noncurrent_expiration_days >= 1 && var.noncurrent_expiration_days <= 365
    error_message = "noncurrent_expiration_days: 1 to 365."
  }
}

variable "trash_prefix" {
  description = "The prefix a deleted document is moved to before it expires."
  type        = string
  default     = "trash/"
}

variable "trash_expiration_days" {
  description = "Days an object under trash_prefix is kept before it expires."
  type        = number
  default     = 30
  validation {
    condition     = var.trash_expiration_days >= 1 && var.trash_expiration_days <= 365
    error_message = "trash_expiration_days: 1 to 365."
  }
}

variable "abort_multipart_days" {
  description = "Days after which an unfinished multipart upload is aborted."
  type        = number
  default     = 1
  validation {
    condition     = var.abort_multipart_days >= 1 && var.abort_multipart_days <= 7
    error_message = "abort_multipart_days: 1 to 7."
  }
}

variable "replica_lock_days" {
  description = "Governance object-lock retention on the replica, in days (an object cannot be deleted or overwritten before). 0 turns the default retention off."
  type        = number
  default     = 30
  validation {
    condition     = var.replica_lock_days >= 0 && var.replica_lock_days <= 3650
    error_message = "replica_lock_days: 0 to 3650."
  }
}
