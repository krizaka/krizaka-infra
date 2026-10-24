# modules/cdn — storage and edge (role)

The provider-neutral interface of a CDN: storage zones (the files) and the pull zones in front (a storage zone or an
origin URL each). No resource here. The adapter, `providers/bunny/cdn` (read-only first), comes with docs/PLAN.md step 7
(#3); `stacks/dev/orazaka` does not use this role yet.

| Input | Type |
| :--- | :--- |
| `storage_zones` | list({name, region}) |
| `pull_zones` | list({name, storage_zone \| origin_url}) |

Output: `spec`.

```hcl
module "cdn" {
  source        = "../../../modules/cdn"
  storage_zones = [{ name = "krizaka-assets", region = "NY" }]
  pull_zones    = [{ name = "krizaka-assets", storage_zone = "krizaka-assets" }]
}
```

Tests: `tofu test` (offline).
