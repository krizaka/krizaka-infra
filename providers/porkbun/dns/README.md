# providers/porkbun/dns — the Porkbun adapter of the `dns` role

Takes the `spec` of `modules/dns` and maps each record one to one onto a `porkbun_dns_record` of the community provider
[`marcfrederick/porkbun`](https://registry.opentofu.org/providers/marcfrederick/porkbun) (why this one: see the root README).
The apex (`@`) is an empty subdomain at Porkbun. Records are imported with `<domain>:<porkbun record id>`
([`stacks/dns/imports.tf`](../../../stacks/dns/imports.tf)). Credentials: `PORKBUN_API_KEY` and `PORKBUN_SECRET_API_KEY`
in the environment, never in a file. Tests: `tofu test` with a mocked provider (no credential). Output: `record_ids`.

The Porkbun provider refuses a TTL under 600, and seven Mailgun records of krizaka.com live at 300: the role lists them
with `managed = false` and this adapter skips them (the stack's README says which and why).
