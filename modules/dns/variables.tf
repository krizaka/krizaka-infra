variable "zone" {
  description = "The DNS zone (e.g. orazaka.com)."
  type        = string
}

variable "records" {
  description = "The records of the zone this stack keeps (name relative to the zone, \"@\" for the apex)."
  type = list(object({
    name  = string
    type  = string
    value = string
    ttl   = optional(number, 600)
  }))
  default = []
  validation {
    condition     = alltrue([for r in var.records : contains(["A", "AAAA", "CNAME", "ALIAS", "TXT", "MX", "CAA", "NS", "SRV"], r.type)])
    error_message = "records[*].type: A, AAAA, CNAME, ALIAS, TXT, MX, CAA, NS or SRV."
  }
  validation {
    condition     = alltrue([for r in var.records : r.ttl >= 60])
    error_message = "records[*].ttl: at least 60 seconds."
  }
}
