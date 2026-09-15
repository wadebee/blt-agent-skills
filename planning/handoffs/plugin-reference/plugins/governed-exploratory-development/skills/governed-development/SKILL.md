---
name: governed-development
description: Set up or operate a project that separates Governance, Product, and isolated Discovery Repos. Use when the user wants to create, continue, close, compare, promote, or adopt governed exploratory software work without needing to know the lifecycle workflow names.
---

# Governed Development skill

## Objective

Expose one simple, context-aware entry point. Infer the user’s intended lifecycle operation from their request and repository context. Do not ask the user to choose among internal workflow names.

## Routing

Load the matching workflow reference:

- Create a new Governance/Product pair → `references/workflows/project-setup.md`
- Connect an existing pair, including first use on another workstation → `references/workflows/project-activation.md`
- Missing Local Project Configuration alone does not imply new-project creation; infer existing-pair Activation or clarify intent.
- Start a new Discovery Repo or alternate implementation → `references/workflows/discovery-repo-create.md`
- Continue a Discovery Repo under changed Governance → `references/workflows/discovery-repo-successor.md`
- Finish, archive, or preserve a Discovery Repo → `references/workflows/discovery-review.md`
- Compare multiple Discovery Repos → `references/workflows/discovery-compare.md`
- Turn Conformance Proofs into a Governance change → `references/workflows/discovery-governance-promote.md`
- Accept, modify, or reject a Governance proposal → `references/workflows/governance-resolve.md`
- Move Discovery Repo code/design into Product → `references/workflows/discovery-code-promote.md`
- Advance Product’s pinned Governance revision → `references/workflows/governance-adopt.md`

If multiple routes are plausible, explain the inferred outcome in plain language and ask one concise clarification. Otherwise proceed directly with the relevant interview.

## Global invariants

- Make recommendations, but require explicit developer choices where the design specifies them.
- Conduct interviews one decision at a time.
- Discovery Disposition records independent Discovery Code Promotion, Discovery Governance Promotion, and repository retention choices; Keep Active preserves active status.
- Never treat Discovery Reports, Discovery Comparisons, or proposals as normative.
- Product and Discovery use read-only Governance submodules; never advance a Discovery pin in place.
- Read the Discovery manifest and Governance Reading Scope record before Governance bodies. Enforce Curated exclusions across tools, searches, summaries, nested instructions, and delegated work; a complete checkout grants no extra reading permission.
- Apply Decision 30’s capability Git contract: approved initial Governance/Product creation may commit; Discovery creation stages only its submodule relationship and never commits; later workflows do neither.
- Never publish, archive, or delete remote repositories.
- Never overwrite an existing `AGENTS.md` without explicit instruction and review.
- Show file changes and validation results before completion.
- Use current Local Project Configuration from plugin-local writable data; do not commit workstation paths.
