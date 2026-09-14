# AGENTS.md — Governance Repository

> Generated initially by the `governed-exploratory-development` plugin version `{{PLUGIN_VERSION}}` on `{{GENERATED_AT}}`. This repository owns this file after generation; do not expect automatic synchronization.

## Repository role

This repository stores the project’s Governance Corpus and durable institutional evidence. It does not contain the releasable Product implementation.

## Authority

Apply this precedence:

1. Constitution
2. Policies
3. Specifications
4. Active ADRs

Same-level artifacts may explicitly supersede predecessors. Surface unresolved conflicts; do not invent precedence.

Conformance is derived evidence. Discovery records, synthesis records, and proposals are non-normative. Presence in this repository does not alone confer authority.

## Working rules

- Preserve stable artifact IDs.
- Use only minimal metadata: ID, title, and supersession where applicable.
- Do not treat `discoveries/` or `proposals/` as project requirements.
- Governance changes require human review and approval.
- Accepted proposals and normative edits are separate changes.
- Every accepted proposal requires a Product impact assessment.
- Preserve rejected proposals in `proposals/resolved/` as negative knowledge.
- Do not edit Product code from this repository.
- Do not create Git commits automatically.

## Proposal workflow

Pending proposals live in `proposals/pending/`. After a human decision, move them to `proposals/resolved/` and add minimal resolution metadata. Acceptance requires separate edits to the target normative artifact.

## Discovery evidence

Durable `DISC-*` and `SYNTH-*` records live under `discoveries/`. They may support a proposal but never become normative merely by existing.

## Validation before completion

- Check authority and supersession consistency.
- Verify IDs are unique.
- Verify normative edits have traceable rationale.
- Verify proposal resolution and Product impact are captured when applicable.
- Show the working-tree diff; leave committing to the developer.
