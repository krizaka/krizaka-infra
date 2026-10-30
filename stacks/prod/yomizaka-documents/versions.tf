terraform {
  required_version = "1.13.2"

  # State stays local and outside the repository until the S3-compatible backend is decided (docs/PLAN.md §2):
  # `tofu init -backend-config="path=$HOME/.krizaka-infra/state/prod-yomizaka-documents.tfstate"` (README).
  backend "local" {}

  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "2.106.0"
    }
  }
}

# The token and the Spaces keys of the operator come from the environment (docs/SECRETS.md), never from a file:
# DIGITALOCEAN_TOKEN, SPACES_ACCESS_KEY_ID, SPACES_SECRET_ACCESS_KEY.
provider "digitalocean" {}
