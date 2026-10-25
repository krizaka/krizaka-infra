<div align="center">

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/krizaka/.github/main/profile/assets/krizaka-dark.svg">
  <img src="https://raw.githubusercontent.com/krizaka/.github/main/profile/assets/krizaka-light.svg" alt="Krizaka" width="96">
</picture>

# krizaka-infra

**The Krizaka family's infrastructure, as code — portable.** What runs today (DigitalOcean App Platform, a managed
PostgreSQL, a broker droplet, DNS at Porkbun, media on Bunny) described in OpenTofu, behind provider-neutral modules, so
a product can move to another provider by swapping an adapter, not by rewriting its deployment.

[![License](https://img.shields.io/badge/license-Apache--2.0-blue)](LICENSE)

</div>

## Status

**Planning.** The plan, the inventory and the rules are in [docs/PLAN.md](docs/PLAN.md). Nothing here changes live
infrastructure until a stack's `tofu plan` against the running resources is a **no-op** (imported, not recreated).

The role modules (`app`, `database`, `broker`, `dns`, `cdn`) and the DigitalOcean adapters are written and tested; the
first stack, [`stacks/dev/orazaka`](stacks/dev/orazaka), imports orazaka-dev's 10 resources and its first plan
(2026-10-24) changes nothing but one import artifact of the provider, explained in its README.

## Principles

- **The database is the source of truth; infrastructure is reproducible.** Every resource can be rebuilt from this
  repository plus the secrets vault.
- **Portable by design.** Modules speak in roles (`app`, `database`, `dns`, `cdn`, `broker`, `object-store`); providers
  are adapters (`digitalocean` first).
- **No secret in git.** Values come from the environment at plan/apply time; the repository holds names only.
- **Import before change.** Existing resources are imported; the first plan of every stack changes nothing.
- **Cost is a decision.** No new paid resource without Oussama's go (over $5/month).

## Layout

```
modules/<role>/                 provider-neutral interface (variables, outputs)
providers/<provider>/<role>/    the adapter (digitalocean first)
stacks/<env>/<product>/         one stack per product and environment (dev today)
docs/                           plan, runbooks, the inventory
```

## Checks

Every pull request runs `.github/workflows/ci.yml`, with **no cloud credentials**: `tofu fmt -check`, `tofu validate`
and `tofu test` (mocked providers) on every module and stack (`scripts/check.sh`, the same locally), `tflint` and
`checkov`. Versions are pinned in `.tool-versions`. State, plan files and `*.tfvars` are git-ignored.

## DNS

The family's DNS (8 domains at Porkbun, 134 records) is code in [`stacks/dns`](stacks/dns): the purpose of every record,
how to add a subdomain, why the community provider `marcfrederick/porkbun` was chosen, and the read-only plan
(`0 to add, 0 to change, 0 to destroy`) that CI runs on every pull request and every day as a drift check. Applying is
Oussama's step ([ADR-001](docs/adr/ADR-001-dns-apply.md)).
