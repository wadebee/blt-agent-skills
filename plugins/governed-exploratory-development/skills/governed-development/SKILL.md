---
name: governed-development
description: Set up or operate a project that separates Governance, Product, and isolated Discovery Repos. Use when the user wants to create, continue, close, compare, promote, or adopt governed exploratory software work without needing to know the lifecycle workflow names.
---

# Governed Development skill

Use this one context-aware router for governed exploratory work. Infer the
requested lifecycle operation from the user's intent and repository context;
do not present internal workflow names as a menu.

## Routing

- Create a new Governance/Product pair → `references/workflows/project-setup.md`
- Connect an existing pair → `references/workflows/project-activation.md`
- Start a Discovery Repo → `references/workflows/discovery-repo-create.md`
- Continue under a changed Governance context → `references/workflows/discovery-repo-successor.md`
- Review or retain a Discovery Repo → `references/workflows/discovery-review.md`
- Compare Discovery Repos → `references/workflows/discovery-compare.md`
- Propose a Governance change → `references/workflows/discovery-governance-promote.md`
- Resolve a Governance Proposal → `references/workflows/governance-resolve.md`
- Move Discovery design or code into Product → `references/workflows/discovery-code-promote.md`
- Review Product Governance Adoption → `references/workflows/governance-adopt.md`

At the Chunk 1 gate these lifecycle handlers are reference-only and explicitly
unavailable. The router must say so rather than claim support or execute them.
Chunk 1 provides packaging and shared metadata validation; it does not create
repositories or run Shimmy bootstrap.

## Invariants

- Ask for one outstanding developer decision at a time and keep recommendations
  separate from explicit choices.
- Keep Governance, Product, and each Discovery Repo as separate repositories.
- Product and Discovery consume independent, exact Governance submodule pins.
- Read `.governed/governance.yaml` and `.governed/reading-scope.yaml` before
  permitted Governance bodies. Curated exclusions apply across tools and agents.
- Discovery creation stages only its submodule relationship and never commits;
  only initial Project Setup may create its approved Governance/Product commits.
- Never overwrite repository-owned `AGENTS.md`, publish, push, or invent a
  Shimmy bootstrap command.
- Show staged and unstaged changes and validation limitations before completion.

See `references/runtime-contract.md` for the shared operational boundary.
