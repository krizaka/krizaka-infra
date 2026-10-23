variable "name" {
  type        = string
  description = "The app name."
}

variable "region" {
  type        = string
  description = "The app region."
}

variable "components" {
  description = "Services and static sites in the app."
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
}

variable "sensitive_env_vars" {
  type        = map(map(object({ value = string, scope = string, secret = optional(bool, true) })))
  description = "Sensitive env values by component."
  sensitive   = true
  default     = {}
}

variable "domains" {
  default = []
  type = list(object({
    domain = string
    type   = string
  }))
}

variable "ingress_rules" {
  default = []
  type = list(object({
    component          = optional(string)
    path_prefix        = optional(string)
    authority_exact    = optional(string)
    redirect_authority = optional(string)
    redirect_code      = optional(number)
  }))
}

variable "features" {
  type    = list(string)
  default = []
}

variable "vpc_id" {
  type    = string
  default = null
}
