variable "name" {
  type        = string
  description = "The app name; preserve the live name when importing an existing app."

  validation {
    condition     = length(trimspace(var.name)) > 0
    error_message = "name must not be empty."
  }
}

variable "region" {
  type        = string
  description = "The app's deployment region."

  validation {
    condition     = length(trimspace(var.region)) > 0
    error_message = "region must not be empty."
  }
}

variable "components" {
  description = "App services and static sites, keyed by their provider component name."
  type = map(object({
    kind              = string
    source_repository = string
    branch            = string
    deploy_on_push    = optional(bool, false)
    build_command     = optional(string)
    dockerfile_path   = optional(string)
    source_dir        = optional(string)
    run_command       = optional(string)
    output_dir        = optional(string)
    http_port         = optional(number)
    internal_ports    = optional(list(number), [])
    instance_size     = string
    instance_count    = number
    health_check = optional(object({
      http_path             = optional(string)
      initial_delay_seconds = optional(number)
      period_seconds        = optional(number)
      timeout_seconds       = optional(number)
      success_threshold     = optional(number)
      failure_threshold     = optional(number)
      port                  = optional(number)
    }))
    env_vars = optional(map(object({
      value = string
      scope = string
    })), {})
  }))

  validation {
    condition     = length(var.components) > 0
    error_message = "At least one component is required."
  }

  validation {
    condition = alltrue([
      for component in values(var.components) :
      contains(["service", "static_site"], component.kind) &&
      length(trimspace(component.source_repository)) > 0 &&
      length(trimspace(component.branch)) > 0 &&
      length(trimspace(component.instance_size)) > 0 &&
      component.instance_count > 0
    ])
    error_message = "Components need a valid kind, repository, branch, instance size, and positive instance count."
  }
}

variable "sensitive_env_vars" {
  description = "Sensitive values for component env vars; secret controls the provider's env type."
  sensitive   = true
  default     = {}
  type = map(map(object({
    value  = string
    scope  = string
    secret = optional(bool, true)
  })))
}

variable "domains" {
  description = "Domains attached to the app."
  default     = []
  type = list(object({
    domain = string
    type   = string
  }))
}

variable "ingress_rules" {
  description = "Path and authority matches routed to components or redirects."
  default     = []
  type = list(object({
    component          = optional(string)
    path_prefix        = optional(string)
    authority_exact    = optional(string)
    redirect_authority = optional(string)
    redirect_code      = optional(number)
  }))
}

variable "features" {
  type        = list(string)
  description = "Provider-neutral app features supported by the target provider."
  default     = []
}

variable "vpc_id" {
  type        = string
  description = "Optional network identifier required by apps using a private network."
  default     = null
}
