# krizaka-infra — agent instructions

Infrastructure as code for the Krizaka family, **OpenTofu** (the open-source Terraform). Read `docs/PLAN.md` first: it is
the brief, the inventory and the order of work.

## Hard rules

1. **Never apply.** Agents write code, `tofu fmt`, `tofu validate`, tests; a `tofu apply` against real infrastructure is a
   human step (Oussama), after a reviewed plan.
2. **No secret in git** — no token, password, key, connection string, certificate. Variables are declared with
   `sensitive = true` and come from the environment (`TF_VAR_*`); document their names in `docs/SECRETS.md` only.
3. **Import before change.** A stack describes what runs today; its first `tofu plan` against the live account must be a
   no-op. Never write a resource that would recreate a running one.
4. **No new paid resource.** Anything that adds cost is proposed in an issue for Oussama, never written as code first.
5. **Portable modules.** `modules/<role>` holds the provider-neutral interface; `providers/<provider>/<role>` the adapter.
   A stack uses roles, not provider resources directly.
6. **Names follow the org rule** (`<owner>-<role>`, krizaka/.github docs/standards/repositories.md); resources keep their
   current live names (renaming recreates).
7. **Pinned versions:** OpenTofu, providers and modules pinned exactly; a lock file committed.

## Definition of done

- `tofu fmt -check`, `tofu validate`, `tflint` green in CI (`.github/workflows/ci.yml`), no credentials needed.
- Every module has a README (inputs, outputs, an example) and a test (`tofu test` with mocked providers).
- `docs/PLAN.md` progress ticked; the README's status updated.
- Small PRs: one role or one stack each, squash-merged.
