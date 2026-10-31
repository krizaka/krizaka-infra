# modules/document-storage — replicated document storage (role)

The provider-neutral interface of the managed document storage (krizaka-internal#1929): a primary bucket `docs-<env>`
and a replica `docs-<env>-replica` in a second Canadian region, versioned, TLS only, with a lifecycle (previous versions,
trash, unfinished uploads), a governance object lock on the replica, and least-privilege users. No resource here: one
`spec` for an adapter (`providers/ovh/document-storage`; if the gate of #1929 fails, a `providers/aws/document-storage` adapter is written on `terraform-aws-modules/s3-bucket` and `kms`, same spec). No input or
output carries an access key.

| Input | Type | |
| :--- | :--- | :--- |
| `env` | string | `dev` or `prod` |
| `primary_region` / `replica_region` | string | logical regions, different; the adapter validates they are Canadian |
| `noncurrent_expiration_days` | number | previous versions kept, default 30 |
| `trash_prefix` / `trash_expiration_days` | string / number | `trash/`, 30 |
| `abort_multipart_days` | number | default 1 |
| `replica_lock_days` | number | governance retention on the replica, default 30 (0 = off) |

Output: `spec`.

```hcl
module "documents" {
  source         = "../../../modules/document-storage"
  env            = "dev"
  primary_region = "bhs"
  replica_region = "ca-east-tor"
}
```
