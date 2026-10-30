variable "name" {
  description = "The bucket's name (3 to 63 lowercase letters, digits and hyphens). Renaming recreates it."
  type        = string
  validation {
    condition     = can(regex("^[a-z0-9][a-z0-9-]{1,61}[a-z0-9]$", var.name))
    error_message = "name: 3 to 63 lowercase letters, digits and hyphens, not starting or ending with a hyphen."
  }
}

variable "region" {
  description = "The region slug. Personal information of Quebec residents stays in Canada: only tor1 is accepted here."
  type        = string
  validation {
    condition     = contains(["tor1"], var.region)
    error_message = "region: tor1 (Toronto). Another Canadian region is added here with its Loi 25 assessment, never silently."
  }
}

variable "versioning" {
  description = "Keep the previous version of an overwritten or deleted object (the rollback of a bad move)."
  type        = bool
  default     = true
}

variable "noncurrent_expiration_days" {
  description = "Days a previous version is kept before it is purged (it is personal data: the retention policy names this delay)."
  type        = number
  default     = 30
  validation {
    condition     = var.noncurrent_expiration_days >= 1 && var.noncurrent_expiration_days <= 90
    error_message = "noncurrent_expiration_days: 1 to 90."
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

variable "key_name" {
  description = "The name of the one access key of the application, limited to this bucket. Default: <name>-app."
  type        = string
  default     = null
}
