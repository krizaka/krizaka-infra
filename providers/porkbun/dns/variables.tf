variable "zone" {
  description = "The domain, registered at Porkbun (the `zone` of modules/dns spec)."
  type        = string
}

variable "records" {
  description = "The normalized records: the `spec.records` output of modules/dns."
  type = map(object({
    name  = string
    type  = string
    value = string
    ttl   = optional(number, 600)
    prio  = optional(number)
    # The records with managed = false are listed by the role and skipped here.
    managed = optional(bool, true)
  }))
  validation {
    condition     = alltrue([for r in values(var.records) : !r.managed || r.ttl >= 600])
    error_message = "records[*].ttl: the Porkbun provider refuses a TTL under 600; list such a record with managed = false."
  }
}
