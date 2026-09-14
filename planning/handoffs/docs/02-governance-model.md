# Governance Model

## Terminology

### Governance Artifacts

The broad durable body of governance-related material held in the Governance repository. It includes normative authority, derived Conformance Proofs, and explicitly non-normative institutional knowledge.

### Constitution

The small, highest-authority subset containing foundational principles, non-negotiable invariants, project philosophy, and governance rules.

## Artifact classes and authority

```text
Normative authority
1. Constitution
2. Policies
3. Specifications
4. Active ADRs

Conformance Proofs (non-normative)
- Checks and results assessing requirements
- Discovery Reports and Discovery Comparisons
- Pending and resolved Governance proposals
- Other supporting material, including observations and negative results
```

Conformance Proofs may support or challenge findings and need not concern requirements. The name does not imply certainty or successful conformance.

Policies establish general rules; Specifications define required behavior or properties. An Active ADR remains applicable and has not been explicitly superseded by another ADR.

Rules:

1. Lower-authority artifacts cannot override higher-authority artifacts.
2. Same-level artifacts may explicitly supersede predecessors.
3. An unresolved same-level conflict must be surfaced; an agent must not guess.
4. Conformance Proofs support or challenge claims about requirements being met; they do not create requirements.
5. If Conformance Proofs conflict with their governing requirements, surface the inconsistency and propose a correction rather than assuming the test is correct.
6. Presence in the Governance repository does not imply authority. Artifact class determines authority.

## Minimal normative metadata

Normative artifacts use only metadata needed to prevent ambiguity:

```yaml
---
id: ADR-0021
title: Shared engine lifecycle
supersedes:
  - ADR-0014
---
```

Avoid generic lifecycle, owner, dependency, or implementation-status fields unless later Conformance Proofs demonstrate a need.

## Governance repository contents

```text
constitution/              normative
policies/                  normative
specs/                     normative
adr/                       normative when active
conformance/               derived Conformance Proofs
discoveries/               non-normative Conformance Proofs
proposals/pending/         non-normative proposed changes
proposals/resolved/        non-normative historical decisions
```

## Proposal state

Filesystem location is the primary state representation:

```text
proposals/pending/GOVP-0012.md
              │
              ▼ human decision
proposals/resolved/GOVP-0012.md
```

A resolved proposal adds only minimal metadata:

```yaml
resolution: accepted
resolved_by: <optional-commit-sha>
```

or:

```yaml
resolution: rejected
```

Accepted proposals cause separate edits to authoritative artifacts. Moving a proposal does not itself change Governance.

## Product consumption of Governance

Product contains the Governance repository as a pinned, read-only Git submodule, conventionally `.governance/`.

```text
Product commit P
    └── .governance → Governance commit G
```

The pointer means:

> Product has deliberately adopted Governance revision G and believes it satisfies that revision.

The submodule must never automatically follow Governance HEAD. Advancement requires a conformance-ready adoption review.

## Governance Artifacts selection

Every Discovery Implementation creation requires an explicit choice after the router provides a recommendation.

### Full Governance Artifacts

Copy a complete version-pinned Governance projection into the Discovery Implementation repository. Preserve artifact classes and authority markings. This mode is best when historical decisions and broad alignment are more important than reducing implementation anchoring.

### Curated Governance Artifacts

Always include the Constitution, then select applicable policies, specifications, ADR constraints, and Conformance Proofs through a decision-by-decision interview. Materially relevant exclusions must be recorded with rationale. Non-normative Discovery Implementation/proposal Conformance Proofs are included only by explicit choice.

The selection interview must explain for each candidate:

- why it appears relevant;
- the benefit of carrying it forward;
- the risk of carrying it forward, especially anchoring;
- the risk of excluding it; and
- the recommended include/exclude choice.

The developer accepts, rejects, or modifies each choice.

## Generated Governance Snapshot

The selected material is copied into `.governance/` with a `SNAPSHOT.yaml` provenance record. The snapshot is immutable for the Discovery Implementation. A material Governance change creates a successor Discovery Implementation repository with a new Governance commit and `derived_from` reference.

## Materialized Governance

Governance Snapshots, generated operational instructions, and other artifacts derived from Governance are Materialized Governance. Copied requirements retain their source authority; derived checks and reports do not gain normative authority. Discovery Implementation snapshots are immutable, while generated `AGENTS.md` instructions become repository-owned and may evolve without automatic plugin regeneration. Conformance Proofs unrelated to Governance requirements need not be Materialized Governance.
