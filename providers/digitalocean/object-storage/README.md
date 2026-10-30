# providers/digitalocean/object-storage

The DigitalOcean adapter of `modules/object-storage`: a private Spaces bucket (versioned, lifecycle), and one Spaces key with `readwrite` on that bucket only. The bucket has `prevent_destroy`.

Input: `bucket`, the `spec` of the role. Outputs: `bucket`, `endpoint`, `region`, `access_key_id` (the secret is never an output).

Server-side encryption options of the provider are not relied on: the application encrypts every object before it leaves
(yomizaka ADR-0012), so the provider only holds ciphertext. Tests: `tofu test` (offline, mocked provider).

## Why there is no bucket policy (no `tls_only` policy)

DigitalOcean refuses a bucket-scoped Spaces key on a bucket that has an S3 bucket policy (`412 Bucket has a bucket policy.
Only 'All Permissions' access keys support buckets with S3 bucket policies.`). Least privilege wins: the key stays scoped to
this bucket, so the `DenyPlainHttp` policy is dropped. HTTPS is enforced by the client, which only uses the https `endpoint`
output (yomizaka asserts it in a test). The role's `tls_only` field stays in the spec as the requirement the client meets.
