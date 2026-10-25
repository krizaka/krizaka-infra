terraform {
  required_version = "1.13.2"

  # State stays local and outside the repository until the S3-compatible backend is decided (docs/PLAN.md §2):
  # `tofu init -backend-config="path=$HOME/.krizaka-infra/state/dev-orazaka.tfstate"` (README).
  backend "local" {}

  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "2.106.0"
    }
  }
}

# The token comes from DIGITALOCEAN_TOKEN in the environment (docs/SECRETS.md), never from a file.
provider "digitalocean" {}
