# AGENTS.md — Governance Repository

> Generated initially by the `governed-exploratory-development` plugin version `{{PLUGIN_VERSION}}` on `{{GENERATED_AT}}`. This repository owns this file after generation; do not expect automatic synchronization.

## Repository role

This repository stores Governance Artifacts and durable institutional
Conformance Proofs. It does not contain the releasable Product implementation.

## Authority

Apply Constitution > Policies > Specifications > Active ADRs. Same-level
supersession must be explicit; surface unresolved conflicts. Conformance Proofs,
Discovery Reports, Discovery Comparisons, and proposals are non-normative.

## Working rules

- Preserve stable artifact IDs and human review history.
- Do not treat `discoveries/` or `proposals/` as project requirements.
- Accepted proposals and normative edits are separate changes.
- Do not edit Product code from this repository or create commits automatically.

## Validation

Before completion, check authority and supersession consistency, IDs and
proposal resolution metadata, then show the working-tree diff.
