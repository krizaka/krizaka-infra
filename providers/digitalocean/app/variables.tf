variable "app" {
  description = "The normalized app: the `spec` output of modules/app."
  type        = any
}

variable "env_values" {
  description = "The `env_values` output of modules/app: values of the secret and external envs, keyed \"<component>/<KEY>\"."
  type        = map(string)
  default     = {}
  sensitive   = true
}
