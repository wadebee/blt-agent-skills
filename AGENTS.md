# Marketplace repository instructions

## Scope and repository work

This repository contains independent plugins and skills. These instructions
govern work on the marketplace repository; each capability's instructions and
workflow contracts define its behavior in the projects it operates on.

- Read the plan and instructions applicable to the capability being changed.
  Follow that task's approved scope and review gates; milestone requirements
  belong to the applicable plan.
- Keep unrelated capabilities in coherent, independently installable plugins.
- Report unresolved conflicts rather than inventing a resolution.
- Validate plugin and skill packaging against current official OpenAI
  requirements before relying on reference manifests.
- Run checks appropriate to the changed files and behavior, and report the
  commands and results at the task's review checkpoints.

## CLI tools and installation

- Existing native tools and activated Shimmy shims are both eligible for use.
  Verify needed tools resolve with `command -v` before using them. This applies to
  implementation, investigation, validation, tests, and troubleshooting.
- Agents must not download, install, build, or bootstrap tools. This includes
  standalone binaries, archives, package-manager installs, and temporary copies
  under `/tmp`, the workspace, or user-local directories. Temporary acquisition
  counts as installation for this rule even without a PATH change.
- Approval to implement a plan, selection of a dependency, or a tool execution
  permission does not authorize tool acquisition or installation.
- If a required tool is absent or unusable, report the exact tool and blocker
  and let the user provision or repair it. Continue work supported by available
  native tools or activated shims. Do not acquire temporary tools or use ad hoc
  container commands to work around a missing tool.
- Carry these requirements into implemented skills and their helper/test
  instructions. Existing plan acquisition guidance is superseded by this rule;
  dependency documentation must describe required tool capabilities and available
  native/Shimmy implementations, not agent-run installers.

## Git permissions

- Creating commits, pushing, configuring remotes, or publishing this
  marketplace repository requires explicit user authorization for that task.
- Define each skill's Git permissions in its own instructions and workflow
  contracts. Do not apply one skill's restrictions to unrelated skills.
- Tests may initialize repositories, stage files, create commits, and establish
  local submodule relationships inside test-owned temporary directories.
  Keep fixture setup separate from the workflow under test, and verify that
  the workflow respects its own Git permissions. Tests must not modify real
  project repositories or global Git configuration, push, or create hosted
  repositories.

## Reference material and terminology

`planning/handoffs/` contains the governed exploratory development and Shimmy
onboarding specification and reference packages. It is not the implementation
specification for unrelated future capabilities.

Treat that directory as read-only outside explicitly authorized documentation
maintenance, including the user-authorized terminology alignment. Implement
production files elsewhere; do not modify source references merely to make
implementation or tests pass. Reference plugin files and role-specific
`AGENTS.md` templates describe deliverables, not marketplace-wide instructions.

Use `GLOSSARY.md` as the authoritative source for the terms it defines wherever
they occur in this repository. Its domain relationships govern capabilities
using those concepts; they do not prescribe an architecture for unrelated skills.

## Work covered by the current handoff

For governed exploratory development or the Shimmy onboarding deliverables in
this handoff, read these documents in order before implementation:

1. `planning/handoffs/codex/IMPLEMENTATION-BRIEF.md`
2. `planning/handoffs/docs/01-architecture.md`
3. `planning/handoffs/decisions/DECISIONS.md`
4. `planning/handoffs/docs/05-plugin-architecture.md`
5. `planning/handoffs/codex/IMPLEMENTATION-PHASES.md`
6. `planning/handoffs/codex/ACCEPTANCE-TEST-MATRIX.md`

Follow relevant references as needed, and read the authoritative
[implementation plan](planning/wip/governed-exploratory-development.md)
for approved clarifications, unresolved decisions, and execution gates.
Update this link when the plan changes lifecycle location.

The plan owns this capability's milestone sequence, single public router,
Governance/Product/Discovery Repo boundaries, and approved initial project Git
behavior. Its Shimmy onboarding scope delegates to Product-owned bootstrap
logic. Carry these contracts into the corresponding skill instructions during
authorized implementation. They are not restrictions on unrelated plugins.
