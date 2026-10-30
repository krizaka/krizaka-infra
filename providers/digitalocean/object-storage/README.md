# providers/digitalocean/object-storage

The DigitalOcean adapter of `modules/object-storage`: a private Spaces bucket (versioned, lifecycle), a bucket policy that denies
plain HTTP, and one Spaces key with `readwrite` on that bucket only. The bucket has `prevent_destroy`.

Input: `bucket`, the `spec` of the role. Outputs: `bucket`, `endpoint`, `region`, `access_key_id` (the secret is never an output).

Server-side encryption options of the provider are not relied on: the application encrypts every object before it leaves
(yomizaka ADR-0012), so the provider only holds ciphertext. Tests: `tofu test` (offline, mocked provider).
