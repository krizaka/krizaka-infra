# modules/dns — DNS records (role)

The provider-neutral interface of a zone's records (`A`, `AAAA`, `CNAME`, `ALIAS`, `TXT`, `MX`, `CAA`, `NS`, `SRV`;
TTL ≥ 60, default 600). No resource here. The adapter, `providers/porkbun/dns`, comes with docs/PLAN.md step 5: the
family's DNS is at Porkbun, not DigitalOcean, so `stacks/dev/orazaka` does not use this role yet.

| Input | Type |
| :--- | :--- |
| `zone` | string |
| `records` | list({name, type, value, ttl}) |

Output: `spec`.

```hcl
module "dns" {
  source  = "../../../modules/dns"
  zone    = "orazaka.com"
  records = [{ name = "www", type = "CNAME", value = "orazaka-dev-averr.ondigitalocean.app." }]
}
```

Tests: `tofu test` (offline).
