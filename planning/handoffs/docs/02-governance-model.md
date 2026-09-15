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

## Governance consumption through submodules

Product and each Discovery Repo contain Governance as a read-only Git submodule, conventionally `.governance/`. Each parent records its own exact Pinned Governance Revision. Governance may advance independently without changing either pin.

For Product, the Adopted Governance Revision expresses deliberate adoption and a belief in conformance; advancement requires adoption review. For Discovery Repo, the pin fixes the investigation baseline and makes no conformance claim. A new revision requires a successor Discovery Repo. Neither automatically follows Governance HEAD.

Git records the source commit and working-tree differences. A fresh clone initializes the submodule and retrieves the retained Governance commit. Read-only means workflows do not edit its files or change its pin; it is not a built-in Git filesystem restriction.

## Governance Reading Scope

Every Discovery Repo creation requires an explicit Full or Curated choice after a recommendation. Both modes retain the complete Governance submodule. Record the choice in `DISCOVERY.yaml` and `GOVERNANCE-READING-SCOPE.yaml`, outside the submodule.

### Full

Permit reading the complete tree at the Pinned Governance Revision. Preserve artifact classes and authority markings. Full does not authorize reading other commits or override Product Access Mode. If the tree contains incompatible Product-derived implementation material, require a revised reading scope or access choice before reading it.

### Curated

Always allow the Constitution. Interview for each other tracked path, recording relevance, benefit, risk of reading, risk of exclusion, and the developer's allow/exclude decision. Reports, comparisons, proposals, operational instructions, and supporting files receive explicit decisions too. Use exact Governance-relative file paths; a path grants no access to linked documents or other revisions. Unlisted paths are excluded.

The complete tree stays on disk. Root agent instructions prohibit reading, searching, summarizing, or retrieving excluded bodies through files, Git, connectors, links, other agents, or generated summaries. The same rules apply to a resumed session. Ordinary ignore files and sparse checkout are not substitutes for this reading boundary.

During the interview and source-wide authority checks, permit only path enumeration and minimal authority frontmatter (ID, title, class, supersession links) for excluded candidates. Do not inspect their bodies to classify exposure. Ask the developer to classify unknown exposure before allowing body access.

Resolve authority against the complete pinned commit before applying the reading scope. Exclusion cannot reactivate a superseded artifact, remove an obligation, or imply complete conformance. Duplicate IDs and broken or ambiguous same-level supersession block creation.

Product Access Mode and Governance Reading Scope must both permit a read. An approved change in reading scope requires fresh affected choices and a recorded rationale; prior exposure cannot be undone. Preserve the scope used for earlier reviews in their durable reports. Never silently broaden scope through a plugin update or an edited generated instruction file.

## Governance validation

Validate the logical source identity, exact commit in the manifest and scope record, submodule checkout, and parent Git link. Before the developer's first Discovery commit, the staged Git link is a pending pin; after commit, distinguish HEAD, index, and checkout observations. Stop on unexplained disagreement, modified tracked files, or unexpected untracked/ignored content. Preserve changes for review instead of resetting them.

Read-only submodule contents retain their authority at the pinned revision. Reading-scope records and Contract Exports belong outside `.governance/`; never add generated files to the Governance checkout. Contract-aware exports use `.contracts/` with explicit source provenance and an approved file allowlist.

## Materialized Governance

Generated operational instructions and other artifacts derived from Governance are Materialized Governance. Derived checks and reports gain no normative authority. Generated `AGENTS.md` instructions become repository-owned and may evolve without automatic plugin regeneration, while remaining subject to Governance, reading scope, and access rules. Conformance Proofs unrelated to Governance requirements need not be Materialized Governance.
