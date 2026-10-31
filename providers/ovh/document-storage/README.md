# providers/ovh/document-storage — OVHcloud adapter of `modules/document-storage`

Turns the `spec` of `modules/document-storage` into OVHcloud Public Cloud resources, with the **official provider**
`ovh/ovh` (pinned `~> 2.24`; no community module exists for this): the primary bucket and its replica (versioning,
server-side encryption, asynchronous replication, governance object lock on the replica), the lifecycle of both, one S3
user per role of the spec with an S3 policy of exactly its actions, and the environment's OKMS root key. **Never applied
by an agent**: the CTO plans and applies (krizaka-internal#1929).

| Input | Type | |
| :--- | :--- | :--- |
| `storage` | any | the `spec` output of `modules/document-storage` |
| `project_id` | string | the Public Cloud project (ordered by the account owner) |
| `okms_subsidiary` / `okms_region` | string | `CA` / `ca-east-bhs` |

Outputs: `primary_bucket`, `replica_bucket`, `access_key_ids`, `okms_root_key_id`. A secret key is never an output: it stays
`sensitive` in the state and is copied once to the vault.

```hcl
module "documents" {
  source         = "../../../modules/document-storage"
  env            = "dev"
  primary_region = "bhs"
  replica_region = "ca-east-tor"
}

module "documents_ovh" {
  source     = "../../../providers/ovh/document-storage"
  storage    = module.documents.spec
  project_id = var.project_id
}
```

To confirm on the first real plan (the CTO's): `ovh_cloud_project_storage` is the resource that supports replication but
is marked deprecated in favour of `ovh_cloud_storage_object_bucket`, which has no replication yet; the move happens (with
`moved` blocks) when it does. The region names (`BHS`, `CA-EAST-TOR`) and the `objectstore_operator` role are the
provider's documented values, not yet seen against the live API.
