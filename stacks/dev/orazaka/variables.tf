variable "env_values" {
  description = "Values of orazaka-dev's secret and external envs, keyed \"<component>/<KEY>\" (TF_VAR_env_values, JSON). Never in a file in git: see README."
  type        = map(string)
  sensitive   = true
}
