# modules/dns — DNS records (role)

The provider-neutral interface of a zone's records (`A`, `AAAA`, `CNAME`, `ALIAS`, `TXT`, `MX`, `CAA`, `NS`, `SRV`;
TTL >= 60, default 600). No resource here. The adapter is `providers/porkbun/dns`; the family's zones are in
[`stacks/dns`](../../stacks/dns).

| Input | Type |
| :--- | :--- |
| `zone` | string |
| `records` | map of {name, type, value, ttl, prio, kind, purpose, managed}, keyed by a stable name |

`kind` is `app` (the default), `mail`, `verification`, `acme` or `nameserver`; `purpose` is required (which app or site
needs the record). `managed = false` (default `true`) lists a record that exists but that the adapter cannot manage
(Porkbun's provider refuses a TTL under 600): it is documented here, never created, changed or imported. A CNAME at the apex is refused (use an `ALIAS`).

Outputs: `spec`, `mail_records` (the keys of the records of kind `mail`).

```hcl
module "dns" {
  source = "../../modules/dns"
  zone   = "orazaka.com"
  records = {
    "www-cname" = { name = "www", type = "CNAME", value = "orazaka-dev-averr.ondigitalocean.app", purpose = "www.orazaka.com serves orazaka-dev" }
  }
}
```

Tests: `tofu test` (offline).
