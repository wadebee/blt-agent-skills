# Implementation Plan

## Phase 0 — Repository and package skeleton

Deliver:

- `Beeline-Technologies` marketplace layout;
- portable root `plugin.json` for both plugins;
- marketplace catalog;
- public router skill skeleton;
- schema and template directories;
- test harness capable of running in a temporary filesystem.

Exit criteria:

- manifests parse;
- skills are discoverable by current OpenAI tooling;
- no workflow performs Git commits or network publication.

## Phase 1 — Project onboarding and local registration

Implement:

- project-role detection suggestions;
- one-time interview for Product/Governance paths, project name, and submodule path;
- validation that each path is a Git repo;
- validation that Product has the expected Governance submodule or a clear remediation plan;
- generation of Governance and Product `AGENTS.md` files;
- user-local project registration.

Exit criteria:

- onboarding is repeatable and idempotent;
- existing `AGENTS.md` is never overwritten silently;
- a second machine can onboard independently.

## Phase 2 — Discovery creation

Implement:

- sequential ID allocation with collision detection;
- creation interview for context mode, type, framing, Product access, charter, and optional comparison;
- full and curated Governance selection;
- decision-by-decision curated selection record;
- local Git repo initialization;
- generated `AGENTS.md`, `DISCOVERY.yaml`, and immutable `.governance/` snapshot;
- validation that no Product implementation files leaked into Isolated or Contract-aware repos.

Exit criteria:

- the created repo matches the minimal scaffold;
- all templates validate against schemas;
- the snapshot records exact Governance commit and workflow version.

## Phase 3 — Successor, closeout, and synthesis

Implement:

- successor creation from an existing Discovery without mutating it;
- durable Discovery Record generation and review;
- disposition recommendation and explicit choice;
- related-experiment detection;
- optional synthesis workflow and `SYNTH-*` record.

Exit criteria:

- closeout always surfaces a record before disposition;
- Record + Delete never removes a remote repo;
- synthesis records remain non-normative.

## Phase 4 — Governance proposals and Product promotion

Implement:

- structured proposal generation;
- pending/resolved filesystem lifecycle;
- mandatory human acceptance/modification/rejection;
- Product impact assessment;
- Transplant/Adapt/Reimplement review;
- conformance-ready Governance adoption review;
- Product submodule update without commit.

Exit criteria:

- no workflow can silently create normative Governance;
- proposal acceptance and normative edits are separate working-tree changes;
- Product’s submodule is not advanced without an explicit review.

## Phase 5 — Shimmy onboarding plugin

Implement only after inspecting authoritative Shimmy Product sources.

Deliver:

- bootstrap entrypoint discovery contract;
- prerequisite and side-effect review;
- invocation wrapper that delegates to Product bootstrap;
- post-install validation;
- optional handoff to governed-development onboarding for contributors.

Exit criteria:

- no bootstrap logic is duplicated in the plugin;
- missing or ambiguous Product bootstrap contracts fail clearly.

## Phase 6 — Hardening

Add:

- filesystem locking for ID allocation;
- robust dirty-working-tree handling;
- path traversal and symlink defenses;
- schema version migration policy;
- failure recovery and partial-operation cleanup;
- representative positive and negative tests;
- documentation for installing the Beeline marketplace.

## Delivery strategy

Prefer thin vertical slices over implementing all parsers first. The first useful milestone should onboard a project and create one valid Discovery repo end to end.
