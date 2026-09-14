# Codex Implementation Brief

## Mission

Implement the `Beeline-Technologies` Agent Plugin marketplace described by this package. The first production milestone must support one end-to-end path:

1. onboard a Product/Governance repo pair;
2. invoke the single `governed-development` public skill;
3. create a valid local Discovery repo through the full interview;
4. generate immutable Governance provenance; and
5. validate the result without committing or publishing anything.

## Source-of-truth order

1. `decisions/DECISIONS.md`
2. architecture and governance docs
3. workflow specs
4. templates and schemas
5. reference skeletons

If two package files appear inconsistent, preserve the settled decisions and report the conflict rather than inventing a resolution.

## Required implementation characteristics

- Portable root `plugin.json` packages.
- One public governed-development skill.
- Internal workflows as supporting references/modules, not a menu exposed to users.
- Interview engine that presents one decision at a time.
- Context-sensitive recommendations with explicit developer choice.
- Filesystem operations that are idempotent, reviewable, and safe around existing data.
- No automatic commits or remote-hosting operations.
- Schema validation and deterministic templates.
- Unit tests for pure decision/validation logic and integration tests in temporary Git repos.

## Do not do

- Do not embed Shimmy bootstrap logic in the plugin.
- Do not make Governance and Product one repo.
- Do not replace Discovery repos with branches or worktrees.
- Do not automatically update old `AGENTS.md` files.
- Do not treat tests, discoveries, syntheses, or proposals as normative.
- Do not create a hard-sandbox claim without actual technical isolation.
- Do not add a rich governance lifecycle database.

## First pull request

The recommended first PR contains:

- marketplace and plugin manifests;
- public router `SKILL.md`;
- local registration model and schema;
- role `AGENTS.md` assets;
- Discovery and snapshot schemas/templates;
- temporary-repo test harness;
- no Git-hosting adapter.
