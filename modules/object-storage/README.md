# modules/object-storage — a private object-storage bucket (role)

The provider-neutral interface of a private bucket that holds a product's documents: private, versioned, TLS only,
with a lifecycle, and one access key limited to this bucket. No resource here: one `spec` for an adapter
(`providers/digitalocean/object-storage`). No input or output carries a credential.

| Input | Type | |
| :--- | :--- | :--- |
| `name` | string | 3 to 63 lowercase letters, digits, hyphens; renaming recreates |
| `region` | string | `tor1` only: personal information stays in Canada (Loi 25 art. 17); another region is added with its assessment |
| `versioning` | bool | default `true` (the rollback of a bad move) |
| `noncurrent_expiration_days` | number | 1 to 90, default 30 (a previous version is personal data: say it in the retention policy) |
| `abort_multipart_days` | number | 1 to 7, default 1 |
| `key_name` | string | default `<name>-app` |

Output: `spec`.

```hcl
module "documents" {
  source = "../../../modules/object-storage"
  name   = "yomizaka-documents-prod"
  region = "tor1"
}

module "documents_digitalocean" {
  source = "../../../providers/digitalocean/object-storage"
  bucket = module.documents.spec
}
```

Tests: `tofu test` (offline).
