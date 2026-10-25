terraform {
  required_version = "1.13.2"

  # State stays local and outside the repository, as in stacks/dev/orazaka (the backend decided in #8):
  # `tofu init -backend-config="path=$HOME/.krizaka-infra/state/dns.tfstate"` (README). CI plans with no state at all:
  # the import blocks bring the live records into the plan, and the plan must change nothing.
  backend "local" {}

  required_providers {
    porkbun = {
      source  = "marcfrederick/porkbun"
      version = "1.2.0"
    }
  }
}

# The keys come from PORKBUN_API_KEY and PORKBUN_SECRET_API_KEY in the environment (docs/SECRETS.md), never from a file.
provider "porkbun" {
  # Porkbun answers 403 to bursts: the plan reads each record, so it goes slowly (scripts/dns-plan.sh) and retries.
  max_retries = 8
}
