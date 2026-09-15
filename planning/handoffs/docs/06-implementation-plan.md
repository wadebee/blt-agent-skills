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
- only approved initial Governance/Product creation may commit; no network publication occurs.

## Phase 1 — Project Setup, Project Activation and Local Project Configuration

Implement:

- Project Setup creating the initial Governance/Product pair and pinning Product to Governance's first commit;
- Project Activation connecting an existing pair on this workstation;
- project-role detection suggestions;
- one-time interview for Product/Governance paths, project name, and submodule path;
- validation of newly created repositories for Setup and existing repositories for Activation;
- validation of the created relationship during Setup; Activation preserves existing Git state and diagnoses discrepancies without automatic repair;
- generation of Governance and Product `AGENTS.md` files;
- Local Project Configuration.

Exit criteria:

- interrupted Project Setup resumes without duplicate initialization; repeated Project Activation reuses valid configuration without recreating repositories;
- existing `AGENTS.md` is never overwritten silently;
- a second machine can complete Project Activation independently.

## Phase 2 — Discovery Repo creation

Implement:

- sequential ID allocation with collision detection;
- creation interview for Governance revision and reading scope, type, framing, Product access, charter, and optional comparison;
- Full and Curated Governance Reading Scope;
- decision-by-decision Curated reading record with agent exclusions;
- local Git repo initialization;
- generated `AGENTS.md`, `DISCOVERY.yaml`, and `GOVERNANCE-READING-SCOPE.yaml`;
- pinned `.governance/` submodule and `.gitmodules`, with only the submodule relationship staged;
- validation that no prohibited Product content enters agent context, including through Governance artifacts and history.

Exit criteria:

- the created repo matches the minimal scaffold;
- all templates validate against schemas;
- Git, the manifest, and the reading record agree on source/commit; the generated records agree on workflow version;
- excluded Governance bodies remain unread despite local availability;
- Discovery initialization leaves no commit and stages only its submodule relationship.

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
- optional handoff to governed-development Project Activation for contributors.

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
