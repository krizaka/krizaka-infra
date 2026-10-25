variable "env_values" {
  description = "Values of orazaka-dev's secret and external envs, keyed \"<component>/<KEY>\" (TF_VAR_env_values, JSON). Never in a file in git: see README."
  type        = map(string)
  sensitive   = true
}

variable "operator_ssh_sources" {
  description = "The operator's addresses allowed to reach the broker over SSH (TF_VAR_operator_ssh_sources, JSON list). An IP is personal data: never in a file in git."
  type        = list(string)
  sensitive   = true
}
