---
name: governed-development
description: Onboard or operate a project that separates Governance, Product, and isolated Discovery repositories. Use when the user wants to create, continue, close, compare, promote, or adopt governed exploratory software work without needing to know the lifecycle workflow names.
---

# Governed Development Router

## Objective

Expose one simple, context-aware entry point. Infer the user’s intended lifecycle operation from their request and repository context. Do not ask the user to choose among internal workflow names.

## Routing

Load the matching workflow reference:

- No local project registration or explicit setup request → `references/workflows/project-onboard.md`
- Start a new experiment or alternate implementation → `references/workflows/discovery-create.md`
- Continue an experiment under changed Governance → `references/workflows/discovery-successor.md`
- Finish, archive, or preserve an experiment → `references/workflows/discovery-closeout.md`
- Compare multiple Discoveries → `references/workflows/discovery-synthesize.md`
- Turn evidence into a Governance change → `references/workflows/governance-propose.md`
- Accept, modify, or reject a Governance proposal → `references/workflows/governance-resolve.md`
- Move Discovery code/design into Product → `references/workflows/product-promote.md`
- Advance Product’s pinned Governance revision → `references/workflows/governance-adopt.md`

If multiple routes are plausible, explain the inferred outcome in plain language and ask one concise clarification. Otherwise proceed directly with the relevant interview.

## Global invariants

- Make recommendations, but require explicit developer choices where the design specifies them.
- Conduct interviews one decision at a time.
- Never treat Discovery or proposal records as normative.
- Never modify an immutable Discovery Governance snapshot.
- Never create Git commits.
- Never publish, archive, or delete remote repositories.
- Never overwrite an existing `AGENTS.md` without explicit instruction and review.
- Show file changes and validation results before completion.
- Use current project registration from plugin-local writable data; do not commit workstation paths.
