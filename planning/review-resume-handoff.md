# Resume the governed exploratory development plan review

Updated: 2026-09-14, America/New_York.
Last inspected repository HEAD: `5cfaaf7` (submodule/reading-scope revision).
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

The user approved retaining portable creation decisions and
their approval context in the Discovery Manifest after successful creation.
Record choices, relevant inputs, provided rationale, approval dates, and material
revisions/exposure; reference the per-path reading-scope record. Local paths and
recovery details remain local. R3 records this approval and R1 owns the schema
adaptation. No source schema/template has been changed for it yet.

The user separately approved preserving applicable interview
answers on resume and revisiting only decisions affected by changed inputs.
Destination changes repeat path checks and creation confirmation; selected
Governance commit changes repeat authority classification and reading-scope
approval. Explain uncertain applicability before revisiting an answer. The
resumption rule and the manifest addition are both settled; exact binding/schema
representation remains to be finalized.

The user approved the recommended source-location rule: use an
established portable clone URL when available, otherwise a confirmed relative
Governance source for local-only projects, keeping absolute paths/local overrides
on the workstation. The user found the technical explanation difficult and
explicitly required user-friendly guidance. R3 now requires practical summaries
of where Governance comes from, whether it is available, and the next action,
with guided repairs and one concrete question when needed. Do not make the user
calculate relative URLs or understand Git configuration to proceed.

The user rejected the proposal to draft a starter Constitution
from getting-started goals. Premature canonical rules create the Architectural
Sediment this workflow is intended to avoid. They want non-normative breadcrumb
guidance toward understanding durable requirements and proper promotion, applying
the explicitly invoked domain-modeling skill. R3 withdraws the old proposal and
describes clarification/scenarios, Discovery, Findings and Conformance Proofs,
proposals, human review, and the appropriate target artifact. Setup approval is
not promotion, and Constitution is not the default destination for every rule.

The Constitution must exist but may initially be an empty
placeholder until matured Governance is deliberately promoted into it. The
proposal to allow no Constitution is withdrawn. R2/R3 and the glossary now
distinguish required existence from substantive constitutional rules. Initial
Discovery may proceed with a valid empty placeholder, subject to normal checks;
missing/malformed artifacts still fail, and Curated scope must allow the path.
No rules are invented to populate it. Existing obligations retain their authority,
and later promotion preserves existing Discovery pins and creation history.

Exact guide layout and placeholder metadata/template representation remain open.
A Governance README with links from role instructions is proposed, with lazy
creation of context/glossary/decision documents. Guidance must identify which
report/promotion handlers only arrive in Chunks 3–4. Source schemas and templates
have not yet been adapted. Continue remaining R3 existing-project validation and
pending-adoption details, then outstanding R1/R2/R4 and later-chunk items; do not
reopen Constitution presence or require initial constitutional rules.

The user approved ordinary uncommitted edits outside the
read-only Governance submodule when the relevant identity/path/Git checks pass,
reporting and preserving that work. Unresolved conflicts, modified consuming
Governance contents, and unexplained pin discrepancies require diagnosis. This
existing-project policy is now approved and must not be re-asked.

Latest correction: the user challenged the accidental requirement to verify
Product adoption during Discovery creation. Product and Discovery share Governance
but choose revisions independently. R3 now explicitly prohibits making Discovery
creation inspect or verify Product adoption or wait for its commit. With existing
configuration, validate the original Governance source and the new Discovery's
own inputs/submodule. Product-derived inputs matter only when explicitly selected
and permitted; do not rerun Product registration as a Discovery preflight.

Pending adoption remains a Product-scoped proposal for explicit registration and
adoption workflows. The user has not approved that state-handling policy. Its
earlier extension to Discovery creation is withdrawn. Continue the remaining
review without reintroducing Product-readiness gates into Discovery creation.

Use `rg` for repository text searches. The user corrected earlier fallback use;
the activated Shimmy wrapper was successfully used without installation or repair.
On the latest turn, a sandboxed connection failure was resolved by retrying the
same read-only command with exact outer-command escalation. Do not infer that
`rg` is unavailable or that the engine needs repair from the sandbox error alone.

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
- Discovery creation does not verify Product adoption, inspect its Git state,
  or wait for its commit. For an already registered project, unavailable Product
  or pending adoption does not block Isolated Discovery with valid Governance
  inputs. Explicitly selected Product-derived inputs retain their own checks.
- Governance identity uses the canonical repository URL when established,
  otherwise a developer-confirmed stable identifier for a local-only repository.
  The user approved this R3 rule; actual checkout locations stay local and moving
  a checkout does not rewrite provenance. The separately approved retrieval rule
  uses an established portable URL or a confirmed relative source, with local
  overrides kept on the workstation. Guidance must be understandable and actionable.
- Failed/interrupted setup offers exactly Resume and Roll back. This policy is
  approved, with substantial troubleshooting: failure/cause evidence, state and
  resource inventory, actionable diagnostic checks/fixes, a reasoned recovery
  recommendation, and a local diagnostic record. Preview rollback and account
  for anything retained. R3 covers safe retries and interrupted cleanup; Chunk 2
  delivers recovery guidance. No automatic destructive cleanup is approved.
- The Discovery Manifest retains portable creation decisions and approval context
  after successful creation, including provided rationale and material revisions/
  exposure. Reference detailed reading decisions and preserve historical context.
  Later changes require their own approvals; workstation paths and recovery logs
  stay local. This content decision is approved; schema adaptation remains R1 work.
- Resumed interviews retain applicable approvals, revisit affected decisions,
  and explain uncertain applicability. Preserve superseded answers as history
  and check both saved approvals and actual completed work before continuing.
  The user approved this behavior separately from the manifest addition.
- Existing-project setup may proceed with ordinary unfinished edits outside the
  read-only Governance submodule when relevant checks pass. Report and preserve
  the work; conflicts or unexplained Governance discrepancies require diagnosis.
  Pending adoption remains a separate decision.
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
- Initial goals must not become canonical constitutional rules merely to finish
  setup. The user requires understandable navigation from domain questions and
  concrete scenarios to investigation, durable reports, proposals, and deliberate
  promotion. Preserve known justified obligations, uncertainty, and rejected
  ideas. A Constitution is required but may contain no rules initially; the user
  approved this placeholder distinction, and promotion later supplies its content.

## Current artifact map

| Artifact | Contract |
|---|---|
| `DISCOVERY.yaml` | Discovery identity, source/pin, reading-scope reference, charter and lifecycle metadata; approved portable creation-decision addition awaits schema adaptation |
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
| Source-wide supersession | Accepted boundary retained; detailed classification/metadata rules remain R2 proposals. Constitution is required but may begin empty; coverage still applies. Validate minimal metadata without reading excluded bodies. |
| Coverage and selection | R8 settles complete checkout plus Full/Curated reading scope. Supported Git entries, path handling, and authority classification remain R2 details. |
| Production schema adaptations | Reading-scope representation updated. Portable creation-decision content approved; its field structure and validation remain R1 work alongside separate Charter objective, asserted calendar dates, and general cross-document agreement. |
| Data pipeline and canonical bytes | Constrained YAML/offline schemas accepted. Custom Governance canonical-byte hashing is removed. Original-input validation and deterministic metadata rendering still need tool canaries. |
| Persisted interview approval binding | Portable creation-decision retention and reuse of applicable answers on resume are approved. Exact schema representation remains to finalize; do not re-ask the behavior decisions. |
| Topology, identity, pending adoption | Submodules, independent pins, identity, source-location guidance, recovery, placeholder Constitution, and ordinary unfinished-edit handling are approved. Discovery has no Product-adoption readiness gate. Exact guide/metadata representation and Product-scoped pending-adoption handling remain open. |
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
