variable "name" {
  description = "The app's name. A live app keeps its current name: renaming recreates it."
  type        = string
  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{0,30}[a-z0-9]$", var.name))
    error_message = "name: 2 to 32 characters, lowercase letters, digits and dashes, starting with a letter."
  }
}

variable "region" {
  description = "The provider's region slug (e.g. \"tor\" on DigitalOcean App Platform)."
  type        = string
}

variable "vpc_id" {
  description = "The private network the app joins, or null."
  type        = string
  default     = null
}

variable "features" {
  description = "Provider feature flags (e.g. \"buildpack-stack=ubuntu-22\")."
  type        = list(string)
  default     = []
}

variable "domains" {
  description = "Domains served by the app; at most one PRIMARY, the others ALIAS."
  type = list(object({
    name = string
    type = optional(string, "ALIAS")
  }))
  default = []
  validation {
    condition     = alltrue([for d in var.domains : contains(["PRIMARY", "ALIAS", "DEFAULT"], d.type)])
    error_message = "domains[*].type: PRIMARY, ALIAS or DEFAULT."
  }
  validation {
    condition     = length([for d in var.domains : d if d.type == "PRIMARY"]) <= 1
    error_message = "domains: at most one PRIMARY."
  }
}

variable "ingress_rules" {
  description = "Ordered ingress rules: a match (path prefix and/or exact authority) to a component, or to a redirect."
  type = list(object({
    path_prefix = optional(string)
    authority   = optional(string)
    component   = optional(string)
    redirect = optional(object({
      authority = optional(string)
      code      = optional(number)
    }))
  }))
  default = []
  validation {
    condition     = alltrue([for r in var.ingress_rules : (r.component == null) != (r.redirect == null)])
    error_message = "ingress_rules: each rule routes to a component or redirects, not both."
  }
}

variable "services" {
  description = "Long-running components with an HTTP port: built from a Dockerfile or a buildpack."
  type = list(object({
    name = string
    source = object({
      repo           = string
      branch         = optional(string, "main")
      deploy_on_push = optional(bool, false)
      dir            = optional(string)
    })
    dockerfile_path  = optional(string)
    environment_slug = optional(string)
    build_command    = optional(string)
    run_command      = optional(string)
    http_port        = optional(number)
    internal_ports   = optional(list(number), [])
    instance_size    = string
    instance_count   = optional(number, 1)
    health_check = optional(object({
      http_path             = string
      port                  = optional(number)
      initial_delay_seconds = optional(number)
      period_seconds        = optional(number)
      timeout_seconds       = optional(number)
      success_threshold     = optional(number)
      failure_threshold     = optional(number)
    }))
    envs = optional(list(object({
      key      = string
      scope    = optional(string, "RUN_TIME")
      value    = optional(string)
      secret   = optional(bool, false)
      external = optional(bool, false)
    })), [])
  }))
  default = []
  validation {
    condition     = alltrue([for s in var.services : (s.dockerfile_path == null) != (s.environment_slug == null)])
    error_message = "services: each service sets dockerfile_path or environment_slug, not both."
  }
  validation {
    condition     = alltrue([for s in var.services : s.instance_count >= 1])
    error_message = "services[*].instance_count: at least 1."
  }
}

variable "static_sites" {
  description = "Static sites: built, then served from the provider's edge."
  type = list(object({
    name = string
    source = object({
      repo           = string
      branch         = optional(string, "main")
      deploy_on_push = optional(bool, false)
      dir            = optional(string)
    })
    environment_slug = optional(string)
    build_command    = optional(string)
    output_dir       = optional(string)
    index_document   = optional(string)
    error_document   = optional(string)
    envs = optional(list(object({
      key      = string
      scope    = optional(string, "BUILD_TIME")
      value    = optional(string)
      secret   = optional(bool, false)
      external = optional(bool, false)
    })), [])
  }))
  default = []
}

variable "env_values" {
  description = "Values of the envs marked secret or external, keyed \"<component>/<KEY>\". From the environment (TF_VAR_env_values), never a file in git."
  type        = map(string)
  default     = {}
  sensitive   = true
}
