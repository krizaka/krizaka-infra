mock_provider "digitalocean" {}

run "a_droplet_behind_its_firewall" {
  command = plan
  variables {
    broker = {
      name               = "orazaka-broker-dev"
      region             = "tor1"
      size               = "s-1vcpu-512mb-10gb"
      image              = "ubuntu-24-04-x64"
      private_network_id = "vpc-1"
      tags               = ["orazaka-broker-dev"]
      monitoring         = false
      firewall = {
        name     = "orazaka-broker-dev"
        inbound  = [{ protocol = "tcp", ports = "5671", sources = ["10.118.0.0/20"] }]
        outbound = [{ protocol = "icmp", ports = null, destinations = ["0.0.0.0/0"] }]
      }
    }
  }
  assert {
    condition     = digitalocean_firewall.this.tags == toset(["orazaka-broker-dev"])
    error_message = "The firewall applies to the droplet's tags."
  }
  assert {
    condition     = digitalocean_droplet.this.vpc_uuid == "vpc-1"
    error_message = "The droplet stays in its VPC."
  }
}
