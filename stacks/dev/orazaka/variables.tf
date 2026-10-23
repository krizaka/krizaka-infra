variable "runtime_secrets" {
  description = "Sensitive runtime configuration supplied by the vault."
  type        = map(string)
  sensitive   = true

  validation {
    condition = alltrue([
      for key in [
        "APP_IOS_TEAM_ID",
        "APP_ANDROID_CERT_SHA256",
        "AUTH_ALLOWED_IPS",
        "CORE_REBUILD",
        "DATABASE_HOST",
        "RABBITMQ_CA_CERT_BASE64",
        "VPC_ID",
      ] : contains(keys(var.runtime_secrets), key)
    ])
    error_message = "runtime_secrets must contain every key listed in stacks/dev/orazaka/README.md."
  }
}

variable "imported_secret_ciphertext" {
  description = "Existing DigitalOcean EV[...] values for SECRET env vars, supplied by the vault."
  type        = map(string)
  sensitive   = true

  validation {
    condition = alltrue([
      for key in [
        "NEXTAUTH_SECRET",
        "AUTH_CONSOLE_SECRET",
        "SPRING_DATASOURCE_PASSWORD",
        "IDENTITY_DB_PASSWORD",
        "STUDIO_DB_PASSWORD",
        "KNOWLEDGE_DB_PASSWORD",
        "AUTOMATION_DB_PASSWORD",
        "RABBITMQ_PASS",
        "IDENTITY_JWT_SECRET",
        "CRYPTO_KEY",
        "CRYPTO_SALT",
        "MEDIA_ENCRYPTION_KEY",
        "MEDIA_STORAGE_API_KEY",
        "BILLING_DB_PASSWORD",
        "AI_INFERENCE_KEY",
        "AI_INFERENCE_KEY_ALL",
        "AI_GPU_RELAY_PASSWORD",
      ] : contains(keys(var.imported_secret_ciphertext), key)
    ])
    error_message = "imported_secret_ciphertext must contain every existing SECRET env value listed in stacks/dev/orazaka/README.md."
  }
}
