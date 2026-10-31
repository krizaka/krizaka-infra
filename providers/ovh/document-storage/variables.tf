variable "storage" {
  description = "The normalized document storage: the `spec` output of modules/document-storage."
  type        = any
}

variable "project_id" {
  description = "The id of the OVHcloud Public Cloud project (ordered by the account owner, never by this code)."
  type        = string
}

variable "okms_subsidiary" {
  description = "The OVHcloud subsidiary of the account (CA for Canada)."
  type        = string
  default     = "CA"
}

variable "okms_region" {
  description = "The region of the key-management service (ca-east-bhs; the backup region is set by OVHcloud)."
  type        = string
  default     = "ca-east-bhs"
}
