variable "zone" {
  description = "The DNS zone (e.g. orazaka.com)."
  type        = string
}

variable "records" {
  description = "The records of the zone, keyed by a stable name (the key is the record's identity in the state, never reuse it for another record). `name` is relative to the zone (\"@\" for the apex, \"*\" for a wildcard); `kind` says what the record is for; `purpose` says, in one line, which app or site needs it; `managed = false` lists a record the adapter cannot keep (documented, not applied)."
  type = map(object({
    name    = string
    type    = string
    value   = string
    ttl     = optional(number, 600)
    prio    = optional(number)
    kind    = optional(string, "app")
    managed = optional(bool, true)
    purpose = string
  }))
  default = {}
  validation {
    condition     = alltrue([for r in values(var.records) : contains(["A", "AAAA", "CNAME", "ALIAS", "TXT", "MX", "CAA", "NS", "SRV"], r.type)])
    error_message = "records[*].type: A, AAAA, CNAME, ALIAS, TXT, MX, CAA, NS or SRV."
  }
  validation {
    condition     = alltrue([for r in values(var.records) : r.ttl >= 60])
    error_message = "records[*].ttl: at least 60 seconds."
  }
  validation {
    condition     = alltrue([for r in values(var.records) : contains(["app", "mail", "verification", "acme", "nameserver"], r.kind)])
    error_message = "records[*].kind: app, mail, verification, acme or nameserver."
  }
  validation {
    condition     = alltrue([for r in values(var.records) : trimspace(r.purpose) != ""])
    error_message = "records[*].purpose: say which app or site needs the record."
  }
  validation {
    condition     = alltrue([for r in values(var.records) : r.type != "CNAME" || r.name != "@"])
    error_message = "A CNAME cannot sit at the apex: use an ALIAS."
  }
}
