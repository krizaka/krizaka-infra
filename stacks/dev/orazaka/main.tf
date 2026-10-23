locals {
  components = {
    web = {
      kind              = "service"
      source_repository = "krizaka/orazaka-web-client"
      branch            = "main"
      deploy_on_push    = true
      build_command     = "npm install --no-audit --no-fund && npm run build"
      run_command       = "npm start"
      http_port         = 8080
      instance_size     = "apps-s-1vcpu-0.5gb"
      instance_count    = 1
      env_vars = {
        APP_SEARCH_INDEXING        = { value = "on", scope = "RUN_AND_BUILD_TIME" }
        AUTH_LOGIN_ENABLED         = { value = "true", scope = "RUN_AND_BUILD_TIME" }
        AUTH_SIGNUP_ENABLED        = { value = "false", scope = "RUN_AND_BUILD_TIME" }
        APP_COMMIT                 = { value = "$${_self.COMMIT_HASH}", scope = "BUILD_TIME" }
        NODE_ENV                   = { value = "production", scope = "RUN_TIME" }
        ROUTER_URL                 = { value = "http://core:8088", scope = "RUN_TIME" }
        NEXTAUTH_URL               = { value = "https://www.orazaka.com", scope = "RUN_TIME" }
        APP_PUBLIC_URL             = { value = "https://www.orazaka.com", scope = "RUN_TIME" }
        APP_DEV_HOST               = { value = "dev.orazaka.com", scope = "RUN_TIME" }
        AUTH_TRUST_HOST            = { value = "true", scope = "RUN_TIME" }
        AUTH_CONSOLE_LOGIN_ENABLED = { value = "true", scope = "RUN_TIME" }
        AUTH_ALLOWED_IPS           = { value = "142.122.41.109", scope = "RUN_TIME" }
      }
    }

    core = {
      kind              = "service"
      source_repository = "krizaka/orazaka"
      branch            = "main"
      deploy_on_push    = false
      dockerfile_path   = "infra/deploy/Dockerfile"
      source_dir        = "/"
      http_port         = 8088
      internal_ports    = [8090]
      instance_size     = "basic-s"
      instance_count    = 1
      health_check = {
        http_path             = "/actuator/health"
        initial_delay_seconds = 240
        period_seconds        = 20
        timeout_seconds       = 5
        failure_threshold     = 9
      }
      env_vars = {
        SPRING_DATASOURCE_HIKARI_MAXIMUM_POOL_SIZE          = { value = "3", scope = "RUN_TIME" }
        SPRING_DATASOURCE_HIKARI_MINIMUM_IDLE               = { value = "0", scope = "RUN_TIME" }
        SPRING_DATASOURCE_USERNAME                          = { value = "orazaka_db", scope = "RUN_TIME" }
        IDENTITY_DB_USERNAME                                = { value = "krizaka_users_db", scope = "RUN_TIME" }
        STUDIO_DB_USER                                      = { value = "orazaka_studio_db", scope = "RUN_TIME" }
        KNOWLEDGE_DB_USERNAME                               = { value = "orazaka_knowledge_db", scope = "RUN_TIME" }
        AUTOMATION_DB_USERNAME                              = { value = "orazaka_automation_db", scope = "RUN_TIME" }
        AUTOMATION_DB_MAX_POOL_SIZE                         = { value = "1", scope = "RUN_TIME" }
        AUTOMATION_PORT                                     = { value = "8091", scope = "RUN_TIME" }
        AUTOMATION_INTERNAL_URL                             = { value = "http://localhost:8091", scope = "RUN_TIME" }
        STUDIO_INTERNAL_URL                                 = { value = "http://localhost:8096", scope = "RUN_TIME" }
        APP_PUBLIC_EDGE_URL                                 = { value = "https://dev.orazaka.com/edge", scope = "RUN_TIME" }
        RABBITMQ_HOST                                       = { value = "broker-dev.orazaka.com", scope = "RUN_TIME" }
        RABBITMQ_PORT                                       = { value = "5671", scope = "RUN_TIME" }
        RABBITMQ_USER                                       = { value = "orazaka", scope = "RUN_TIME" }
        SPRING_RABBITMQ_SSL_ENABLED                         = { value = "true", scope = "RUN_TIME" }
        SPRING_RABBITMQ_SSL_BUNDLE                          = { value = "broker", scope = "RUN_TIME" }
        SPRING_SSL_BUNDLE_PEM_BROKER_TRUSTSTORE_CERTIFICATE = { value = "file:/app/var/broker-ca.pem", scope = "RUN_TIME" }
        ABUSE_RATE_LIMIT_MODE                               = { value = "enforce", scope = "RUN_TIME" }
        MEDIA_STORAGE_PROVIDER                              = { value = "bunny", scope = "RUN_TIME" }
        MEDIA_STORAGE_ZONE                                  = { value = "orazaka-media-dev", scope = "RUN_TIME" }
        MEDIA_STORAGE_ENDPOINT                              = { value = "ny.storage.bunnycdn.com", scope = "RUN_TIME" }
        MEDIA_STORAGE_TENANT                                = { value = "orazaka", scope = "RUN_TIME" }
        MEDIA_RETENTION_DAYS                                = { value = "30", scope = "RUN_TIME" }
        AUTH_SIGNUP_ENABLED                                 = { value = "false", scope = "RUN_TIME" }
        EMAIL_VERIFICATION_ENABLED                          = { value = "false", scope = "RUN_TIME" }
        CORS_ALLOWED_ORIGINS                                = { value = "https://www.orazaka.com,https://dev.orazaka.com,https://admin.orazaka.com", scope = "RUN_TIME" }
        ORAZAKA_PACKS_SOURCES                               = { value = "/app/orazaka-packs", scope = "RUN_TIME" }
        BILLING_ENABLED                                     = { value = "true", scope = "RUN_TIME" }
        BILLING_INTERNAL_URL                                = { value = "http://localhost:8095", scope = "RUN_TIME" }
        BILLING_DB_USERNAME                                 = { value = "krizaka_billing_db", scope = "RUN_TIME" }
        EVENTS_EXCHANGE                                     = { value = "orazaka.events", scope = "RUN_TIME" }
        DLX_EXCHANGE                                        = { value = "orazaka.dlx", scope = "RUN_TIME" }
        USERS_RESERVED_PREFERENCE_PREFIXES                  = { value = "orazaka.", scope = "RUN_TIME" }
        ORAZAKA_CORE_DEFAULT_PROVIDER                       = { value = "do-inference", scope = "RUN_TIME" }
        AI_SPEND_DAILY_BUDGET_USD                           = { value = "5", scope = "RUN_TIME" }
        AI_VIDEO_DAILY_RUNS                                 = { value = "5", scope = "RUN_TIME" }
        AUTH_API_KEY_DAILY_REQUESTS                         = { value = "2000", scope = "RUN_TIME" }
        SPRING_AI_OLLAMA_BASE_URL                           = { value = "http://gpu-relay:11434", scope = "RUN_TIME" }
        ORAZAKA_OLLAMA_MODEL                                = { value = "qwen2.5:7b", scope = "RUN_TIME" }
        ORAZAKA_CORE_IMAGE_GENERATION_BASE_URL              = { value = "http://gpu-relay:8086/v1", scope = "RUN_TIME" }
        ORAZAKA_CORE_VIDEO_GENERATION_BASE_URL              = { value = "http://gpu-relay:8188", scope = "RUN_TIME" }
        MANAGEMENT_TRACING_SAMPLING_PROBABILITY             = { value = "0", scope = "RUN_TIME" }
        TRACING_SAMPLING_PROBABILITY                        = { value = "0", scope = "RUN_TIME" }
        LOGGING_LEVEL_ORAZAKA                               = { value = "INFO", scope = "RUN_TIME" }
      }
    }

    gpu-relay = {
      kind              = "service"
      source_repository = "krizaka/orazaka"
      branch            = "main"
      deploy_on_push    = false
      dockerfile_path   = "infra/deploy/gpu-relay/Dockerfile"
      source_dir        = "infra/deploy/gpu-relay"
      http_port         = 8080
      internal_ports    = [8085, 8086, 8188, 11434]
      instance_size     = "apps-s-1vcpu-0.5gb"
      instance_count    = 1
      health_check = {
        http_path = "/health"
      }
    }
  }

  sensitive_env_vars = {
    web = {
      APP_IOS_TEAM_ID = {
        value  = var.runtime_secrets["APP_IOS_TEAM_ID"]
        scope  = "RUN_TIME"
        secret = false
      }
      APP_ANDROID_CERT_SHA256 = {
        value  = var.runtime_secrets["APP_ANDROID_CERT_SHA256"]
        scope  = "RUN_TIME"
        secret = false
      }
      NEXTAUTH_SECRET = {
        value = var.runtime_secrets["NEXTAUTH_SECRET_WEB"]
        scope = "RUN_TIME"
      }
      AUTH_CONSOLE_SECRET = {
        value = var.runtime_secrets["NEXTAUTH_SECRET_ADMIN"]
        scope = "RUN_TIME"
      }
    }

    core = {
      CORE_REBUILD = {
        value  = var.runtime_secrets["CORE_REBUILD"]
        scope  = "BUILD_TIME"
        secret = false
      }
      SPRING_DATASOURCE_URL = {
        value  = "jdbc:postgresql://${var.runtime_secrets["DATABASE_HOST"]}:25061/pool-orazaka?sslmode=require&prepareThreshold=0"
        scope  = "RUN_TIME"
        secret = false
      }
      SPRING_DATASOURCE_PASSWORD = {
        value = var.runtime_secrets["DATABASE_PASSWORD_ORAZAKA_DB"]
        scope = "RUN_TIME"
      }
      IDENTITY_DB_URL = {
        value  = "jdbc:postgresql://${var.runtime_secrets["DATABASE_HOST"]}:25061/pool-users?sslmode=require&prepareThreshold=0"
        scope  = "RUN_TIME"
        secret = false
      }
      IDENTITY_DB_PASSWORD = {
        value = var.runtime_secrets["DATABASE_PASSWORD_KRIZAKA_USERS_DB"]
        scope = "RUN_TIME"
      }
      STUDIO_DB_URL = {
        value  = "jdbc:postgresql://${var.runtime_secrets["DATABASE_HOST"]}:25061/pool-studio?sslmode=require&prepareThreshold=0"
        scope  = "RUN_TIME"
        secret = false
      }
      STUDIO_DB_PASSWORD = {
        value = var.runtime_secrets["DATABASE_PASSWORD_ORAZAKA_STUDIO_DB"]
        scope = "RUN_TIME"
      }
      KNOWLEDGE_DB_URL = {
        value  = "jdbc:postgresql://${var.runtime_secrets["DATABASE_HOST"]}:25061/pool-knowledge?sslmode=require&prepareThreshold=0"
        scope  = "RUN_TIME"
        secret = false
      }
      KNOWLEDGE_DB_PASSWORD = {
        value = var.runtime_secrets["DATABASE_PASSWORD_ORAZAKA_KNOWLEDGE_DB"]
        scope = "RUN_TIME"
      }
      AUTOMATION_DB_URL = {
        value  = "jdbc:postgresql://${var.runtime_secrets["DATABASE_HOST"]}:25061/pool-automation?sslmode=require&prepareThreshold=0"
        scope  = "RUN_TIME"
        secret = false
      }
      AUTOMATION_DB_PASSWORD = {
        value = var.runtime_secrets["DATABASE_PASSWORD_ORAZAKA_AUTOMATION_DB"]
        scope = "RUN_TIME"
      }
      RABBITMQ_PASS = {
        value = var.runtime_secrets["RABBITMQ_PASS"]
        scope = "RUN_TIME"
      }
      RABBITMQ_CA_CERT_BASE64 = {
        value  = var.runtime_secrets["RABBITMQ_CA_CERT_BASE64"]
        scope  = "RUN_TIME"
        secret = false
      }
      IDENTITY_JWT_SECRET = {
        value = var.runtime_secrets["IDENTITY_JWT_SECRET"]
        scope = "RUN_TIME"
      }
      CRYPTO_KEY = {
        value = var.runtime_secrets["CRYPTO_KEY"]
        scope = "RUN_TIME"
      }
      CRYPTO_SALT = {
        value = var.runtime_secrets["CRYPTO_SALT"]
        scope = "RUN_TIME"
      }
      MEDIA_ENCRYPTION_KEY = {
        value = var.runtime_secrets["MEDIA_ENCRYPTION_KEY"]
        scope = "RUN_TIME"
      }
      MEDIA_STORAGE_API_KEY = {
        value = var.runtime_secrets["MEDIA_STORAGE_API_KEY"]
        scope = "RUN_TIME"
      }
      BILLING_DB_URL = {
        value  = "jdbc:postgresql://${var.runtime_secrets["DATABASE_HOST"]}:25061/pool-billing?sslmode=require&prepareThreshold=0"
        scope  = "RUN_TIME"
        secret = false
      }
      BILLING_DB_PASSWORD = {
        value = var.runtime_secrets["BILLING_DB_PASSWORD"]
        scope = "RUN_TIME"
      }
      AI_INFERENCE_KEY = {
        value = var.runtime_secrets["AI_INFERENCE_KEY"]
        scope = "RUN_TIME"
      }
      AI_INFERENCE_KEY_ALL = {
        value = var.runtime_secrets["AI_INFERENCE_KEY_ALL"]
        scope = "RUN_TIME"
      }
    }

    gpu-relay = {
      AI_GPU_RELAY_PASSWORD = {
        value = var.runtime_secrets["AI_GPU_RELAY_PASSWORD"]
        scope = "RUN_TIME"
      }
    }
  }
}

module "orazaka" {
  source = "../../../providers/digitalocean/app"

  name   = "orazaka-dev"
  region = "tor"

  components         = local.components
  sensitive_env_vars = local.sensitive_env_vars
  domains = [
    { domain = "www.orazaka.com", type = "PRIMARY" },
    { domain = "orazaka.com", type = "ALIAS" },
    { domain = "dev.orazaka.com", type = "ALIAS" },
    { domain = "admin.orazaka.com", type = "ALIAS" },
  ]

  features = ["buildpack-stack=ubuntu-22"]
  vpc_id   = "60296b32-efad-49be-bb41-321b1b6cc328"

  ingress_rules = [
    {
      authority_exact    = "orazaka.com"
      redirect_authority = "www.orazaka.com"
      redirect_code      = 308
    },
    { component = "core", path_prefix = "/edge" },
    { component = "gpu-relay", path_prefix = "/gpu-relay" },
    { component = "web", path_prefix = "/" },
  ]
}
