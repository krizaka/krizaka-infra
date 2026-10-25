terraform {
  required_version = ">= 1.13.0"
  required_providers {
    porkbun = {
      source  = "marcfrederick/porkbun"
      version = "~> 1.2"
    }
  }
}
