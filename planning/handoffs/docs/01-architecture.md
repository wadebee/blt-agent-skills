# Architecture

## Three distinct repository roles

```text
                    ┌──────────────────────────────┐
                    │ Repo 1: Governance          │
                    │                              │
                    │ Constitution                 │
                    │ Specifications               │
                    │ ADRs                         │
                    │ Policies / invariants        │
                    │ Conformance                  │
                    │ Discovery records            │
                    │ Governance proposals         │
                    └──────────────┬───────────────┘
                                   │ governs
                    ┌──────────────┴───────────────┐
                    │                              │
                    ▼                              ▼
       ┌────────────────────────┐       ┌────────────────────────┐
       │ Repo 2: Product        │       │ Repo 3+: Discovery     │
       │                        │       │                        │
       │ Releasable code        │       │ Clean-room starts      │
       │ Production history     │       │ PoCs / experiments     │
       │ Stable architecture    │       │ Competing designs      │
       │ Compatibility burden   │       │ Disposable code        │
       └───────────┬────────────┘       └───────────┬────────────┘
                   │                                │
                   │                     lessons / evidence
                   │                                │
                   │                     human-curated
                   │                                ▼
                   └──────────────────────► Governance
```

The key relationship is:

> **Discovery inherits obligations, not solutions.**

A Discovery repository is governed by an immutable snapshot of project intent but is not implicitly shaped by Product source code, history, scaffolding, dependencies, or prior experimental implementations unless the developer explicitly selects a Product-access mode that allows them.

## Independent workflow mechanism

```text
┌─────────────────────────────────────────┐
│ Beeline-Technologies marketplace repo   │
│                                         │
│ governed-exploratory-development plugin │
│ shimmy-onboarding plugin                │
│ unrelated sibling plugins               │
└───────────────────┬─────────────────────┘
                    │ creates and operates workflows
                    ▼
       Governance / Product / Discovery repos
```

The plugin repository is neither project authority nor Product implementation. It contains reusable operational mechanisms.

## Architectural sediment

> **Architectural sediment is accumulated implementation structure whose continued presence reflects project history rather than current architectural intent.**

Examples include:

- abandoned design directions;
- compatibility artifacts;
- transitional abstractions;
- obsolete conventions;
- workarounds that outlived their cause;
- experiments that accidentally became permanent;
- implementation choices made under superseded requirements;
- duplicated approaches left by partial migrations; and
- structures whose original rationale no longer applies.

Existing code contains both intentional current architecture and architectural sediment. An agent cannot safely assume that a repeated or common code pattern represents current intent. This is why Product code is evidence rather than authority, and why clean Discovery repositories are valuable.

## Goals

- Encourage broad architectural exploration without accumulating false starts in Product.
- Make the exact Governance input to each experiment reproducible.
- Use disagreement between independent experiments to expose ambiguity in Governance.
- Use convergence between independent experiments as design evidence, not proof.
- Preserve lessons and negative knowledge even when experimental code is deleted.
- Keep normative authority, implementation, experimental evidence, and workflow automation separate.
- Minimize user-facing complexity through context-aware routing and concise interviews.

## Non-goals

- Hard security isolation from a malicious agent in version 1.
- Automatic remote repository hosting, archival, or deletion.
- Automatic Git commits.
- Automatic promotion of Discovery findings into Governance.
- Automatic Product conformance claims.
- A general-purpose governance database or issue tracker.
- Automatic synchronization of previously generated `AGENTS.md` files.

## Core data flow

```text
Governance Corpus @ exact commit
             │
             ├── Product consumes through pinned submodule
             │
             └── Discovery receives generated immutable snapshot
                              │
                              ▼
                       Experiment evidence
                              │
                  ┌───────────┴───────────┐
                  ▼                       ▼
          Governance proposal       Code-promotion review
                  │                       │
            human decision           human decision
```
