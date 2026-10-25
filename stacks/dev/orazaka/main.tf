# orazaka-dev as it runs today (2026-10-24): the App Platform app of krizaka/orazaka infra/deploy/orazaka-dev.app.yaml,
# the managed PostgreSQL cluster it uses, and the RabbitMQ broker droplet. Imported (imports.tf), never recreated.
locals {
  region = "tor1"
  vpc_id = "60296b32-efad-49be-bb41-321b1b6cc328"

  # Env names, scopes and public values as in orazaka-dev.app.yaml. `secret`: a SECRET env; `external`: a value kept
  # out of git (database hosts, certificates, app identifiers). Both come from var.env_values.
  web_envs = [
    { key = "APP_SEARCH_INDEXING", scope = "RUN_AND_BUILD_TIME", value = "on" },
    { key = "AUTH_LOGIN_ENABLED", scope = "RUN_AND_BUILD_TIME", value = "true" },
    { key = "AUTH_SIGNUP_ENABLED", scope = "RUN_AND_BUILD_TIME", value = "false" },
    { key = "APP_COMMIT", scope = "BUILD_TIME", value = "$${_self.COMMIT_HASH}" },
    { key = "NODE_ENV", value = "production" },
    { key = "ROUTER_URL", value = "http://core:8088" },
    { key = "NEXTAUTH_URL", value = "https://www.orazaka.com" },
    { key = "APP_PUBLIC_URL", value = "https://www.orazaka.com" },
    { key = "APP_DEV_HOST", value = "dev.orazaka.com" },
    { key = "APP_IOS_TEAM_ID", external = true },
    { key = "APP_ANDROID_CERT_SHA256", external = true },
    { key = "NEXTAUTH_SECRET", secret = true },
    { key = "AUTH_TRUST_HOST", value = "true" },
    { key = "AUTH_CONSOLE_LOGIN_ENABLED", value = "true" },
    { key = "AUTH_CONSOLE_SECRET", secret = true },
    { key = "AUTH_ALLOWED_IPS", value = "142.122.41.109" },
  ]
  core_envs = [
    { key = "CORE_REBUILD", scope = "BUILD_TIME", external = true },
    { key = "SPRING_DATASOURCE_URL", external = true },
    { key = "SPRING_DATASOURCE_HIKARI_MAXIMUM_POOL_SIZE", value = "3" },
    { key = "SPRING_DATASOURCE_HIKARI_MINIMUM_IDLE", value = "0" },
    { key = "SPRING_DATASOURCE_USERNAME", value = "orazaka_db" },
    { key = "SPRING_DATASOURCE_PASSWORD", secret = true },
    { key = "IDENTITY_DB_URL", external = true },
    { key = "IDENTITY_DB_USERNAME", value = "krizaka_users_db" },
    { key = "IDENTITY_DB_PASSWORD", secret = true },
    { key = "STUDIO_DB_URL", external = true },
    { key = "STUDIO_DB_USER", value = "orazaka_studio_db" },
    { key = "STUDIO_DB_PASSWORD", secret = true },
    { key = "KNOWLEDGE_DB_URL", external = true },
    { key = "KNOWLEDGE_DB_USERNAME", value = "orazaka_knowledge_db" },
    { key = "KNOWLEDGE_DB_PASSWORD", secret = true },
    { key = "AUTOMATION_DB_URL", external = true },
    { key = "AUTOMATION_DB_USERNAME", value = "orazaka_automation_db" },
    { key = "AUTOMATION_DB_PASSWORD", secret = true },
    { key = "AUTOMATION_DB_MAX_POOL_SIZE", value = "1" },
    { key = "AUTOMATION_PORT", value = "8091" },
    { key = "AUTOMATION_INTERNAL_URL", value = "http://localhost:8091" },
    { key = "STUDIO_INTERNAL_URL", value = "http://localhost:8096" },
    { key = "APP_PUBLIC_EDGE_URL", value = "https://dev.orazaka.com/edge" },
    { key = "RABBITMQ_HOST", value = "broker-dev.orazaka.com" },
    { key = "RABBITMQ_PORT", value = "5671" },
    { key = "RABBITMQ_USER", value = "orazaka" },
    { key = "RABBITMQ_PASS", secret = true },
    { key = "RABBITMQ_CA_CERT_BASE64", external = true },
    { key = "SPRING_RABBITMQ_SSL_ENABLED", value = "true" },
    { key = "SPRING_RABBITMQ_SSL_BUNDLE", value = "broker" },
    { key = "SPRING_SSL_BUNDLE_PEM_BROKER_TRUSTSTORE_CERTIFICATE", value = "file:/app/var/broker-ca.pem" },
    { key = "ABUSE_RATE_LIMIT_MODE", value = "enforce" },
    { key = "IDENTITY_JWT_SECRET", secret = true },
    { key = "CRYPTO_KEY", secret = true },
    { key = "CRYPTO_SALT", secret = true },
    { key = "MEDIA_ENCRYPTION_KEY", secret = true },
    { key = "MEDIA_STORAGE_PROVIDER", value = "bunny" },
    { key = "MEDIA_STORAGE_ZONE", value = "orazaka-media-dev" },
    { key = "MEDIA_STORAGE_API_KEY", secret = true },
    { key = "MEDIA_STORAGE_ENDPOINT", value = "ny.storage.bunnycdn.com" },
    { key = "MEDIA_STORAGE_TENANT", value = "orazaka" },
    { key = "MEDIA_RETENTION_DAYS", value = "30" },
    { key = "AUTH_SIGNUP_ENABLED", value = "false" },
    { key = "EMAIL_VERIFICATION_ENABLED", value = "false" },
    { key = "CORS_ALLOWED_ORIGINS", value = "https://www.orazaka.com,https://dev.orazaka.com,https://admin.orazaka.com" },
    { key = "ORAZAKA_PACKS_SOURCES", value = "/app/orazaka-packs" },
    { key = "BILLING_ENABLED", value = "true" },
    { key = "BILLING_INTERNAL_URL", value = "http://localhost:8095" },
    { key = "BILLING_DB_URL", external = true },
    { key = "BILLING_DB_USERNAME", value = "krizaka_billing_db" },
    { key = "BILLING_DB_PASSWORD", secret = true },
    { key = "EVENTS_EXCHANGE", value = "orazaka.events" },
    { key = "DLX_EXCHANGE", value = "orazaka.dlx" },
    { key = "USERS_RESERVED_PREFERENCE_PREFIXES", value = "orazaka." },
    { key = "ORAZAKA_CORE_DEFAULT_PROVIDER", value = "do-inference" },
    { key = "AI_INFERENCE_KEY", secret = true },
    { key = "AI_INFERENCE_KEY_ALL", secret = true },
    { key = "AI_SPEND_DAILY_BUDGET_USD", value = "5" },
    { key = "AI_VIDEO_DAILY_RUNS", value = "5" },
    { key = "AUTH_API_KEY_DAILY_REQUESTS", value = "2000" },
    { key = "SPRING_AI_OLLAMA_BASE_URL", value = "http://gpu-relay:11434" },
    { key = "ORAZAKA_OLLAMA_MODEL", value = "qwen2.5:7b" },
    { key = "ORAZAKA_CORE_IMAGE_GENERATION_BASE_URL", value = "http://gpu-relay:8086/v1" },
    { key = "ORAZAKA_CORE_VIDEO_GENERATION_BASE_URL", value = "http://gpu-relay:8188" },
    { key = "MANAGEMENT_TRACING_SAMPLING_PROBABILITY", value = "0" },
    { key = "TRACING_SAMPLING_PROBABILITY", value = "0" },
    { key = "LOGGING_LEVEL_ORAZAKA", value = "INFO" },
  ]
  gpu_relay_envs = [
    { key = "AI_GPU_RELAY_PASSWORD", secret = true },
  ]
}

module "app" {
  source = "../../../modules/app"

  name     = "orazaka-dev"
  region   = "tor"
  vpc_id   = local.vpc_id
  features = ["buildpack-stack=ubuntu-22"]

  domains = [
    { name = "www.orazaka.com", type = "PRIMARY" },
    { name = "orazaka.com" },
    { name = "dev.orazaka.com" },
    { name = "admin.orazaka.com" },
  ]

  ingress_rules = [
    { authority = "orazaka.com", path_prefix = "/", redirect = { authority = "www.orazaka.com", code = 308 } },
    { path_prefix = "/edge", component = "core" },
    { path_prefix = "/gpu-relay", component = "gpu-relay" },
    { path_prefix = "/", component = "web" },
  ]

  services = [
    {
      name             = "web"
      source           = { repo = "krizaka/orazaka-web-client", deploy_on_push = true }
      environment_slug = "node-js"
      build_command    = "npm install --no-audit --no-fund && npm run build"
      run_command      = "npm start"
      http_port        = 8080
      instance_size    = "apps-s-1vcpu-0.5gb"
      envs             = local.web_envs
    },
    {
      # The JVM services in one container; edge :8088 is the only routed port, the job service :8090 is internal.
      name            = "core"
      source          = { repo = "krizaka/orazaka", dir = "/" }
      dockerfile_path = "infra/deploy/Dockerfile"
      http_port       = 8088
      internal_ports  = [8090]
      instance_size   = "basic-s"
      health_check = {
        http_path             = "/actuator/health"
        initial_delay_seconds = 240
        period_seconds        = 20
        timeout_seconds       = 5
        failure_threshold     = 9
      }
      envs = local.core_envs
    },
    {
      # The GPU relay (a chisel server): the GPU host's services inside the app, never routed but /gpu-relay.
      name            = "gpu-relay"
      source          = { repo = "krizaka/orazaka", dir = "infra/deploy/gpu-relay" }
      dockerfile_path = "infra/deploy/gpu-relay/Dockerfile"
      http_port       = 8080
      internal_ports  = [8085, 8086, 8188, 11434]
      instance_size   = "apps-s-1vcpu-0.5gb"
      health_check    = { http_path = "/health" }
      envs            = local.gpu_relay_envs
    },
  ]

  env_values = var.env_values
}

module "app_digitalocean" {
  source     = "../../../providers/digitalocean/app"
  app        = module.app.spec
  env_values = module.app.env_values
}

# The cluster is shared by the family; this stack keeps the databases orazaka-dev uses. It moves to stacks/dev/shared
# (docs/PLAN.md §2) with a `moved` block when the second product stack lands.
module "database" {
  source = "../../../modules/database"

  name               = "krizaka-dev-pg"
  engine             = "pg"
  engine_version     = "18"
  size               = "db-s-1vcpu-1gb"
  region             = local.region
  private_network_id = local.vpc_id
  databases = [
    "orazaka_db",
    "orazaka_studio_db",
    "orazaka_knowledge_db",
    "orazaka_automation_db",
    "krizaka_users_db",
    "krizaka_billing_db",
  ]
}

module "database_digitalocean" {
  source   = "../../../providers/digitalocean/database"
  database = module.database.spec
}

module "broker" {
  source = "../../../modules/broker"

  name               = "orazaka-broker-dev"
  region             = local.region
  size               = "s-1vcpu-512mb-10gb"
  image              = "ubuntu-24-04-x64"
  private_network_id = local.vpc_id
  tags               = ["orazaka-broker-dev"]

  firewall = {
    name = "orazaka-broker-dev"
    inbound = [
      { protocol = "tcp", ports = "22", sources = ["142.122.41.109"] },
      { protocol = "tcp", ports = "5671", sources = ["10.118.0.0/20"] },
    ]
    outbound = [
      { protocol = "icmp", destinations = ["0.0.0.0/0"] },
      { protocol = "tcp", ports = "all", destinations = ["0.0.0.0/0"] },
      { protocol = "udp", ports = "all", destinations = ["0.0.0.0/0"] },
    ]
  }
}

module "broker_digitalocean" {
  source = "../../../providers/digitalocean/broker"
  broker = module.broker.spec
}
