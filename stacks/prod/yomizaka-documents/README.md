# stacks/prod/yomizaka-documents — the production document store of Yomizaka

A private, versioned DigitalOcean Spaces bucket in Toronto (`tor1`), a policy that refuses plain HTTP, a lifecycle (unfinished uploads
after 1 day, previous versions after 30 days) and one key with `readwrite` on this bucket only. New infrastructure
(krizaka/yomizaka#524): a first plan creates a bucket, its policy and a key.

**An agent never applies this.** The founder, after reading the plan and signing the DigitalOcean DPA (the lawyer's list is in
yomizaka `docs/privacy/production-store-canada.md` §4):

```sh
export DIGITALOCEAN_TOKEN=… SPACES_ACCESS_KEY_ID=… SPACES_SECRET_ACCESS_KEY=…   # docs/SECRETS.md; never written in a file
tofu init -backend-config="path=$HOME/.krizaka-infra/state/prod-yomizaka-documents.tfstate"
tofu plan      # expected: 3 to add, 0 to change, 0 to destroy
tofu apply
tofu output admin_screen
```

Then, in Yomizaka's admin storage screen: add a provider (kind `s3`, preset DigitalOcean Spaces) with the endpoint, region and bucket of the output and the
key pair (the secret from the DigitalOcean account; it is sealed by the app and never shown again), test it, and set it as the default of the documents. In
production the app refuses a provider that is not in Canada.

Cost: Spaces starts at USD 5 a month with 250 GiB stored and 1 TiB out (list price, to confirm when signing).
