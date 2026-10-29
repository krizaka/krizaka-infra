# stacks/dns — the DNS of the Krizaka family, as code

The 8 domains held at Porkbun (134 records, 2026-10-25), one `zone_<domain>.tf` each, through the `dns` role
([`modules/dns`](../../modules/dns)) and the Porkbun adapter ([`providers/porkbun/dns`](../../providers/porkbun/dns)).
`imports.tf` imports the 127 records the adapter can manage (7 are only listed, see « Known limit »).

**Never apply from an agent or from CI** ([ADR-001](../../docs/adr/ADR-001-dns-apply.md)). A change is a pull request
here, a reviewed plan, then Oussama's `tofu apply` (or an approved workflow, later).

## The provider, and why this one

[`marcfrederick/porkbun`](https://registry.opentofu.org/providers/marcfrederick/porkbun) `1.2.0`, pinned exactly, with a
committed lock file. Porkbun publishes no provider of its own; of the community ones this is the maintained one
(releases through 2026, MPL-2.0, v1 with a stable schema). It imports a record by `<domain>:<record id>`, reads the keys
from the environment and is on the OpenTofu registry. The older `kyswtn/porkbun` (last release 2025-02) and
`cullenmcdermott/porkbun` (v0.x) were passed over for that reason. A provider swap stays inside the adapter.

## Plan it (read-only)

```sh
# The keys are read inside the command, never printed nor written to a file (docs/SECRETS.md).
PORKBUN_API_KEY=$(…) PORKBUN_SECRET_API_KEY=$(…) ../../scripts/dns-plan.sh
# Plan: 127 to import, 0 to add, 0 to change, 0 to destroy.
```

`scripts/dns-plan.sh` plans with an empty throw-away state: the `import` blocks bring the live records into the plan, so
the same command runs on a laptop and in CI, and exits 1 when the live DNS differs from the code (a record to add, change
or destroy). Porkbun answers 403 to bursts, so the plan reads two records at a time. The state of a real apply, if
Oussama makes one, stays local and outside the repository
(`tofu init -backend-config="path=$HOME/.krizaka-infra/state/dns.tfstate"`); state, plans and variable files are git-ignored.

CI (`.github/workflows/dns-plan.yml`): that plan on every pull request that touches the DNS, and **every day at 06:17 UTC**
as the drift check: it fails when the live DNS differs from the code, and opens (or updates) one issue.
The keys are the repository secrets `PORKBUN_API_KEY` and `PORKBUN_SECRET_KEY`.

## Add a subdomain

One entry in the zone's file (`zone_<domain>.tf`), nothing else:

```hcl
"docs-cname" = { name = "docs", type = "CNAME", value = "krizaka-docs-abc12.ondigitalocean.app", purpose = "docs.krizaka.com serves the docs site (App Platform)" }
```

The key (`docs-cname`) is the record's identity: pick it once. `kind` is `app` by default. Open the pull request: the plan
must say `1 to add, 0 to change, 0 to destroy`, and nothing else. A record created at Porkbun by hand is not a drift the
plan can see (it reads only the records in the code): put it in the file with an `import` block in `imports.tf`
(`id = "<domain>:<record id>"`) and the plan shows it as imported.

## Mail records: do not touch without a mail test

Mailgun (`mg.krizaka.com`, DKIM of `www.krizaka.com`), Resend (`mg.orochia.com`), DKIM keys, SPF, DMARC and Porkbun's
email forwarding (MX) are `kind = "mail"` and listed by the `mail_records` output. Before changing one, send a test
message through the service and read the headers (SPF, DKIM and DMARC pass). Verification TXT records (Google Search
Console, GitHub, Maven Central) are `kind = "verification"`: deleting one un-verifies the owner. There is no Bing record
(Bing Webmaster is verified another way). The `_acme-challenge` TXT records are leftovers of certificate issuance, kept
as they are.

## Known limit: seven records at TTL 300

The Porkbun provider refuses a TTL under 600 (its own schema), and seven Mailgun records of `krizaka.com` live at 300
(`pdk1`/`pdk2._domainkey.www` DKIM CNAMEs, the `email.mg` CNAME, the SPF and DKIM TXT of `mg`, the DMARC TXT of `www`
and `mg`). Writing 600 would change a mail record, and 300 fails validation, so they are listed with `managed = false`:
documented, never created, changed or imported, and not watched by the drift check. Raising the limit upstream, or
moving them to 600 after a mail test, makes them managed.

## Ansible?

Not now. Everything Krizaka runs is managed (DigitalOcean App Platform, Bunny, GitHub Pages): there is no server to
configure. Ansible becomes useful the day we run our own machines (a GPU worker, a self-hosted runner). Revisit then,
through an ADR in this repository.

## Krizaka Lab move (krizaka-motion#69), applied by the CTO after the founder's go

The lab changes address: `motion.krizaka.com` becomes `lab.krizaka.com`. Nothing here is applied by a pull request.

1. Rename the repository `krizaka-motion` to `krizaka-lab` and merge its pull request (its `CNAME` file becomes `lab.krizaka.com`). Done 2026-10-29.
2. `tofu apply` in this stack creates `lab` CNAME `krizaka.github.io` (TTL 600). Then set the Pages custom domain of `krizaka-lab`.
3. GitHub Pages cannot answer a 301 from the old host once the `CNAME` file changed, so `motion` becomes a Porkbun URL forward:
   the `motion` record is no longer in this stack (entry and import removed; the live record is deleted through the Porkbun API just before the forward is added),
   then call `POST https://api.porkbun.com/api/json/v3/domain/addUrlForward/krizaka.com` with
   `{"subdomain":"motion","location":"https://lab.krizaka.com","type":"permanent","includePath":"yes","wildcard":"no"}`
   (keys through `secret.sh`). Forwards are not Terraform resources: this section is their record.
4. Check: `curl -sI https://motion.krizaka.com/story` answers 301 with `location: https://lab.krizaka.com/story`.

## Records and their purpose

Generated from the zone files.

### krizaka.com (27)

| Name | Type | Kind | Purpose |
| :--- | :--- | :--- | :--- |
| `@` | ALIAS | app | krizaka.com serves the krizaka-com app (App Platform) |
| `blog` | CNAME | app | blog.krizaka.com serves the krizaka-blog app (App Platform) |
| `java` | CNAME | app | java.krizaka.com serves the krizaka-java-site app (App Platform) |
| `lab` | CNAME | app | lab.krizaka.com serves the krizaka-lab site (GitHub Pages) |
| `ts` | CNAME | app | ts.krizaka.com serves the krizaka-ts-site app (App Platform) |
| `ui` | CNAME | app | ui.krizaka.com serves the krizaka-ui-site app (App Platform) |
| `www` | CNAME | app | www.krizaka.com serves the krizaka-com app (App Platform) |
| `@` | MX | mail | Porkbun email forwarding for krizaka.com (MX, priority 10) |
| `@` | MX | mail | Porkbun email forwarding for krizaka.com (MX, priority 20) |
| `@` | TXT | mail | SPF for Porkbun email forwarding of krizaka.com |
| `_dmarc` | TXT | mail | DMARC policy of krizaka.com (reports only, p=none) |
| `_dmarc.mg` | TXT | mail | DMARC policy of mg.krizaka.com (reports only, p=none) [TTL 300, not managed] |
| `_dmarc.www` | TXT | mail | DMARC policy of www.krizaka.com (reports only, p=none) [TTL 300, not managed] |
| `email.mg` | CNAME | mail | Mailgun sending/tracking domain email.mg.krizaka.com [TTL 300, not managed] |
| `mailo._domainkey.mg` | TXT | mail | DKIM public key (Mailgun) for mg.krizaka.com [TTL 300, not managed] |
| `mg` | TXT | mail | SPF for Mailgun sending from mg.krizaka.com [TTL 300, not managed] |
| `pdk1._domainkey.www` | CNAME | mail | DKIM key (Mailgun) for www.krizaka.com [TTL 300, not managed] |
| `pdk2._domainkey.www` | CNAME | mail | DKIM key (Mailgun) for www.krizaka.com [TTL 300, not managed] |
| `@` | TXT | verification | Maven Central namespace verification (com.krizaka) |
| `@` | TXT | verification | Google Search Console ownership of krizaka.com |
| `_gh-krizaka-o` | TXT | verification | GitHub organization domain verification (krizaka) |
| `_acme-challenge` | TXT | acme | ACME DNS-01 challenge of krizaka.com (certificate issuance), kept as is |
| `_acme-challenge` | TXT | acme | ACME DNS-01 challenge of krizaka.com (certificate issuance), kept as is |
| `@` | NS | nameserver | Porkbun default nameserver of the zone |
| `@` | NS | nameserver | Porkbun default nameserver of the zone |
| `@` | NS | nameserver | Porkbun default nameserver of the zone |
| `@` | NS | nameserver | Porkbun default nameserver of the zone |

### orazaka.com (16)

| Name | Type | Kind | Purpose |
| :--- | :--- | :--- | :--- |
| `@` | ALIAS | app | orazaka.com serves the orazaka-dev app (App Platform) |
| `admin` | CNAME | app | admin.orazaka.com serves the orazaka-dev app (App Platform) |
| `broker-dev` | A | app | private address of orazaka-broker-dev (RabbitMQ) in the DigitalOcean VPC |
| `dev` | CNAME | app | dev.orazaka.com serves the orazaka-dev app (App Platform) |
| `www` | CNAME | app | www.orazaka.com serves the orazaka-dev app (App Platform) |
| `@` | MX | mail | Porkbun email forwarding for orazaka.com (MX, priority 10) |
| `@` | MX | mail | Porkbun email forwarding for orazaka.com (MX, priority 20) |
| `@` | TXT | mail | SPF for Porkbun email forwarding of orazaka.com |
| `_dmarc` | TXT | mail | DMARC policy of orazaka.com (reports only, p=none) |
| `@` | TXT | verification | Google Search Console ownership of orazaka.com |
| `_acme-challenge` | TXT | acme | ACME DNS-01 challenge of orazaka.com (certificate issuance), kept as is |
| `_acme-challenge` | TXT | acme | ACME DNS-01 challenge of orazaka.com (certificate issuance), kept as is |
| `@` | NS | nameserver | Porkbun default nameserver of the zone |
| `@` | NS | nameserver | Porkbun default nameserver of the zone |
| `@` | NS | nameserver | Porkbun default nameserver of the zone |
| `@` | NS | nameserver | Porkbun default nameserver of the zone |

### orochia.com (18)

| Name | Type | Kind | Purpose |
| :--- | :--- | :--- | :--- |
| `@` | ALIAS | app | orochia.com serves the orochia-dev app (App Platform) |
| `admin` | CNAME | app | admin.orochia.com serves the orochia-dev app (App Platform) |
| `dev` | CNAME | app | dev.orochia.com serves the orochia-dev app (App Platform) |
| `www` | CNAME | app | www.orochia.com serves the orochia-dev app (App Platform) |
| `@` | MX | mail | Porkbun email forwarding for orochia.com (MX, priority 10) |
| `@` | MX | mail | Porkbun email forwarding for orochia.com (MX, priority 20) |
| `@` | TXT | mail | SPF for Porkbun email forwarding of orochia.com |
| `_dmarc` | TXT | mail | DMARC policy of orochia.com (reports only, p=none) |
| `resend._domainkey.mg` | TXT | mail | DKIM public key (Resend) for mg.orochia.com |
| `rsend.mg` | CNAME | mail | Resend sending/tracking domain rsend.mg.orochia.com |
| `send.mg` | CNAME | mail | Resend sending/tracking domain send.mg.orochia.com |
| `@` | TXT | verification | Google Search Console ownership of orochia.com |
| `_acme-challenge` | TXT | acme | ACME DNS-01 challenge of orochia.com (certificate issuance), kept as is |
| `_acme-challenge` | TXT | acme | ACME DNS-01 challenge of orochia.com (certificate issuance), kept as is |
| `@` | NS | nameserver | Porkbun default nameserver of the zone |
| `@` | NS | nameserver | Porkbun default nameserver of the zone |
| `@` | NS | nameserver | Porkbun default nameserver of the zone |
| `@` | NS | nameserver | Porkbun default nameserver of the zone |

### yomizaka.com (15)

| Name | Type | Kind | Purpose |
| :--- | :--- | :--- | :--- |
| `@` | ALIAS | app | yomizaka.com serves the yomizaka-dev app (App Platform) |
| `admin` | CNAME | app | admin.yomizaka.com serves the yomizaka-dev app (App Platform) |
| `dev` | CNAME | app | dev.yomizaka.com serves the yomizaka-dev app (App Platform) |
| `www` | CNAME | app | www.yomizaka.com serves the yomizaka-dev app (App Platform) |
| `@` | MX | mail | Porkbun email forwarding for yomizaka.com (MX, priority 10) |
| `@` | MX | mail | Porkbun email forwarding for yomizaka.com (MX, priority 20) |
| `@` | TXT | mail | SPF for Porkbun email forwarding of yomizaka.com |
| `_dmarc` | TXT | mail | DMARC policy of yomizaka.com (reports only, p=none) |
| `@` | TXT | verification | Google Search Console ownership of yomizaka.com |
| `_acme-challenge` | TXT | acme | ACME DNS-01 challenge of yomizaka.com (certificate issuance), kept as is |
| `_acme-challenge` | TXT | acme | ACME DNS-01 challenge of yomizaka.com (certificate issuance), kept as is |
| `@` | NS | nameserver | Porkbun default nameserver of the zone |
| `@` | NS | nameserver | Porkbun default nameserver of the zone |
| `@` | NS | nameserver | Porkbun default nameserver of the zone |
| `@` | NS | nameserver | Porkbun default nameserver of the zone |

### akinaza.com (15)

| Name | Type | Kind | Purpose |
| :--- | :--- | :--- | :--- |
| `@` | ALIAS | app | akinaza.com serves the akinaza-dev app (App Platform) |
| `*` | CNAME | app | *.akinaza.com serves the akinaza-dev app (App Platform) |
| `admin` | CNAME | app | admin.akinaza.com serves the akinaza-dev app (App Platform) |
| `dev` | CNAME | app | dev.akinaza.com serves the akinaza-dev app (App Platform) |
| `www` | CNAME | app | www.akinaza.com serves the akinaza-dev app (App Platform) |
| `@` | MX | mail | Porkbun email forwarding for akinaza.com (MX, priority 10) |
| `@` | MX | mail | Porkbun email forwarding for akinaza.com (MX, priority 20) |
| `@` | TXT | mail | SPF for Porkbun email forwarding of akinaza.com |
| `_acme-challenge` | TXT | acme | ACME DNS-01 challenge of akinaza.com (certificate issuance), kept as is |
| `_acme-challenge` | TXT | acme | ACME DNS-01 challenge of akinaza.com (certificate issuance), kept as is |
| `_acme-challenge` | TXT | acme | ACME DNS-01 challenge of akinaza.com (certificate issuance), kept as is |
| `@` | NS | nameserver | Porkbun default nameserver of the zone |
| `@` | NS | nameserver | Porkbun default nameserver of the zone |
| `@` | NS | nameserver | Porkbun default nameserver of the zone |
| `@` | NS | nameserver | Porkbun default nameserver of the zone |

### yororis.com (15)

| Name | Type | Kind | Purpose |
| :--- | :--- | :--- | :--- |
| `@` | ALIAS | app | yororis.com serves the yororis-qa app (App Platform) |
| `dev` | CNAME | app | dev.yororis.com serves the yororis-qa app (App Platform) |
| `qa` | CNAME | app | qa.yororis.com serves the yororis-qa app (App Platform) |
| `www` | CNAME | app | www.yororis.com serves the yororis-qa app (App Platform) |
| `@` | MX | mail | Porkbun email forwarding for yororis.com (MX, priority 10) |
| `@` | MX | mail | Porkbun email forwarding for yororis.com (MX, priority 20) |
| `@` | TXT | mail | SPF for Porkbun email forwarding of yororis.com |
| `_dmarc` | TXT | mail | DMARC policy of yororis.com (reports only, p=none) |
| `@` | TXT | verification | Google Search Console ownership of yororis.com |
| `_acme-challenge` | TXT | acme | ACME DNS-01 challenge of yororis.com (certificate issuance), kept as is |
| `_acme-challenge` | TXT | acme | ACME DNS-01 challenge of yororis.com (certificate issuance), kept as is |
| `@` | NS | nameserver | Porkbun default nameserver of the zone |
| `@` | NS | nameserver | Porkbun default nameserver of the zone |
| `@` | NS | nameserver | Porkbun default nameserver of the zone |
| `@` | NS | nameserver | Porkbun default nameserver of the zone |

### yasakia.com (15)

| Name | Type | Kind | Purpose |
| :--- | :--- | :--- | :--- |
| `@` | ALIAS | app | yasakia.com serves the yasakia-dev app (App Platform) |
| `admin` | CNAME | app | admin.yasakia.com serves the yasakia-dev app (App Platform) |
| `dev` | CNAME | app | dev.yasakia.com serves the yasakia-dev app (App Platform) |
| `www` | CNAME | app | www.yasakia.com serves the yasakia-dev app (App Platform) |
| `@` | MX | mail | Porkbun email forwarding for yasakia.com (MX, priority 10) |
| `@` | MX | mail | Porkbun email forwarding for yasakia.com (MX, priority 20) |
| `@` | TXT | mail | SPF for Porkbun email forwarding of yasakia.com |
| `_dmarc` | TXT | mail | DMARC policy of yasakia.com (reports only, p=none) |
| `@` | TXT | verification | Google Search Console ownership of yasakia.com |
| `_acme-challenge` | TXT | acme | ACME DNS-01 challenge of yasakia.com (certificate issuance), kept as is |
| `_acme-challenge` | TXT | acme | ACME DNS-01 challenge of yasakia.com (certificate issuance), kept as is |
| `@` | NS | nameserver | Porkbun default nameserver of the zone |
| `@` | NS | nameserver | Porkbun default nameserver of the zone |
| `@` | NS | nameserver | Porkbun default nameserver of the zone |
| `@` | NS | nameserver | Porkbun default nameserver of the zone |

### kachizaka.com (13)

| Name | Type | Kind | Purpose |
| :--- | :--- | :--- | :--- |
| `@` | ALIAS | app | kachizaka.com serves the kachizaka-dev app (App Platform) |
| `admin` | CNAME | app | admin.kachizaka.com serves the kachizaka-dev app (App Platform) |
| `dev` | CNAME | app | dev.kachizaka.com serves the kachizaka-dev app (App Platform) |
| `www` | CNAME | app | www.kachizaka.com serves the kachizaka-dev app (App Platform) |
| `@` | MX | mail | Porkbun email forwarding for kachizaka.com (MX, priority 10) |
| `@` | MX | mail | Porkbun email forwarding for kachizaka.com (MX, priority 20) |
| `@` | TXT | mail | SPF for Porkbun email forwarding of kachizaka.com |
| `_acme-challenge` | TXT | acme | ACME DNS-01 challenge of kachizaka.com (certificate issuance), kept as is |
| `_acme-challenge` | TXT | acme | ACME DNS-01 challenge of kachizaka.com (certificate issuance), kept as is |
| `@` | NS | nameserver | Porkbun default nameserver of the zone |
| `@` | NS | nameserver | Porkbun default nameserver of the zone |
| `@` | NS | nameserver | Porkbun default nameserver of the zone |
| `@` | NS | nameserver | Porkbun default nameserver of the zone |
