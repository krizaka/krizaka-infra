# providers/digitalocean/app — the DigitalOcean adapter of the `app` role

Takes the `spec` output of `modules/app` and maps it one to one onto DigitalOcean resources. Every resource has
`prevent_destroy`: a running resource is imported, never recreated. Tests: `tofu test` with a mocked provider (no
credential). See `modules/app/README.md` for the inputs and an example.

Resource: `digitalocean_app`. Outputs: `id`, `default_url`, `live_url`. A SECRET env keeps the value App Platform holds:
pass the encrypted `EV[…]` value it returns (`doctl apps spec get`) and nothing changes; pass a plain value to change it.
