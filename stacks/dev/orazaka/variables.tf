variable "runtime_secrets" {
  description = "Values supplied by the vault for the existing app's environment."
  type        = map(string)
  sensitive   = true

  validation {
    condition = alltrue([
      for key in [
        "APP_IOS_TEAM_ID",
        "APP_ANDROID_CERT_SHA256",
        "NEXTAUTH_SECRET_WEB",
        "NEXTAUTH_SECRET_ADMIN",
        "CORE_REBUILD",
        "DATABASE_HOST",
        "DATABASE_PASSWORD_ORAZAKA_DB",
        "DATABASE_PASSWORD_KRIZAKA_USERS_DB",
        "DATABASE_PASSWORD_ORAZAKA_STUDIO_DB",
        "DATABASE_PASSWORD_ORAZAKA_KNOWLEDGE_DB",
        "DATABASE_PASSWORD_ORAZAKA_AUTOMATION_DB",
        "RABBITMQ_PASS",
        "RABBITMQ_CA_CERT_BASE64",
        "IDENTITY_JWT_SECRET",
        "CRYPTO_KEY",
        "CRYPTO_SALT",
        "MEDIA_ENCRYPTION_KEY",
        "MEDIA_STORAGE_API_KEY",
        "BILLING_DB_PASSWORD",
        "AI_INFERENCE_KEY",
        "AI_INFERENCE_KEY_ALL",
        "AI_GPU_RELAY_PASSWORD",
      ] : contains(keys(var.runtime_secrets), key)
    ])
    error_message = "runtime_secrets must contain every key listed in stacks/dev/orazaka/README.md."
  }
}
