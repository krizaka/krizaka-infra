# providers/digitalocean/database — the DigitalOcean adapter of the `database` role

Takes the `spec` output of `modules/database` and maps it one to one onto DigitalOcean resources. Every resource has
`prevent_destroy`: a running resource is imported, never recreated. Tests: `tofu test` with a mocked provider (no
credential). See `modules/database/README.md` for the inputs and an example.

Resources: `digitalocean_database_cluster`, one `digitalocean_database_db` per database. Outputs: `id`, `private_host`,
`port`, `databases` — never a password or a URI.
