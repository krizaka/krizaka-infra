variable "storage_zones" {
  description = "Storage zones (the files) by name, with their main region."
  type = list(object({
    name   = string
    region = string
  }))
  default = []
}

variable "pull_zones" {
  description = "Pull zones (the edge) by name: the storage zone they serve, or an origin URL."
  type = list(object({
    name         = string
    storage_zone = optional(string)
    origin_url   = optional(string)
  }))
  default = []
  validation {
    condition     = alltrue([for z in var.pull_zones : (z.storage_zone == null) != (z.origin_url == null)])
    error_message = "pull_zones: each serves a storage zone or an origin URL, not both."
  }
}
