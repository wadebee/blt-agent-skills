# Resume the governed exploratory development plan review

Updated: 2026-09-14, America/New_York.
Last inspected repository HEAD: `a8110c5bf59a3338dd95e43fecb5cb1633ae154b`.
State: **PLAN / REVIEW. No implementation chunk is authorized or active.**

This is a context handoff, not an implementation plan or execution instruction.
The [authoritative plan](notional/governed-exploratory-development.md) owns the
current decisions, unresolved items, chunks, and review gates. Earlier handoff
text is available in Git history; it must not reintroduce retired mechanisms.

## Latest user intent and authorization

The user asked whether all review items were complete and requested an interactive
decision review. They approved successful local installation, skill discovery,
and namespacing verification as a required Chunk 2 acceptance gate, with broader
hardening in Chunk 6. R5 records that decision; the test has not run.

The user then approved using the same pinned Governance submodule mechanism in
Product and Discovery Repos, accepted Curated scope as agent reading exclusions
while excluded files remain locally present, and requested removal of obsolete
terms, decisions, and reference machinery. This explicitly authorizes the related
plan, glossary, handoff, decision, schema, and template maintenance. R8 records
the resulting contract. It does not authorize a production implementation chunk,
dependency installation, marketplace commits, pushes, or publishing.

Continue the interview with context: explain the concrete problem, an example,
recommendation, and tradeoff before asking one plain-text question. Structured
prompts were previously not visible to the user. Do not re-ask settled choices.

## Read on resumption

1. [Root instructions](../AGENTS.md).
2. [Glossary](../GLOSSARY.md).
3. [Terminology and source notes](terminology-notes.md).
4. [Authoritative plan](notional/governed-exploratory-development.md), especially
   R1–R8, Capability domain knowledge, and Session bootstrap.
5. Required source documents in order: [brief](handoffs/codex/IMPLEMENTATION-BRIEF.md),
   [architecture](handoffs/docs/01-architecture.md),
   [decisions](handoffs/decisions/DECISIONS.md),
   [plugin architecture](handoffs/docs/05-plugin-architecture.md),
   [phases](handoffs/codex/IMPLEMENTATION-PHASES.md), and
   [acceptance matrix](handoffs/codex/ACCEPTANCE-TEST-MATRIX.md).
6. The current references relevant to the next decision.

Root guidance permits explicitly authorized source maintenance. Production work
must not change protected references simply to make an implementation pass.
There are no production plugins, runtime scripts, or tests in this repository.
The reference plugin packages remain design artifacts.

## Decisions to preserve

- Product, Governance, and each Discovery Repo are separate Git repositories.
- Product and Discovery consume Governance through independent read-only
  submodules at exact commits. Decision 16 owns this mechanism; Decision 3 is
  retired and imposes no remaining requirements.
- **Pinned Governance Revision** names the shared Git pin. **Adopted Governance
  Revision** retains Product's deliberate-adoption and belief-in-conformance
  meaning. Discovery pinning makes no conformance claim.
- A Discovery pin stays fixed. A different revision requires a successor with
  predecessor/reason pairing; Product adoption remains a separate workflow.
- **Governance Reading Scope** replaces selection of physically present files.
  Full permits the pinned tree subject to Product access. Curated records exact
  path allow/exclude decisions, always permits Constitution, and excludes all
  unlisted bodies. Complete Governance files remain present in both modes.
- Agent exclusions apply before file reads, searches, Git access, nested
  instructions, summaries, links, connectors, and delegated work. Path names and
  minimal authority metadata remain available for interviews and source-wide
  validation. Do not read excluded bodies to classify their exposure risk.
- Neither scope nor Product access overrides the other. Exclusion cannot remove
  obligations or reactivate superseded artifacts. Physical availability is not
  permission; version 1 claims workflow guardrails, not a hard sandbox.
- Scope amendments require affected explicit choices and rationale. Preserve the
  scope used by previous reviews and record exposure; instruction edits grant
  no implicit permission.
- Discovery creation may stage only `.gitmodules` and its Governance Git link
  and configure the required local submodule. It creates no commit and leaves
  other generated files unstaged. Fresh clones initialize from an available
  copy of the retained Governance commit.
- Initial Governance/Product creation retains its separate approved initial
  commit allowance. Existing-project registration and later operations preserve
  history and index. Root guidance separately permits disposable test setup.
- Discovery source revision is interviewed with the registered Governance HEAD
  as a default. It is confirmed and frozen independently of Product's pin.
- Governance identity uses the canonical repository URL when established,
  otherwise a developer-confirmed stable identifier for a local-only repository.
  The user approved this R3 rule; actual checkout locations stay local and moving
  a checkout does not rewrite provenance. Retrieval-locator details remain open.
- Discovery Reports reuse DISC IDs; Comparisons use CMPR IDs. Allocation follows
  approved inputs; occupied/failed reserved IDs are not reused. Sequences are
  independent, and coordination is limited to one Governance checkout.
- Discovery Review surfaces a durable report before independent promotion and
  retention choices. Keep Active remains active. Findings and Conformance Proofs
  remain distinct; neither creates normative authority.
- Materialized Governance still covers generated instructions and derived
  artifacts, each with applicable ownership rules. Its generated-copy example
  has been removed, not replaced by a new authority level.
- `yq` and `jv` are the selected data tools; no production Python dependency.
  Constrained metadata YAML and offline schemas are approved; tool behavior
  checks have not run. Simplicity remains a review criterion.

## Current artifact map

| Artifact | Contract |
|---|---|
| `DISCOVERY.yaml` | Discovery identity, source/pin, reading-scope reference, charter and lifecycle metadata |
| `.governance/` | Read-only Governance submodule at the exact selected commit |
| `.gitmodules` | Portable submodule source/path declaration; local path overrides remain workstation configuration |
| `GOVERNANCE-READING-SCOPE.yaml` | Source/commit-bound mode and agent reading decisions, outside the submodule |
| `.contracts/EXPORT.yaml` and `.contracts/files/` | Contract-aware exports and their independent provenance; never inside Governance |
| `schemas/governance-reading-scope.schema.json` | Reading-scope schema in the source handoff; production counterpart belongs to Chunk 1 |
| `scripts/lib/governance.sh`, `tests/test_governance.sh` | Planned submodule, authority, and reading-boundary helpers/checks; not implemented |

The obsolete separate Governance-copy schema, template, hashing format, and
builder have been removed. No deployed data exists, so no migration is needed.

## Remaining review work

| Original finding | Current disposition |
|---|---|
| Source-wide supersession | Accepted boundary retained; detailed classification rules remain R2 proposals. Validate minimal metadata without reading excluded bodies. |
| Coverage and selection | R8 settles complete checkout plus Full/Curated reading scope. Supported Git entries, path handling, and authority classification remain R2 details. |
| Production schema adaptations | Reading-scope representation updated. Separate Charter objective, asserted calendar dates, and general cross-document agreement remain R1 review items. |
| Data pipeline and canonical bytes | Constrained YAML/offline schemas accepted. Custom Governance canonical-byte hashing is removed. Original-input validation and deterministic metadata rendering still need tool canaries. |
| Persisted interview approval binding | R3 proposes invalidating only affected answers; detailed resume mechanics remain to finalize. |
| Topology, identity, pending adoption | Shared submodule architecture, independent pins, and canonical-URL-or-stable-local-identifier rule settled. Retrieval-locator details, existing-pair validation, initialization recovery, and pending Product adoption remain R3/Chunk 4 details. |
| ID occupancy and namespaces | Core allocation policy accepted. Storage, bounded retries, and recovery details remain R4 proposals. |
| Lifecycle transitions | Independent dispositions and Keep Active settled. Repeat-review preservation, interruption, cancellation, and Archive mechanics remain R6. |
| Product promotion context | R7 still needs the Product-context handoff and revised-proposal resolution contract. Do not feed Product knowledge back into an isolated investigation. |
| Guidance and verification | Git scope separation, fixture setup, and required Chunk 2 installation gate settled. R8 adds the narrow Discovery submodule initialization allowance. Acceptance checks remain unexecuted. |

The exact Shimmy Product source/release and bootstrap contract remains a Chunk 5
prerequisite. Sibling checkout names are discovery leads, not an accepted source
or authorization to run bootstrap. No complete Product release workflow is added.

The acceptance matrix now contains **AT-001–033**. AT-030–033 specify exclusion
bypass prevention, Git-state validation, invalid reading records, and resumed or
amended scope. They are specified cases, not executed runtime tests.

## Repository sync and validation

The working tree already contained the approved R5 plan edit before R8 source
maintenance began. Preserve those changes and any subsequent user work. Inspect
`git status --short`, recent history, staged/unstaged diffs, and untracked files;
do not reset to the recorded HEAD. New reference schema/template files require
separate inspection because ordinary `git diff` omits untracked contents.

Documentation and reference-format checks for this revision are recorded in
[terminology notes](terminology-notes.md#verification-of-the-submodule-revision).
They do not establish runtime behavior, selected-tool support, or installed-plugin
compatibility. Implementation and dependency acquisition require a later explicit
instruction; the plan remains in `planning/notional/`.
