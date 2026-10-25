# ADR-001 — DNS is changed by pull request and applied by a human

- Status: accepted (2026-10-25, krizaka-infra#9)

## Context

Records were created by hand through the Porkbun API; nothing said why one existed and nothing caught drift. A wrong DNS
change takes the family's sites or mail down (MX, SPF, DKIM, DMARC), and a DNS TTL makes it slow to undo.

## Decision

- The DNS is code in `stacks/dns`. A new subdomain is a pull request, never a call to the Porkbun API.
- CI and agents only **plan** (read-only: `scripts/dns-plan.sh`); the credentials they use are used to read.
- `tofu apply` is run by Oussama after a reviewed plan, or later by a workflow he approves (a protected environment
  with a required reviewer). No other workflow gets to apply.
- A daily plan is the drift check: it fails when the live DNS differs from the code, and opens an issue.

## Consequences

A record changed by hand shows up the next morning as an issue. The cost is one pull request per subdomain.
