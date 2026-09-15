# Terminology source and implementation notes

## Scope and source status

[GLOSSARY.md](../GLOSSARY.md) is authoritative for repository terminology and its
explicit relationships. The user authorized terminology alignment and then the
common Governance submodule/reading-scope revision on 2026-09-14, including the
plan, protected handoff, decision records, schemas, and templates. These are
pre-production design changes, not execution of an implementation milestone.

The repository has reference packages and an
[authoritative plan](notional/governed-exploratory-development.md#plan-status-and-authorization),
with no production plugin or runtime test suite. Source precedence after the
glossary remains decisions, architecture/governance documentation, workflows,
schemas/templates, then reference skeletons. The approved plan clarifications
also govern capability-specific scope and Git permissions.

## Current domain and format alignment

- **Discovery Repo** is the exploratory repository; its durable **Discovery
  Report** shares its DISC ID. **Discovery Comparison** is an optional separate
  CMPR record. Promotion and retention remain independent disposition choices.
- **Pinned Governance Revision** is the exact Git commit consumed by Product or
  Discovery through a read-only submodule. **Adopted Governance Revision** retains
  Product's adoption and conformance meaning. A Discovery pin establishes its
  fixed investigation baseline without a conformance claim.
- **Governance Reading Scope** has Full and Curated modes. Both use the complete
  submodule. Curated is an explicit path-based agent reading boundary, including
  exclusion rules across transports, not a selective physical copy. See source
  [Decision 20](handoffs/decisions/DECISIONS.md#20-curated-governance-reading-scope-through-agent-exclusions--25).
- Decision 16 owns the shared submodule mechanism. Decision 3 is retired, with its
  stable number retained only for traceability. Its schema, template, copied-tree
  builder, custom integrity inventory, and glossary term have been removed.
- `DISCOVERY.yaml` uses `governance.repository`, `commit`, `submodule_path`,
  `reading_scope`, and `reading_scope_record`. The record is
  `GOVERNANCE-READING-SCOPE.yaml` outside the read-only submodule; it uses `mode`
  and exact per-path `allow`/`exclude` decisions. Its schema and template agree.
- Contract Exports live under `.contracts/` with independent source and file
  provenance. Their hashes remain useful because exports are supplied files,
  while Governance provenance is native to Git.
- **Materialized Governance** remains useful for generated instructions and
  derived checks. **Governance Artifacts** names the collection of source
  material; its definition no longer embeds storage-selection modes.
- Framing values remain `neutral`, `optimize-quality`, `challenge-assumptions`,
  and `custom`. Comparison targets retain `discovery-repo` and `discovery-report`.
  Local configuration retains `discovery_repo_parent_path`.
- Marketplace identity retains provenance `Beeline-Technologies`, catalog name
  `beeline-technologies`, and display name `Beeline Technologies`; the plan
  proposes their explicit mapping without generic case normalization.

Reference schema versions stay at `1.0` because no production format has shipped.
No migration of deployed repositories is required. Preserve fixed Discovery pins
and recorded review provenance when future formats evolve.

## Remaining implementation details

The [plan's review register](notional/governed-exploratory-development.md#unresolved)
retains the outstanding decisions. R8 settles submodule storage, Curated agent
exclusions, and their representation; it does not silently settle R1–R4's other
details or R6–R7 lifecycle mechanics. R5's Chunk 2 installation gate is approved.

Remaining details include the data tools' demonstrated input validation, general
schema adaptations, exact authority classification, pending Product adoption,
persisted interview binding schemas and allocation storage,
repeated reviews, and Product-context promotion. The Shimmy bootstrap contract
must come from the selected Product source before Chunk 5.

The user subsequently approved R3's identity rule: use a canonical repository URL
when established, otherwise a developer-confirmed stable identifier for a
local-only repository. Record that identity in provenance and keep workstation
checkout locations in local configuration. The separately approved retrieval rule
uses an established portable clone URL when available, otherwise a confirmed
relative Governance source for local-only projects; absolute paths and local
overrides stay on the workstation. The user required practical guidance: identify
the source, verify the required revision, and guide any needed repair without
requiring Git configuration knowledge. Runtime checks remain unexecuted.

Setup recovery now has exactly two approved actions: Resume and Roll back. R3
requires failure/cause evidence, a resource inventory, actionable troubleshooting,
a reasoned recommendation, a local diagnostic record, and a concrete cleanup
preview. Recovery guidance belongs to Chunk 2; no automatic destructive cleanup
is approved. Runtime verification remains outstanding.

The user also approved retaining portable creation decisions and approval context
in the Discovery Manifest after successful creation: approved choices, relevant
inputs, provided rationale, approval dates, and material revisions/exposure.
Detailed per-path choices remain in the referenced reading-scope record; local
paths and recovery history remain local. R3 records the content contract and R1
owns schema adaptation. The reference manifest schema/template have not yet been
adapted for this addition. The user separately approved preserving applicable
answers on resume and revisiting only affected decisions, with uncertain
applicability explained. Exact interview binding fields remain schema work.

Initial Governance must not turn vague setup goals into constitutional rules.
The user rejected that starting-content proposal and requested breadcrumb guidance
through domain clarification, concrete scenarios, Discovery, Findings/Conformance
Proofs, proposals, and deliberate promotion. This fits the existing meanings of
Constitution, Architectural Sediment, and Governance Proposal; no new glossary
term is established. The domain-modeling skill informs clarification and careful
recording, while the capability's contracts define promotion and adoption.
The user then clarified that a Constitution must exist, but may start as an empty
placeholder until matured Governance is deliberately promoted into it. The
glossary and R2/R3 record that resolved distinction. Missing/malformed artifacts
remain invalid; a valid placeholder adds no constitutional requirements and still
belongs in the approved reading scope. Existing obligations and pinning rules
remain intact. Exact placeholder metadata/template form and non-normative guide
layout remain open; later automated handlers stay in their existing chunks.
Reference schemas/templates remain unchanged and their future adaptation must
avoid descriptions that assume every Constitution already contains rules.

Existing-project setup may proceed with ordinary unfinished edits outside the
read-only Governance submodule when identity/path/Git checks pass. The user
approved reporting and preserving that work, with conflicts and unexplained
Governance discrepancies diagnosed before completion. Recognizing and permitting
pending Product adoption remains a separate R3 proposal for explicit Product
registration/adoption; its committed revision must not be conflated with a locally
applied change. The user corrected the proposed coupling to Discovery creation:
Discovery validates its own Governance source and submodule, without verifying
Product adoption or waiting for a Product commit. Product-derived inputs are
checked only when explicitly selected and permitted. This preserves the existing
independent-pin model rather than changing glossary relationships.

## Verification of earlier terminology work

Earlier 2026-09-14 audits checked obsolete names, local links, JSON/YAML syntax,
frontmatter, and selected schema/template fields. Those results predate this
revision and do not prove the current artifacts or runtime behavior. Their
historical command/output details are retained in Git history. The earlier
bundled skill validator could not run because its Python environment lacked
PyYAML; Ruby provided equivalent frontmatter syntax checks without adding a
production dependency.

## Verification of the submodule revision

Checks run on 2026-09-14:

| Check | Result |
|---|---|
| `python3 /tmp/check_governance_revision.py` | Passed: 55 source files checked for obsolete names, 277 local links/anchors resolved, 39 glossary terms indexed, six JSON files parsed, two skill reference trees and portable package paths checked, scope/schema fields compared, AT-001–033 confirmed. |
| `ruby /tmp/check_governance_data.rb` | Passed: three YAML templates and six Markdown frontmatters parsed; both skill metadata blocks and manifest/scope identities and fields agree. |
| `git diff --check` | Passed after removing two extra trailing blank lines. |
| Bundled skill-creator `quick_validate.py` | Could not run: Python lacks PyYAML. Ruby parsing and targeted metadata checks above passed; no dependency was installed. |
| Official packaging and skill guidance | Rechecked portable root manifests, inline OpenAI extension metadata, and skill directory/frontmatter requirements; reference manifests remain unchanged. |

Official sources: [Plugin packaging](https://developers.openai.com/plugins/build/plugins)
and [Build skills](https://developers.openai.com/plugins/build/skills). These checks
verify source documents and reference formats, not installed-plugin discovery or
full JSON Schema validation. Python/Ruby were temporary maintenance tools, not
production dependencies.

The acceptance matrix contains AT-001–033, including four new reading-scope and
submodule boundary cases. Runtime tests, selected-tool canaries, and the required
Chunk 2 installation test have not run. No production code was added, dependencies
installed, commits created, or real project repositories modified.
