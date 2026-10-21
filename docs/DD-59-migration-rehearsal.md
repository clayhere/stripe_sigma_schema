# DD-59: Classic-to-Google migration rehearsal

Roadmap: https://sones.atlassian.net/browse/DD-59, parent DD-33. Scope,
acceptance criteria, dependencies and rollout saved and verified before claim.
Clay authorized this one-time exception to Instinct Jira ownership.

Owner: Ada (Codex). No open PRs at claim check. Work starts from origin/main
b12ffbc in a separate managed worktree. Claimed files: classic backup UI in
src/js/11-food-log.js, shared migration validation/reconciliation under
packages/core, modern import preview/client, migration rehearsal tools/docs/tests.

Deliver complete token-free exports, explicit conflict reconciliation, idempotent
import, read-back comparisons, and retained source/target backups. Rehearse with
synthetic fixtures and a private copy of real account data. No personal data or
credentials in commits/logs/PRs. No production hosting/DNS cutover, paid services,
or source deletion. DD-50 remains separate. Merge requires Clay approval.
