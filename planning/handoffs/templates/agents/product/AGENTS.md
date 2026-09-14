# AGENTS.md — Product Repository

> Generated initially by the `governed-exploratory-development` plugin version `{{PLUGIN_VERSION}}` on `{{GENERATED_AT}}`. This repository owns this file after generation; do not expect automatic synchronization.

## Repository role

This repository contains the releasable Product implementation and its production history, compatibility obligations, tests, and delivery mechanics.

## Governance dependency

Authoritative project Governance is pinned as a read-only Git submodule at `{{GOVERNANCE_SUBMODULE_PATH}}`.

Apply this precedence:

1. Constitution
2. Policies
3. Specifications
4. Active ADRs

Existing Product implementation and local conventions may provide evidence; they are not an authority level.

Conformance Proofs are derived evidence. Discovery Reports, Discovery Comparisons, and proposal records are non-normative.

## Existing code

Existing code is important implementation evidence, not project law. Preserve established patterns when compatible with current Governance. Do not infer that a repeated pattern automatically represents current architectural intent. Surface suspected architectural sediment or Governance conflicts rather than silently extending them.

## Submodule rules

- Treat `{{GOVERNANCE_SUBMODULE_PATH}}` as read-only from Product work.
- Never edit Governance through the submodule checkout.
- Never advance the pointer automatically.
- Use the Governance adoption review before updating it.
- The pinned commit means Product believes it conforms to that Governance revision.

## Discovery Code Promotion

Do not copy Discovery Repo code automatically. Use the explicit Transplant / Adapt / Reimplement review and record the developer’s decision.

## Validation before completion

- Identify applicable Governance.
- Check whether current patterns reflect intent or sediment.
- Run relevant tests and conformance checks.
- Document known incompatibilities.
- Show the working-tree diff; leave committing to the developer.
