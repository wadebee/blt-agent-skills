---
name: governed-development
description: Set up or operate a project that separates Governance, Product, and isolated Discovery Implementation repositories. Use when the user wants to create, continue, close, compare, promote, or adopt governed exploratory software work without needing to know the lifecycle workflow names.
---

# Governed Development skill

## Objective

Expose one simple, context-aware entry point. Infer the user’s intended lifecycle operation from their request and repository context. Do not ask the user to choose among internal workflow names.

## Routing

Load the matching workflow reference:

- No Local Project Configuration or explicit setup request → `references/workflows/project-setup.md`
- Start a new Discovery Implementation or alternate implementation → `references/workflows/discovery-implementation-create.md`
- Continue a Discovery Implementation under changed Governance → `references/workflows/discovery-implementation-successor.md`
- Finish, archive, or preserve a Discovery Implementation → `references/workflows/discovery-review.md`
- Compare multiple Discovery Implementations → `references/workflows/discovery-compare.md`
- Turn Conformance Proofs into a Governance change → `references/workflows/discovery-governance-promote.md`
- Accept, modify, or reject a Governance proposal → `references/workflows/governance-resolve.md`
- Move Discovery Implementation code/design into Product → `references/workflows/discovery-code-promote.md`
- Advance Product’s pinned Governance revision → `references/workflows/governance-adopt.md`

If multiple routes are plausible, explain the inferred outcome in plain language and ask one concise clarification. Otherwise proceed directly with the relevant interview.

## Global invariants

- Make recommendations, but require explicit developer choices where the design specifies them.
- Conduct interviews one decision at a time.
- Discovery Disposition records independent Discovery Code Promotion, Discovery Governance Promotion, and repository retention choices; Keep Active preserves active status.
- Never treat Discovery Reports, Discovery Comparisons, or proposals as normative.
- Never modify an immutable Governance Snapshot.
- Never create Git commits.
- Never publish, archive, or delete remote repositories.
- Never overwrite an existing `AGENTS.md` without explicit instruction and review.
- Show file changes and validation results before completion.
- Use current Local Project Configuration from plugin-local writable data; do not commit workstation paths.
