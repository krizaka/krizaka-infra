variables {
  name               = "orazaka-broker-dev"
  region             = "tor1"
  size               = "s-1vcpu-512mb-10gb"
  image              = "ubuntu-24-04-x64"
  private_network_id = "vpc-1"
  tags               = ["orazaka-broker-dev"]
}

run "a_broker_behind_its_firewall" {
  command = plan
  variables {
    firewall = {
      name     = "orazaka-broker-dev"
      inbound  = [{ protocol = "tcp", ports = "5671", sources = ["10.118.0.0/20"] }]
      outbound = [{ protocol = "tcp", ports = "all", destinations = ["0.0.0.0/0"] }]
    }
  }
  assert {
    condition     = output.spec.firewall.inbound[0].ports == "5671"
    error_message = "The firewall is kept."
  }
}

run "refuses_ssh_open_to_the_internet" {
  command = plan
  variables {
    firewall = {
      name     = "x"
      inbound  = [{ protocol = "tcp", ports = "22", sources = ["0.0.0.0/0"] }]
      outbound = []
    }
  }
  expect_failures = [var.firewall]
}
