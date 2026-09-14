# Agent Skills implementation instructions

## Governing implementation handoff

The implementation specification is located at:

`planning/handoffs/`

Use `GLOSSARY.md` as the authoritative terminology source. The user-authorized
terminology alignment applies throughout this repository, including the handoff.
Outside such explicitly authorized documentation maintenance, treat that directory
as read-only source material. Implement production files elsewhere in this repository. Do not modify the handoff merely to
make implementation or tests pass.

## Required reading order

Before implementing this capability, read:

1. `planning/handoffs/codex/IMPLEMENTATION-BRIEF.md`
2. `planning/handoffs/docs/01-architecture.md`
3. `planning/handoffs/decisions/DECISIONS.md`
4. `planning/handoffs/docs/05-plugin-architecture.md`
5. `planning/handoffs/codex/IMPLEMENTATION-PHASES.md`
6. `planning/handoffs/codex/ACCEPTANCE-TEST-MATRIX.md`

Follow references from those documents as needed.

Report unresolved conflicts rather than inventing a resolution.

## Implementation boundaries

- Implement one approved milestone at a time.
- Begin with the end-to-end Project Setup and Discovery Repo creation path.
- Keep the public experience behind one context-aware router skill.
- Do not expose internal lifecycle modules as a user-facing menu.
- Do not combine Governance, Product, and Discovery Repo into one repository.
- Do not replace Discovery Repos with branches or worktrees.
- Do not create Git commits, pushes, remotes, or hosted repositories.
- Do not reproduce Shimmy bootstrap logic in this repository.
- The Shimmy onboarding skill must invoke Product-owned bootstrap logic.
- Validate plugin and skill packaging against current official OpenAI
  requirements before relying on the reference manifests.
- Run appropriate tests and report commands and results after each phase.
