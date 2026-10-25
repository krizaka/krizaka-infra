# providers/digitalocean/broker — the DigitalOcean adapter of the `broker` role

Takes the `spec` output of `modules/broker` and maps it one to one onto DigitalOcean resources. Every resource has
`prevent_destroy`: a running resource is imported, never recreated. Tests: `tofu test` with a mocked provider (no
credential). See `modules/broker/README.md` for the inputs and an example.

Resources: `digitalocean_droplet` (image, SSH keys and first-boot script ignored after creation: changing them would
recreate the machine), `digitalocean_firewall` (applied to the droplet's tags). Outputs: `id`, `private_ip`, `firewall_id`.
