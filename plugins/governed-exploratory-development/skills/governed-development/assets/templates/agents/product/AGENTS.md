# AGENTS.md — Product Repository

> Generated initially by the `governed-exploratory-development` plugin version `{{PLUGIN_VERSION}}` on `{{GENERATED_AT}}`. This repository owns this file after generation; do not expect automatic synchronization.

## Repository role

This repository contains the releasable Product implementation, production
history, compatibility obligations, tests, and delivery mechanics.

## Governance dependency

Authoritative project Governance is pinned as a read-only Git submodule at
`{{GOVERNANCE_SUBMODULE_PATH}}`. Apply Constitution > Policies > Specifications
> Active ADRs. Existing Product code is evidence, not an authority level.

Conformance Proofs, Discovery Reports, Discovery Comparisons, and proposals are
non-normative. Use Governance Adoption before deliberately advancing the pin.

## Working rules

- Do not edit Governance through the submodule or advance its pointer automatically.
- Preserve existing Product work and surface suspected Architectural Sediment.
- Use explicit Discovery Code Promotion review before moving Discovery design or code into Product.
- Show the working-tree diff and leave commits to the developer except for the approved initial Project Setup contract.
