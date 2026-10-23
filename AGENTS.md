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

## Before you open or update a pull request (coding agents)

These are the defects code review found most often on 2026-10-23. Check them yourself before you open or update a pull request:
1. **Checks:** run the repository's full check (lint, typecheck, tests, build) and fix it. Never push a red check.
2. **Concurrency:** any « count then insert » or « check then write » runs in one transaction with a lock, and has a concurrency test.
3. **One gate:** a rule (limit, permission, validation) is enforced in the service, so no route can skip it. Test every route.
4. **Errors:** a cleanup (ROLLBACK, DROP, close) never masks the original error. Rethrow it, or throw an `AggregateError` with the original first.
5. **Validation:** validate the original input, never a truncated or pre-trimmed copy. Server and client reject the same inputs.
6. **Accessibility:**
   - every control has a unique label, and FR/EN pairs say their language;
   - focus rings are never clipped by `overflow`;
   - text never overflows its box at 360 px.
7. **Naming:** environment variables follow `<CONTEXT>_<THING>` (`APP_`, `DATABASE_`, `AUTH_`, `MEDIA_`, `MAIL_`, `PAYMENTS_`, `AI_`…) and are declared once.
8. **Words:** every user-facing string is in the FR and EN messages, and no colour is hard-coded.
9. **Review threads:** answer every one. Fix it test-first, or reply with the reason, then resolve it.
