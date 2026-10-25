# The provider-neutral interface of an app: no resource here. It validates the inputs and hands an adapter
# (providers/<provider>/app) one normalized `spec`; secret and external values travel apart, in `env_values`.
locals {
  components = concat([for s in var.services : s.name], [for s in var.static_sites : s.name])

  env_scopes = ["RUN_TIME", "BUILD_TIME", "RUN_AND_BUILD_TIME"]
  all_envs = flatten([
    for c in concat(var.services, var.static_sites) : [for e in c.envs : merge(e, { component = c.name })]
  ])

  # Keys the caller must give in env_values: secrets and values kept out of git (hosts, certificates).
  required_env_values = sort(distinct([for e in local.all_envs : "${e.component}/${e.key}" if e.secret || e.external]))
  given_env_values    = nonsensitive(keys(var.env_values))
  missing_env_values  = setsubtract(local.required_env_values, local.given_env_values)

  spec = {
    name          = var.name
    region        = var.region
    vpc_id        = var.vpc_id
    features      = var.features
    domains       = var.domains
    ingress_rules = var.ingress_rules
    services      = var.services
    static_sites  = var.static_sites
  }
}
