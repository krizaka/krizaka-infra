# modules/broker — a message broker host (role)

The provider-neutral interface of a broker host: one machine in a private network, and its firewall (SSH is never open to
the whole internet). The broker's own setup (RabbitMQ, TLS) stays with `krizaka/orazaka` `scripts/dev-deploy.mjs broker`.
No resource here: one `spec` for an adapter (`providers/digitalocean/broker`).

| Input | Type | |
| :--- | :--- | :--- |
| `name`, `region`, `size`, `image`, `private_network_id` | string | required |
| `tags` | list(string) | the firewall applies to them |
| `monitoring` | bool | default `false` |
| `firewall` | {name, inbound[{protocol, ports, sources}], outbound[{protocol, ports, destinations}]} | ports `"all"` for every port |

Output: `spec`.

```hcl
module "broker" {
  source             = "../../../modules/broker"
  name               = "orazaka-broker-dev"
  region             = "tor1"
  size               = "s-1vcpu-512mb-10gb"
  image              = "ubuntu-24-04-x64"
  private_network_id = "<vpc id>"
  tags               = ["orazaka-broker-dev"]
  firewall = {
    name     = "orazaka-broker-dev"
    inbound  = [{ protocol = "tcp", ports = "5671", sources = ["10.118.0.0/20"] }]
    outbound = [{ protocol = "tcp", ports = "all", destinations = ["0.0.0.0/0"] }]
  }
}
```

Tests: `tofu test` (offline).
