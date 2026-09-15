# Settled Design Decisions

Active decisions below are **accepted**. Decision 3 is retired; its former mechanism is replaced by Decision 16. Stable numbers are retained for traceability. The user-approved terminology revision follows the repository-root `GLOSSARY.md`; Discovery Disposition includes independent promotion and retention choices. Complexity is the estimated implementation/conceptual cost on a 1–5 scale, where 1 is simplest.

## 1. Governance Artifacts with narrow Constitution — 2/5

Use a broad collection of Governance Artifacts containing a small, highest-authority Constitution plus policies, specifications, ADRs, Conformance Proofs, and supporting records. This avoids treating every artifact as equally foundational while retaining the user’s umbrella concept of project governance.

## 2. Governance Reading Scope is a required choice — 2/5

At creation, present Full and Curated Governance Reading Scope with a concise explanation and recommendation. Require an explicit choice. Both modes use the complete pinned Governance submodule; the choice controls what agents may read, not which files are checked out. Product Access Mode remains an independent limit.

## 3. Retired — consolidated into Decision 16

The user approved the common pinned-submodule mechanism on 2026-09-14. This decision imposes no remaining implementation requirements. Decision 16 owns storage and pinning; Decisions 2 and 20 own reading scope.

## 4. Fixed Discovery Governance revision with successor repository — 2/5

Do not advance Governance inside an active Discovery Repo. If a different Governance revision is needed, create a successor repository referencing the predecessor and reason. Preserve the predecessor's pin, reading scope, and charter to maintain causality and reproducibility.

## 5. Independent Discovery Disposition choices — 2/5

Discovery Governance Promotion and Discovery Code Promotion are independent forms of Discovery Disposition, alongside an independent repository retention choice. Both promotions may be selected. Discovery Repo code may be rejected while its findings are accepted, or vice versa.

## 6. Agent proposal with mandatory human approval — 2/5

Agents may prepare structured Governance Proposals, but humans accept, modify, or reject them. Discovery Repo creates Conformance Proofs; people decide when evidence justifies separate changes to project requirements.

## 7. Fixed authority hierarchy plus same-level supersession — 2/5

Use Constitution > Policies > Specifications > Active ADRs. Lower levels cannot override higher ones. Same-level artifacts may explicitly supersede predecessors; unresolved conflicts are surfaced.

## 8. Conformance Proofs remain non-normative — 2/5

Conformance Proofs include tests, observations, benchmarks, and negative results, whether or not they assess requirements. They support or challenge findings and conformance claims without implying certainty or creating authority. A requirement/test conflict is a Governance inconsistency, not an automatic test victory.

## 9. Developer-selected Discovery Framing — 3/5

Present Neutral, Optimize a quality, Challenge assumptions, and Custom framing with concise descriptions and a recommendation. Explicit selection prevents hidden optimization assumptions and helps create genuinely different candidates.

## 10. Developer-selected Product access — 3/5

Present Isolated, Contract-aware, and Full-reference with a recommendation. This lets clean-room Discovery Repos and integration-aware PoCs coexist without pretending they are equivalent.

## 11. Durable record before selectable Discovery Disposition — 3/5

Every Discovery Review first generates and surfaces a durable record. Then present Archive, Report + Delete, and Keep Active with a recommendation. Knowledge preservation is mandatory; repo retention is contextual.

## 12. Discovery Reports live in Governance — 1/5

Store durable `DISC-*` and `CMPR-*` records under `governance/discoveries/` as explicitly non-normative evidence. This keeps institutional memory searchable even when Discovery Repos are removed.

## 13. Minimal Discovery Repo scaffold — 1/5

Create `AGENTS.md`, `DISCOVERY.yaml`, `GOVERNANCE-READING-SCOPE.yaml`, `.gitmodules`, and the `.governance/` submodule, plus Git administrative data. Contract-aware mode additionally carries approved exports under `.contracts/`, outside the read-only submodule. Language, build, dependency, and test choices remain part of the investigation.

## 14. Compact structured `DISCOVERY.yaml` — 2/5

Record identity, Governance source/pinned revision/reading scope, framing/objective, Product access, predecessor, charter, comparison, workflow version, and status. Do not require broad model/tool telemetry by default.

## 15. Governance-first; Product code as evidence — 2/5

Existing Product patterns are important implementation evidence but are not normative authority. Preserve them when compatible with Governance; surface suspected `Architectural Sediment` instead of propagating it silently.

## 16. Product and Discovery consume Governance via pinned Git submodules — 2/5

Use a read-only Governance submodule at an exact commit in Product and each Discovery Repo. Select their commits independently. Product adoption expresses a belief in conformance; a Discovery pin fixes its investigation baseline without making that claim. Product updates use adoption review; Discovery changes use a successor under Decision 4.

Git records the pin and detects checkout changes. Validate source identity, expected commit, parent index/committed Git link, and clean submodule state, including unexpected untracked or ignored files. Preserve dirty files and surface discrepancies; never repair or advance the pin automatically. Read-only is a workflow rule, not a Git permission mode.

A fresh checkout must initialize its submodule and have access to the retained Governance commit. Both Full and Curated scopes leave the complete tree locally present. Curated uses the approved agent reading boundary in Decision 20; it does not promise physical exclusion or a self-contained single-repository clone.

Approved 2026-09-14. This replaces Decision 3's separate storage mechanism. No copied Governance tree, custom content inventory, or duplicate Governance hashing format is required.

## 17. Independent `Beeline-Technologies` plugin marketplace — 3/5

Agent Skills, templates, scripts, schemas, and workflow automation live in a Shimmy-independent marketplace repo. Governed exploration is one cohesive plugin; unrelated capabilities are sibling plugins. Shimmy bootstrap remains Product-owned, with a separate onboarding skill delegating to it.

## 18. Materialized Governance and generated instruction ownership — 1/5

Materialized Governance covers generated instructions and other artifacts derived from Governance without adding an authority level. Derived checks trace their source requirements and remain Conformance Proofs. The plugin generates each role-specific `AGENTS.md` once. The repository owns it afterward; the plugin never silently regenerates or synchronizes existing files. Repository ownership does not permit violating the recorded reading scope or modifying the read-only Governance submodule.

## 19. Policy plus workflow guardrails for isolation — 2/5

Record access mode and enforce obvious constraints across all transports. Do not claim a hard sandbox; prevent accidental leakage and make violations visible.

## 20. Curated Governance Reading Scope through agent exclusions — 2/5

For each candidate path at the selected Governance commit, explain relevance, benefit, inclusion risk, and exclusion risk. Recommend allow/exclude, then require explicit developer approval. Always allow the Constitution. Record every path decision in `GOVERNANCE-READING-SCOPE.yaml`, together with source identity, commit, Discovery ID, and workflow version. Unlisted paths are excluded by default in Curated mode.

The root agent instructions require reading that record before Governance body content. Apply the allowlist to file reads, searches, Git object reads, connectors, retrieved summaries, and any delegated work. History, links, nested instructions, and other routes grant no access to excluded paths or unapproved revisions. A scope exclusion cannot remove a requirement or reactivate a superseded artifact.

For interview and source-wide authority validation, inspect only path names and minimal frontmatter fields (ID, title, authority class, supersession links) for excluded candidates. Do not read excluded bodies to decide whether they are safe. Unknown Product exposure is surfaced for developer classification before allowing the body. Record accidental exposure and reassess the investigation's clean-room claim.

Full scope permits all supported artifact bodies at the pinned commit only when Product Access Mode is compatible. Curated is an agent/workflow boundary over a complete checkout; physical availability is accepted. Approved 2026-09-14.

## 21. Required compact Discovery Charter — 2/5

Clarify the question and propose success criteria and non-goals through an interview. The developer approves the charter before code generation begins.

## 22. Optional comparison target — 2/5

A Discovery Repo may compare against Product, another Discovery Repo, a prior record, a baseline metric, or nothing. When useful, suggest dimensions and record the approved comparison.

## 23. Optional, recommended Discovery Comparison — 2/5

Detect related Discovery Repos and recommend Discovery Comparison when evidence warrants it. The developer chooses; accepted Discovery Comparison creates a non-normative `CMPR-*` record.

## 24. Discovery Code Promotion interview — 2/5

Recommend Transplant, Adapt, or Reimplement based on production quality, dependencies, conventions, security, portability, integration risk, and shortcuts in the Discovery Repo. The developer decides.

## 25. Small fixed Discovery Repo taxonomy — 2/5

Use Architecture Candidate, Spike, Prototype/PoC, Benchmark, Compatibility Check, Adversarial Investigation, or Other. The type aids routing/search but does not override the charter.

## 26. Sequential ID plus descriptive slug — 2/5

Use immutable IDs such as `DISC-0042` and readable names such as `shimmy-disc-0042-shared-engine`. The ID connects all records and successor/comparison relationships.

## 27. Local Git creation only — 1/5

Version 1 initializes local repos but leaves GitHub or other hosting to the developer. This avoids provider coupling and destructive remote operations.

## 28. Project Setup and Project Activation — 2/5

Project Setup creates the initial Governance/Product pair, with Product pinned to Governance's first commit, and saves Local Project Configuration. Project Activation connects an existing pair on a workstation and establishes or reuses Local Project Configuration. Confirm project name, identity, paths and submodule relationship as applicable; inferred values remain suggestions. Activation does not recreate repositories or perform Governance Adoption. Both remain internal workflows behind the public router.

## 29. Local Project Configuration — 2/5

Store workstation paths in plugin-local data, not committed repositories. Another machine uses Project Activation; repositories retain only intrinsic state.

## 30. Capability-specific Git initialization contract — 1/5

Initial project creation may stage approved generated files, create one initial commit in each new Governance/Product repository, and establish their local submodule connection, as recorded in the authoritative plan. Project Activation and later workflows preserve history and the index.

Discovery creation may initialize its local Governance submodule and stage only `.gitmodules` and the Governance Git link needed to establish that relationship. It creates no commit, stages no other generated files, and adds no Product remote. Present the staged submodule changes alongside unstaged generated files for developer review and commit. Local submodule configuration is allowed for this initialization; it does not authorize hosting, pushing, or later automatic pin changes.

Marketplace commits and disposable fixture preparation follow root repository guidance. None of these runtime contracts authorize executing an implementation chunk during planning.

## 31. Pending proposals live in Governance — 2/5

Store structured, non-normative proposals under `proposals/pending/`. This makes them durable and reviewable without granting authority.

## 32. Accepted proposal requires Product impact assessment — 2/5

Classify effects as none, documentation, conformance/tests, implementation, migration/compatibility, or unknown. Summarize next steps without automatically touching Product.

## 33. Conformance-ready Product adoption review — 2/5

Before advancing the submodule, check impact items, implementation, conformance, tests, and incompatibilities. Recommend, but do not hard-block, the developer’s final choice.

## 34. Filesystem proposal state with minimal resolution metadata — 1.5/5

Use `proposals/pending/` and `proposals/resolved/`, with only accepted/rejected and optional resolving commit metadata. This preserves negative knowledge without building a workflow database.

## 35. Minimal normative metadata — 2/5

Use stable ID, title, and same-level supersession references. Avoid rich status, ownership, and dependency fields until demonstrated necessary.

## 36. `AGENTS.md` is operational only — 1/5

It guides agent behavior, local workflow, and validation but cannot create or override architecture/product requirements. Conflicts are surfaced and Governance wins.

## 37. One public context-aware router with modular internals — 3/5 internal, ~1/5 user-facing

Expose one governed-development skill. Hide Project Setup, Project Activation, Discovery creation, Discovery Review, Discovery Comparison, proposal, promotion, and adoption mechanics behind AI intent routing and concise interviews. Additional internal complexity is justified by much lower user cognitive load.
