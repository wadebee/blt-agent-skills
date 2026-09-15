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
schema adaptations, exact authority classification, source retrieval locations,
interrupted creation and interview recovery, allocation storage,
repeated reviews, and Product-context promotion. The Shimmy bootstrap contract
must come from the selected Product source before Chunk 5.

The user subsequently approved R3's identity rule: use a canonical repository URL
when established, otherwise a developer-confirmed stable identifier for a
local-only repository. Record that identity in provenance and keep workstation
checkout locations in local configuration. Retrieval mechanics remain separate.

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
