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

## Phase 1 — Project Setup and Local Project Configuration

Implement:

- project-role detection suggestions;
- one-time interview for Product/Governance paths, project name, and submodule path;
- validation that each path is a Git repo;
- validation that Product has the expected Governance submodule or a clear remediation plan;
- generation of Governance and Product `AGENTS.md` files;
- Local Project Configuration.

Exit criteria:

- Project Setup is repeatable and idempotent;
- existing `AGENTS.md` is never overwritten silently;
- a second machine can complete Project Setup independently.

## Phase 2 — Discovery Repo creation

Implement:

- sequential ID allocation with collision detection;
- creation interview for artifacts selection, type, framing, Product access, charter, and optional comparison;
- full and curated Governance selection;
- decision-by-decision curated selection record;
- local Git repo initialization;
- generated `AGENTS.md`, `DISCOVERY.yaml`, and immutable `.governance/` snapshot;
- validation that no Product implementation files leaked into Isolated or Contract-aware repos.

Exit criteria:

- the created repo matches the minimal scaffold;
- all templates validate against schemas;
- the snapshot records exact Governance commit and workflow version.

## Phase 3 — Successor, Discovery Review, and Discovery Comparison

Implement:

- successor creation from an existing Discovery Repo without mutating it;
- durable Discovery Report generation and review;
- independent Discovery Disposition recommendations and explicit choices;
- lookup of related Discovery Repos;
- optional Discovery Comparison workflow and `CMPR-*` record.

Exit criteria:

- Discovery Review always surfaces a record before Discovery Disposition;
- Report + Delete never removes a remote repo;
- Discovery Comparisons remain non-normative.

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

- bootstrap entrypoint identification contract;
- prerequisite and side-effect review;
- invocation wrapper that delegates to Product bootstrap;
- post-install validation;
- optional handoff to governed-development Project Setup for contributors.

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

Prefer thin vertical slices over implementing all parsers first. The first useful milestone should complete Project Setup and create one valid Discovery Repo end to end.
