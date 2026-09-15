# Governed Exploratory Development Glossary

This repository is intended to provide reusable workflows for exploring software designs while keeping project authority, releasable implementation, and Conformance Proofs from Discovery Repos separate. Its central rule is: **Discovery Repo inherits obligations, not solutions.**

Terms are alphabetized across all categories. Each term carries linked
**Category** metadata preserving its responsibility grouping. The [category
descriptions](#terminology-categories) define those groupings, including [Shared](#shared)
for language shared across all categories. Categories describe usage, not implementation
modules or exclusive ownership. A term may list multiple categories as needed.

Emphasized references identify domain terms. `_Avoid_` identifies misleading
substitutions, not a ban on ordinary prose. The definitions describe specified behavior;
they do not claim that production workflows are implemented. [Source and implementation notes](planning/terminology-notes.md) document provenance and open implementation details. This glossary is authoritative for terminology throughout this repository; production implementation remains separately authorized.

## Terminology categories

### Category index

- [Discovery lifecycle](#discovery-lifecycle)
- [Governance authority and findings](#governance-authority-and-findings)
- [Product integration and adoption](#product-integration-and-adoption)
- [Shared](#shared)
- [Workflow delivery](#workflow-delivery)

### Category descriptions

#### Discovery lifecycle

The language for defining, creating, conducting, and closing a Discovery Repo, including its charter, identity, context, access boundaries, provenance, and retention choices.

[back to category index](#category-index)

#### Governance authority and findings

The language for project requirements, their authority and supersession, and the durable findings, records, and proposals that inform decisions without becoming requirements themselves.

[back to category index](#category-index)

#### Product integration and adoption

The language for bringing Discovery Repo code or designs into Product, exposing approved contracts to Discovery Repo, and deliberately adopting Governance revisions.

[back to category index](#category-index)

#### Shared

Shared project language used across all categories. These terms retain the same meaning wherever they appear; Shared usage does not imply shared ownership or equal authority.

[back to category index](#category-index)

#### Workflow delivery

The language for distributing reusable workflow capabilities and connecting them to project repositories, including routing, Project Setup, Project Activation, Local Project Configuration, and ownership of generated instructions.

[back to category index](#category-index)

## Terminology Index

- [A](#a): [Active ADR](#active-adr), [Adopted Governance Revision](#adopted-governance-revision), [Architectural Sediment](#architectural-sediment)
- [B](#b): [Beeline-Technologies Marketplace](#beeline-technologies-marketplace)
- [C](#c): [Comparison Target](#comparison-target), [Conformance Proofs](#conformance-proofs), [Constitution](#constitution), [Contract Export](#contract-export)
- [D](#d): [Discovery Charter](#discovery-charter), [Discovery Code Promotion](#discovery-code-promotion), [Discovery Comparison](#discovery-comparison), [Discovery Disposition](#discovery-disposition), [Discovery Framing](#discovery-framing), [Discovery Governance Promotion](#discovery-governance-promotion), [Discovery ID](#discovery-id), [Discovery Manifest](#discovery-manifest), [Discovery Repo](#discovery-repo), [Discovery Report](#discovery-report), [Discovery Review](#discovery-review), [Discovery Type](#discovery-type)
- [F](#f): [Finding](#finding)
- [G](#g): [Governance](#governance), [Governance Adoption](#governance-adoption), [Governance Artifacts](#governance-artifacts), [Governance Proposal](#governance-proposal), [Governance Reading Scope](#governance-reading-scope), [Governed Development skill](#governed-development-skill)
- [L](#l): [Local Project Configuration](#local-project-configuration)
- [M](#m): [Materialized Governance](#materialized-governance)
- [P](#p): [Pinned Governance Revision](#pinned-governance-revision), [Policy](#policy), [Product](#product), [Product Access Mode](#product-access-mode), [Product Impact Assessment](#product-impact-assessment), [Project Activation](#project-activation), [Project Setup](#project-setup)
- [S](#s): [Shimmy Onboarding](#shimmy-onboarding), [Specification](#specification), [Successor Discovery Repo](#successor-discovery-repo), [Supersession](#supersession)

## A

### Active ADR

**Category:** [Governance authority and findings](#governance-authority-and-findings)

An architectural decision record that is still applicable and has not been explicitly superseded by another ADR. Active ADRs occupy the fourth normative authority level and cannot override higher-level requirements.

Sources: [Governance model](planning/handoffs/docs/02-governance-model.md), [Promotion and adoption](planning/handoffs/docs/04-promotion-and-adoption.md), [Discovery Report template](planning/handoffs/templates/DISCOVERY-REPORT.md), [Discovery Comparison template](planning/handoffs/templates/DISCOVERY-COMPARISON.md), decisions 5–8, 12, 23, 31–35.

### Adopted Governance Revision

**Category:** [Product integration and adoption](#product-integration-and-adoption)

The ***Pinned Governance Revision*** deliberately adopted by ***Product*** through its read-only Governance submodule. The pin expresses deliberate adoption and a belief in conformance; it is neither automatic proof of conformance nor necessarily the revision selected for a new ***Discovery Repo***.

Sources: [Promotion and adoption](planning/handoffs/docs/04-promotion-and-adoption.md), [Product layout](planning/handoffs/reference-layouts/product-repo.md), [Isolation modes](planning/handoffs/docs/08-security-and-isolation.md), decisions 5, 16, 24, 32–33.

### Architectural Sediment

**Category:** [Shared](#shared)

Accumulated implementation structure whose continued presence reflects project history rather than current architectural intent. A repeated ***Product*** pattern does not, by itself, establish a current requirement.

Sources: [Architecture](planning/handoffs/docs/01-architecture.md), [Governance model](planning/handoffs/docs/02-governance-model.md), decisions 1, 15–17.

[back to index](#terminology-index)

## B

### Beeline-Technologies Marketplace

**Category:** [Workflow delivery](#workflow-delivery)

The intended catalog and distribution boundary for independent, cohesive plugins. `Beeline-Technologies` is the handoff's marketplace name; `blt-agent-skills` is the current checkout name.

Sources: [Plugin architecture](planning/handoffs/docs/05-plugin-architecture.md), [Onboarding contract](planning/handoffs/plugin-reference/plugins/shimmy-onboarding/skills/shimmy-onboarding/references/onboarding-contract.md), decisions 17–18, 28–30, 36–37.

[back to index](#terminology-index)

## C

### Comparison Target

**Category:** [Discovery lifecycle](#discovery-lifecycle)

An optional reference against which a ***Discovery Repo*** is evaluated using approved comparison dimensions. It may be ***Product***, another Discovery Repo, a ***Discovery Report***, a quantitative baseline, or none; comparison does not establish ancestry or grant access permission.

Sources: [Discovery Repo lifecycle](planning/handoffs/docs/03-discovery-lifecycle.md), [Security and isolation](planning/handoffs/docs/08-security-and-isolation.md), [Discovery Manifest schema](planning/handoffs/schemas/discovery-manifest.schema.json), [Reading scope template](planning/handoffs/templates/GOVERNANCE-READING-SCOPE.yaml), decisions 2, 4, 9–14, 16, 19–22, 25–26.

### Conformance Proofs

**Category:** [Governance authority and findings](#governance-authority-and-findings)

Material used to support or challenge a Finding, explain a decision, or assess whether requirements are met. This includes tests, measurements, benchmarks, code, logs, observations, failed approaches, and negative results, including material unrelated to conformance with requirements.

“Proofs” names the supporting material; it does not imply mathematical certainty, a successful result, complete coverage, or certification of conformance. Preserve limitations, uncertainty, and conflicting results. Conformance Proofs cannot create or override Governance requirements.

A ***Finding*** states what was learned; Conformance Proofs let a reviewer inspect the basis for that statement. For example, a retry test, its run configuration, and logs showing two charges for one payment request are Conformance Proofs supporting the Finding that the tested implementation can duplicate charges after a timeout. The same material may support several findings or challenge an earlier one.

Sources: [Governance model](planning/handoffs/docs/02-governance-model.md), [Promotion and adoption](planning/handoffs/docs/04-promotion-and-adoption.md), [Discovery Report template](planning/handoffs/templates/DISCOVERY-REPORT.md), [Discovery Comparison template](planning/handoffs/templates/DISCOVERY-COMPARISON.md), decisions 5–8, 12, 23, 31–35.

### Constitution

**Category:** [Governance authority and findings](#governance-authority-and-findings)

The narrow, highest-authority part of the ***Governance Artifacts*** containing foundational principles, non-negotiable invariants, project philosophy, and governance rules.

The Constitution must exist, but may initially be an empty placeholder with no
constitutional rules. Its minimum identifying content is a unique artifact ID,
an explicit constitution class, and a title. Folder location does not establish
its authority; a heading may accompany the metadata without adding rules. Matured Governance is added through deliberate promotion;
the placeholder's existence does not itself establish requirements.

Sources: [Governance model](planning/handoffs/docs/02-governance-model.md), [Promotion and adoption](planning/handoffs/docs/04-promotion-and-adoption.md), [Discovery Report template](planning/handoffs/templates/DISCOVERY-REPORT.md), [Discovery Comparison template](planning/handoffs/templates/DISCOVERY-COMPARISON.md), decisions 5–8, 12, 23, 31–35.

### Contract Export

**Category:** [Product integration and adoption](#product-integration-and-adoption)

An explicitly approved set of public interfaces, schemas, formats, compatibility constraints, or extension contracts available to a Contract-aware ***Discovery Repo***. It excludes implementation internals and history and does not gain normative authority merely by being included in the Discovery Repo context.

Sources: [Promotion and adoption](planning/handoffs/docs/04-promotion-and-adoption.md), [Product layout](planning/handoffs/reference-layouts/product-repo.md), [Isolation modes](planning/handoffs/docs/08-security-and-isolation.md), decisions 5, 16, 24, 32–33.

[back to index](#terminology-index)

## D

### Discovery Charter

**Category:** [Discovery lifecycle](#discovery-lifecycle)

The developer-approved definition of a ***Discovery Repo***'s objective, research question, success criteria, and non-goals. It governs Discovery Repo scope relative to descriptive metadata and remains subject to normative ***Governance***.

_Avoid_: Framing objective as a substitute for the complete charter; charter as a fifth authority level.

Sources: [Discovery Repo lifecycle](planning/handoffs/docs/03-discovery-lifecycle.md), [Security and isolation](planning/handoffs/docs/08-security-and-isolation.md), [Discovery Manifest schema](planning/handoffs/schemas/discovery-manifest.schema.json), [Reading scope template](planning/handoffs/templates/GOVERNANCE-READING-SCOPE.yaml), decisions 2, 4, 9–14, 16, 19–22, 25–26.

### Discovery Code Promotion

**Category:** [Product integration and adoption](#product-integration-and-adoption)

A form of ***Discovery Disposition*** that transfers a Discovery Repo’s code or design into ***Product*** through developer-reviewed Transplant, Adapt, or Reimplement. It does not imply acceptance of a ***Governance Proposal***. Promotion uses a separate Product-scoped work session receiving the Discovery Report, approved source code/design, relevant Conformance Proofs and source provenance. Integration findings stay in Product context; they do not rewrite or feed Product internals back into the isolated Discovery investigation.

Sources: [Promotion and adoption](planning/handoffs/docs/04-promotion-and-adoption.md), [Product layout](planning/handoffs/reference-layouts/product-repo.md), [Isolation modes](planning/handoffs/docs/08-security-and-isolation.md), decisions 5, 16, 24, 32–33.

### Discovery Comparison

**Category:** [Governance authority and findings](#governance-authority-and-findings)

A separate written output that brings together results from related ***Discovery Repos*** and explains where they agree, differ, or reveal tradeoffs. It answers “What do we learn by considering these implementations together?” The document has its own `CMPR-*` ID, lives in the ***Governance*** repository's `discoveries/` directory, and remains non-normative.

For example, `DISC-0042` tests payment retries using database deduplication, and `DISC-0043` tests them using a queue. Each has its own ***Discovery Report***. A subsequent `CMPR-0001` compares their duplicate-charge results, latency, and operational complexity, cites the supporting material, and explains which conclusions are limited by different test conditions. It may recommend further investigation or support a ***Governance Proposal***.

In this glossary, Discovery Comparison names the resulting document. The comparison workflow is the activity that produces it. An expectation such as “evaluate duplicate-charge prevention and latency” specifies comparison dimensions in the ***Discovery Charter***; those dimensions guide the analysis but are not themselves a Discovery Comparison. Creating the separate comparison document is optional and developer-selected. It does not replace the individual reports or determine each implementation's ***Discovery Disposition***.

Sources: [Governance model](planning/handoffs/docs/02-governance-model.md), [Promotion and adoption](planning/handoffs/docs/04-promotion-and-adoption.md), [Discovery Report template](planning/handoffs/templates/DISCOVERY-REPORT.md), [Discovery Comparison template](planning/handoffs/templates/DISCOVERY-COMPARISON.md), decisions 5–8, 12, 23, 31–35.

### Discovery Disposition

**Category:** [Discovery lifecycle](#discovery-lifecycle)

The developer’s decisions about what happens to a Discovery Repo and its results. These include two independent forms of promotion—***Discovery Code Promotion*** and ***Discovery Governance Promotion***—plus an independent repository retention choice: Archive, Report + Delete, or Keep Active. Both promotions may be selected, either may be declined or deferred, and neither implies a retention choice or closed status.

**Archive** records the disposition and closes the Discovery Manifest while retaining the Discovery Repo in place, including code, uncommitted work, Git history and access to its Pinned Governance Revision. It does not move or compress the repository, change permissions, or create a commit. **Report + Delete** preserves the Discovery Report and important context, confirms which supporting Conformance Proofs to retain, and stores selected material durably in Governance with updated references and disclosed omissions. It records closed status only after required retention succeeds, then provides manual removal guidance; the agent does not delete the Discovery Repo or claim deletion occurred. **Keep Active** retains active status.

Sources: [Discovery Repo lifecycle](planning/handoffs/docs/03-discovery-lifecycle.md), [Security and isolation](planning/handoffs/docs/08-security-and-isolation.md), [Discovery Manifest schema](planning/handoffs/schemas/discovery-manifest.schema.json), [Reading scope template](planning/handoffs/templates/GOVERNANCE-READING-SCOPE.yaml), decisions 2, 4, 9–14, 16, 19–22, 25–26.

### Discovery Framing

**Category:** [Discovery lifecycle](#discovery-lifecycle)

The deliberately selected lens for a ***Discovery Repo***: Neutral, Optimize a quality, Challenge assumptions, or Custom. Framing describes the optimization or challenge perspective, not the Discovery Repo's type or access permissions.

Sources: [Discovery Repo lifecycle](planning/handoffs/docs/03-discovery-lifecycle.md), [Security and isolation](planning/handoffs/docs/08-security-and-isolation.md), [Discovery Manifest schema](planning/handoffs/schemas/discovery-manifest.schema.json), [Reading scope template](planning/handoffs/templates/GOVERNANCE-READING-SCOPE.yaml), decisions 2, 4, 9–14, 16, 19–22, 25–26.

### Discovery Governance Promotion

**Category:** [Governance authority and findings](#governance-authority-and-findings)

A form of ***Discovery Disposition*** that proposes changes to project requirements based on findings from a ***Discovery Repo***. A human resolves the ***Governance Proposal***; acceptance requires separate edits to authoritative Governance Artifacts. Findings, Conformance Proofs, and the proposal remain non-normative. This decision is independent of ***Discovery Code Promotion***.

_Avoid_: Promotion without identifying whether knowledge or code is meant.

Sources: [Governance model](planning/handoffs/docs/02-governance-model.md), [Promotion and adoption](planning/handoffs/docs/04-promotion-and-adoption.md), [Discovery Report template](planning/handoffs/templates/DISCOVERY-REPORT.md), [Discovery Comparison template](planning/handoffs/templates/DISCOVERY-COMPARISON.md), decisions 5–8, 12, 23, 31–35.

### Discovery ID

**Category:** [Discovery lifecycle](#discovery-lifecycle)

An immutable sequential `DISC-*` identifier allocated from ***Governance*** and shared by the Discovery Repo manifest, repository naming, durable record, and related references. The descriptive slug aids recognition but does not replace the ID.

Sources: [Discovery Repo lifecycle](planning/handoffs/docs/03-discovery-lifecycle.md), [Security and isolation](planning/handoffs/docs/08-security-and-isolation.md), [Discovery Manifest schema](planning/handoffs/schemas/discovery-manifest.schema.json), [Reading scope template](planning/handoffs/templates/GOVERNANCE-READING-SCOPE.yaml), decisions 2, 4, 9–14, 16, 19–22, 25–26.

### Discovery Manifest

**Category:** [Discovery lifecycle](#discovery-lifecycle)

The `.governed/discovery.yaml` record of a ***Discovery Repo***'s identity, framing, Product access, ***Discovery Charter***, comparison, predecessor, workflow version, and status. It obtains Governance identity, ***Pinned Governance Revision***, and the location of its ***Governance Reading Scope*** record from that repository's independent `.governed/governance.yaml` by convention. Product and each Discovery Repo retain their own Governance context and independently selected pins. It describes the Discovery Repo rather than replacing its later ***Discovery Report***.

The approved per-repository context split replaces the reference `DISCOVERY.yaml`'s embedded Governance fields. The approved `.governed/` layout places the Governance Reading Scope in `.governed/reading-scope.yaml`; shared schema definitions remain packaged with the plugin. Reference schemas/templates await coordinated adaptation.

Sources: [Discovery Repo lifecycle](planning/handoffs/docs/03-discovery-lifecycle.md), [Security and isolation](planning/handoffs/docs/08-security-and-isolation.md), [Discovery Manifest schema](planning/handoffs/schemas/discovery-manifest.schema.json), [Reading scope template](planning/handoffs/templates/GOVERNANCE-READING-SCOPE.yaml), decisions 2, 4, 9–14, 16, 19–22, 25–26.

### Discovery Repo

**Category:** [Shared](#shared)

A separate Git repository for a bounded exploratory development effort under an approved ***Discovery Charter*** and a fixed ***Pinned Governance Revision***. It contains the exploratory code, manifest, read-only Governance submodule, and ***Governance Reading Scope*** record. Its code and repository may be disposable even when its findings remain useful.

_Avoid_: Product branch, worktree, Discovery Report when referring to the Discovery Repo.

Sources: [Architecture](planning/handoffs/docs/01-architecture.md), [Governance model](planning/handoffs/docs/02-governance-model.md), decisions 1, 15–17.

### Discovery Report

**Category:** [Governance authority and findings](#governance-authority-and-findings)

A written output recording what one ***Discovery Repo*** investigated, what happened, what was learned, and the developer's subsequent decisions about it. It uses the implementation's `DISC-*` ID and lives in `discoveries/` relative to the ***Governance*** repository root. It preserves the charter, results, ***Conformance Proofs***, limitations, rejected approaches, and independent promotion and retention choices even if the implementation repository is removed. The report remains non-normative.

The report embeds important historical context, including Governance identity,
***Pinned Governance Revision***, ***Discovery Charter***, ***Product Access Mode***,
and the ***Governance Reading Scope*** and relevant prior exposure used for the
review. Detailed supporting scope material must be embedded or durably retained
in Governance. Understanding that context cannot depend on the Discovery Repo's
continued existence or its current manifest contents. Earlier review context
remains preserved when subsequent reviews are recorded. One durable report per Discovery ID receives a new
dated section for each review. Preserve earlier sections and human edits; record
changed conclusions explicitly with their supporting Conformance Proofs.

For example, `DISC-0042` investigates database deduplication for payment retries. Its Discovery Report records whether the tested retries caused duplicate charges, measured latency, links to the tests and logs, untested failure scenarios, and the developer's decisions about promotion and retention. It answers “What did we learn from DISC-0042, and what happens to it next?”

Every ***Discovery Review*** generates and surfaces this report before ***Discovery Disposition*** choices are recorded. If the charter asks for comparison against a ***Comparison Target***, the report includes those results. A comparison section is content within this implementation's report; a ***Discovery Comparison*** is a separate output drawing conclusions across related implementations. Both domain terms therefore name documents, while the charter's question, success criteria, and comparison dimensions describe what the investigation is expected to evaluate.

_Avoid_: Discovery Repo, accepted requirement.

Sources: [Governance model](planning/handoffs/docs/02-governance-model.md), [Promotion and adoption](planning/handoffs/docs/04-promotion-and-adoption.md), [Discovery Report template](planning/handoffs/templates/DISCOVERY-REPORT.md), [Discovery Comparison template](planning/handoffs/templates/DISCOVERY-COMPARISON.md), decisions 5–8, 12, 23, 31–35.

### Discovery Review

**Category:** [Discovery lifecycle](#discovery-lifecycle)

The process that first generates and surfaces a durable ***Discovery Report***, then records the developer’s ***Discovery Disposition*** choices. It may also include an optional ***Discovery Comparison***. Choosing Keep Active continues the work; a review does not imply that the Discovery Repo is closed.

Sources: [Discovery Repo lifecycle](planning/handoffs/docs/03-discovery-lifecycle.md), [Security and isolation](planning/handoffs/docs/08-security-and-isolation.md), [Discovery Manifest schema](planning/handoffs/schemas/discovery-manifest.schema.json), [Reading scope template](planning/handoffs/templates/GOVERNANCE-READING-SCOPE.yaml), decisions 2, 4, 9–14, 16, 19–22, 25–26.

### Discovery Type

**Category:** [Discovery lifecycle](#discovery-lifecycle)

Descriptive classification of a ***Discovery Repo*** as Architecture Candidate, Spike, Prototype/PoC, Benchmark, Compatibility Check, Adversarial Investigation, or Other. Type describes the work being performed; ***Discovery Framing*** describes the perspective applied. An Adversarial Investigation is a kind of work, while Challenge assumptions is a lens that can also be applied to other types. The classification does not override the ***Discovery Charter***.

Sources: [Discovery Repo lifecycle](planning/handoffs/docs/03-discovery-lifecycle.md), [Security and isolation](planning/handoffs/docs/08-security-and-isolation.md), [Discovery Manifest schema](planning/handoffs/schemas/discovery-manifest.schema.json), [Reading scope template](planning/handoffs/templates/GOVERNANCE-READING-SCOPE.yaml), decisions 2, 4, 9–14, 16, 19–22, 25–26.

[back to index](#terminology-index)

## F

### Finding

**Category:** [Governance authority and findings](#governance-authority-and-findings)

A stated observation or conclusion from a ***Discovery Repo*** or ***Discovery Comparison*** that explains what was learned, under which conditions, and with what limitations. Distinguish directly observed behavior from interpretation. A Finding is distinct from its supporting ***Conformance Proofs*** and its possible implication for project requirements; it does not itself create or change a requirement.

For example, suppose a ***Specification*** requires retries of the same payment request to produce at most one charge:

- **Finding:** “In the tested implementation, retrying after a timeout produced two charges for the same request. Duplicate-charge prevention therefore failed in this scenario; other failure scenarios have not yet been evaluated.”
- **Supporting Conformance Proofs:** the reproducible timeout-and-retry test, implementation revision, run configuration, failing assertion, and transaction logs showing the two charge IDs for the same request.
- **Possible next action:** investigate a deduplication change and test it. If the work instead exposes an ambiguous requirement, a separate ***Governance Proposal*** may request clarification; the Finding alone does not authorize that change.

The Finding communicates the lesson; the Conformance Proofs allow a reviewer to check or challenge it. An observation can appear in both roles: a log entry is supporting material, while the report's statement explaining what that entry establishes is a Finding. Findings may describe successes, failures, tradeoffs, or unresolved questions, including matters unrelated to conformance.

Sources: [Governance model](planning/handoffs/docs/02-governance-model.md), [Promotion and adoption](planning/handoffs/docs/04-promotion-and-adoption.md), [Discovery Report template](planning/handoffs/templates/DISCOVERY-REPORT.md), [Discovery Comparison template](planning/handoffs/templates/DISCOVERY-COMPARISON.md), decisions 5–8, 12, 23, 31–35.

[back to index](#terminology-index)

## G

### Governance

**Category:** [Shared](#shared)

The system of project requirements and decision authority. The Governance repository stores ***Governance Artifacts***; only their normative classes establish requirements.

_Avoid_: Governance as shorthand for every document being binding.

Sources: [Architecture](planning/handoffs/docs/01-architecture.md), [Governance model](planning/handoffs/docs/02-governance-model.md), decisions 1, 15–17.

### Governance Adoption

**Category:** [Product integration and adoption](#product-integration-and-adoption)

An explicit ***Product*** decision to advance its pinned ***Governance*** revision after reviewing impact, implementation, conformance, tests, and incompatibilities. The workflow recommends readiness or deferral while leaving the final choice to the developer. After approval it updates Product's Governance submodule checkout and `.governed/governance.yaml` consistently, without staging or committing. Local application remains pending the developer's commit. Recovery uses the local operation journal, preserves unrelated work and subsequent developer changes, and does not change Discovery Repo contexts.

_Avoid_: Proposal acceptance, automatic synchronization, automatic conformance certification.

Sources: [Promotion and adoption](planning/handoffs/docs/04-promotion-and-adoption.md), [Product layout](planning/handoffs/reference-layouts/product-repo.md), [Isolation modes](planning/handoffs/docs/08-security-and-isolation.md), decisions 5, 16, 24, 32–33.

### Governance Artifacts

**Category:** [Shared](#shared)

The documents and other material stored in the Governance repository: requirements, Conformance Proofs, Discovery Reports, Discovery Comparisons, and proposals. Each artifact retains its authority classification; storage in Governance does not make every artifact binding. An artifact's normative class is determined from its content, independently of its folder or filename; directory structure does not establish authority. Identifying an artifact's class must still respect the permitted reading boundary. If authority is missing or ambiguous, the agent prompts for classification. If unresolved, it ignores the artifact as a normative input with a warning and records the limitation; this does not establish that the artifact has no requirements or waive known obligations.

A ***Governance Reading Scope*** determines which artifacts an agent may read in a ***Discovery Repo*** at its ***Pinned Governance Revision***. The complete Governance checkout remains present; the scope does not alter authority.

_Avoid_: Constitution as a name for the complete set of Governance Artifacts.

Sources: [Architecture](planning/handoffs/docs/01-architecture.md), [Governance model](planning/handoffs/docs/02-governance-model.md), decisions 1, 15–17.

### Governance Proposal

**Category:** [Governance authority and findings](#governance-authority-and-findings)

A structured, non-normative request to change ***Governance***, connecting findings and Conformance Proofs to a target artifact and suggested change. Acceptance authorizes separate normative edits; the proposal itself remains non-normative. Modification alone leaves the proposal pending until its revised wording is explicitly accepted or rejected. An unambiguous instruction may explicitly combine revision and acceptance. Preserve material revisions and supplied rationale; acceptance does not transfer silently to subsequently changed wording or imply Governance Adoption.

_Avoid_: Policy, Specification, or accepted Governance when referring only to a proposal.

Sources: [Governance model](planning/handoffs/docs/02-governance-model.md), [Promotion and adoption](planning/handoffs/docs/04-promotion-and-adoption.md), [Discovery Report template](planning/handoffs/templates/DISCOVERY-REPORT.md), [Discovery Comparison template](planning/handoffs/templates/DISCOVERY-COMPARISON.md), decisions 5–8, 12, 23, 31–35.

### Governance Reading Scope

**Category:** [Discovery lifecycle](#discovery-lifecycle)

The developer-approved boundary on which ***Governance Artifacts*** an agent may read for a ***Discovery Repo*** at its ***Pinned Governance Revision***. Together, the pin and reading scope define that investigation's Governance context. Both are fixed when the Discovery Repo is created; changing either requires a ***Successor Discovery Repo***. A different reading scope constitutes a different Governance context even at the same commit. This does not change artifact authority or remove obligations through exclusion.

- **Full:** permits reading all artifacts in the pinned commit's tree, subject to ***Product Access Mode***.
- **Curated:** always permits the Constitution, then records explicit per-path allow/exclude decisions and reasons. Excluded and unlisted artifact bodies must not be read, searched, summarized, or obtained indirectly through other tools or agents.

Both modes use the complete Governance submodule. Curated limits agent access, not file presence. Path names and the minimal authority metadata needed to conduct the interview and resolve supersession may be inspected without reading excluded bodies. The scope does not authorize other commits or history, change normative authority, or reactivate a superseded artifact. Product access and this scope must both permit a read.

For example, a Curated scope can permit the Constitution and retry specification while excluding a report about Product's retry implementation. That report remains in the checkout, but the agent must not inspect its contents or obtain a summary elsewhere. These are agent and workflow rules, not a filesystem security boundary.

Sources: [Governance model](planning/handoffs/docs/02-governance-model.md), [Security and isolation](planning/handoffs/docs/08-security-and-isolation.md), [Reading scope template](planning/handoffs/templates/GOVERNANCE-READING-SCOPE.yaml), decisions 2, 16, 19–20.

### Governed Development skill

**Category:** [Workflow delivery](#workflow-delivery)

The single public `governed-development` skill of the `governed-exploratory-development` plugin. It interprets user intent and conducts concise interviews while internal lifecycle workflows remain supporting modules rather than a user-facing menu.

Sources: [Plugin architecture](planning/handoffs/docs/05-plugin-architecture.md), [Onboarding contract](planning/handoffs/plugin-reference/plugins/shimmy-onboarding/skills/shimmy-onboarding/references/onboarding-contract.md), decisions 17–18, 28–30, 36–37.

[back to index](#terminology-index)

## L

### Local Project Configuration

**Category:** [Workflow delivery](#workflow-delivery)

User-local plugin data associating a project with its Product path, Governance path, Governance submodule path, and Discovery Repo parent directory. It is workstation configuration rather than repository-intrinsic provenance; another workstation uses Project Activation. Project Setup saves this configuration when creating a new pair; Project Activation establishes or reuses it for an existing pair.

Sources: [Plugin architecture](planning/handoffs/docs/05-plugin-architecture.md), [Onboarding contract](planning/handoffs/plugin-reference/plugins/shimmy-onboarding/skills/shimmy-onboarding/references/onboarding-contract.md), decisions 17–18, 28–30, 36–37.

[back to index](#terminology-index)

## M

### Materialized Governance

**Category:** [Shared](#shared), [Workflow delivery](#workflow-delivery)

Concrete artifacts generated or derived from Governance for use in a repository or workflow. Examples include generated role-specific `AGENTS.md` instructions and derived checks or other artifacts that express Governance requirements. A Governance submodule supplies versioned source material; it needs no separate generated copy.

Materialization describes how an artifact is produced, not a new authority level or a single ownership policy:

- Generated `AGENTS.md` instructions are created when missing, then owned and maintained by the receiving repository. They remain operational instructions subordinate to Governance and are not silently regenerated by plugin upgrades.
- Other derived artifacts retain traceability to their source requirements. They cannot create or override requirements merely by being generated; checks and their results are ***Conformance Proofs***.

Not all Conformance Proofs are Materialized Governance: an exploratory benchmark or observation may have no Governance source.

Sources: [Plugin architecture](planning/handoffs/docs/05-plugin-architecture.md), [Onboarding contract](planning/handoffs/plugin-reference/plugins/shimmy-onboarding/skills/shimmy-onboarding/references/onboarding-contract.md), decisions 17–18, 28–30, 36–37.

[back to index](#terminology-index)

## P

### Pinned Governance Revision

**Category:** [Shared](#shared)

The exact ***Governance*** commit referenced by a repository's read-only Governance submodule. ***Product*** and each ***Discovery Repo*** choose their pins independently. The committed Git link records the durable pin; a newly initialized, staged link is pending the developer's commit.

For Product, deliberate adoption gives the revision the additional meaning of ***Adopted Governance Revision***. For Discovery Repo, the pin fixes the investigation's Governance baseline and makes no conformance claim. Its pin and ***Governance Reading Scope*** stay fixed from creation; work requiring a different revision or scope uses a ***Successor Discovery Repo***.

Sources: [Governance model](planning/handoffs/docs/02-governance-model.md), [Discovery Repo lifecycle](planning/handoffs/docs/03-discovery-lifecycle.md), decision 16.

### Policy

**Category:** [Governance authority and findings](#governance-authority-and-findings)

A general project rule governing how work or decisions must be carried out. Policies sit below the ***Constitution*** and above ***Specifications*** in the authority hierarchy.

Sources: [Governance model](planning/handoffs/docs/02-governance-model.md), [Promotion and adoption](planning/handoffs/docs/04-promotion-and-adoption.md), [Discovery Report template](planning/handoffs/templates/DISCOVERY-REPORT.md), [Discovery Comparison template](planning/handoffs/templates/DISCOVERY-COMPARISON.md), decisions 5–8, 12, 23, 31–35.

### Product

**Category:** [Shared](#shared)

The releasable implementation maintained in its own repository, with production history and compatibility obligations. Its code provides Conformance Proofs about implementation, not an additional level of ***Governance*** authority.

Sources: [Architecture](planning/handoffs/docs/01-architecture.md), [Governance model](planning/handoffs/docs/02-governance-model.md), decisions 1, 15–17.

### Product Access Mode

**Category:** [Discovery lifecycle](#discovery-lifecycle)

The developer-selected boundary on ***Product*** implementation exposure: Isolated, Contract-aware, or Full-reference. It applies across local files, Git, web access, connected tools, previous Discovery Repos, and other agents.

Sources: [Discovery Repo lifecycle](planning/handoffs/docs/03-discovery-lifecycle.md), [Security and isolation](planning/handoffs/docs/08-security-and-isolation.md), [Discovery Manifest schema](planning/handoffs/schemas/discovery-manifest.schema.json), [Reading scope template](planning/handoffs/templates/GOVERNANCE-READING-SCOPE.yaml), decisions 2, 4, 9–14, 16, 19–22, 25–26.

### Product Impact Assessment

**Category:** [Governance authority and findings](#governance-authority-and-findings)

The required assessment accompanying an accepted ***Governance Proposal*** that identifies consequences for ***Product***. Its categories are none, documentation, conformance/tests, implementation, migration/compatibility, and unknown requiring investigation.

Sources: [Governance model](planning/handoffs/docs/02-governance-model.md), [Promotion and adoption](planning/handoffs/docs/04-promotion-and-adoption.md), [Discovery Report template](planning/handoffs/templates/DISCOVERY-REPORT.md), [Discovery Comparison template](planning/handoffs/templates/DISCOVERY-COMPARISON.md), decisions 5–8, 12, 23, 31–35.

### Project Activation

**Category:** [Workflow delivery](#workflow-delivery)

The activity connecting an existing ***Product***/***Governance*** repository pair for use on a workstation. It confirms repository identity, local paths and the existing submodule relationship, and establishes or reuses ***Local Project Configuration***. It creates no replacement repositories and performs no ***Governance Adoption***. Activating an existing pair on another workstation does not repeat its initial creation. Relevant existing-file and Git permissions remain governed by the workflow contract.

Sources: [Plugin architecture](planning/handoffs/docs/05-plugin-architecture.md), [Activation workflow](planning/handoffs/plugin-reference/plugins/governed-exploratory-development/skills/governed-development/references/workflows/project-activation.md), decision 28.

### Project Setup

**Category:** [Workflow delivery](#workflow-delivery)

The initial creation of a ***Governance*** repository and a ***Product*** repository, including their submodule relationship and ***Local Project Configuration***. Product initially pins Governance's first commit. Setup creates no Discovery Repo automatically. Connecting an already-existing pair is ***Project Activation***; later changes to Product's Governance pin belong to ***Governance Adoption***.

Sources: [Plugin architecture](planning/handoffs/docs/05-plugin-architecture.md), [Setup workflow](planning/handoffs/plugin-reference/plugins/governed-exploratory-development/skills/governed-development/references/workflows/project-setup.md), decisions 17–18, 28–30, 36–37.

[back to index](#terminology-index)

## S

### Shimmy Onboarding

**Category:** [Workflow delivery](#workflow-delivery)

The separate sibling plugin capability that locates and invokes a verified, ***Product***-owned Shimmy bootstrap contract with appropriate authorization. It owns delegation and validation, not the bootstrap implementation.

Sources: [Plugin architecture](planning/handoffs/docs/05-plugin-architecture.md), [Onboarding contract](planning/handoffs/plugin-reference/plugins/shimmy-onboarding/skills/shimmy-onboarding/references/onboarding-contract.md), decisions 17–18, 28–30, 36–37.

### Specification

**Category:** [Governance authority and findings](#governance-authority-and-findings)

A statement of required project behavior or properties. Specifications sit below ***Policies*** and above ***Active ADRs*** in the authority hierarchy.

Sources: [Governance model](planning/handoffs/docs/02-governance-model.md), [Promotion and adoption](planning/handoffs/docs/04-promotion-and-adoption.md), [Discovery Report template](planning/handoffs/templates/DISCOVERY-REPORT.md), [Discovery Comparison template](planning/handoffs/templates/DISCOVERY-COMPARISON.md), decisions 5–8, 12, 23, 31–35.

### Successor Discovery Repo

**Category:** [Discovery lifecycle](#discovery-lifecycle)

A new ***Discovery Repo*** continuing a predecessor under a different ***Pinned Governance Revision*** or ***Governance Reading Scope***. A scope-only successor can use the same Governance commit. Its manifest records the predecessor's ID in `derived_from` and a reason; it has its own approved Charter and Governance context. The predecessor's pin and reading scope remain unchanged. Relevant prior exposure is preserved; a new repository does not erase information already acquired.

_Avoid_: Advancing the predecessor’s pin, new branch of the predecessor, Comparison Target as a synonym for predecessor.

Sources: [Discovery Repo lifecycle](planning/handoffs/docs/03-discovery-lifecycle.md), [Security and isolation](planning/handoffs/docs/08-security-and-isolation.md), [Discovery Manifest schema](planning/handoffs/schemas/discovery-manifest.schema.json), [Reading scope template](planning/handoffs/templates/GOVERNANCE-READING-SCOPE.yaml), decisions 2, 4, 9–14, 16, 19–22, 25–26.

### Supersession

**Category:** [Governance authority and findings](#governance-authority-and-findings)

An explicit relationship in which a normative artifact replaces a predecessor at the same authority level. It cannot make a lower-level artifact override a higher-level one. Duplicate IDs, missing targets, self-links, cycles, and cross-level replacements require resolution rather than an inferred winner. Competing replacements require an explicit relationship establishing which applies or a later same-level artifact superseding both. These checks occur during source preparation and do not authorize rewriting the source.

Sources: [Governance model](planning/handoffs/docs/02-governance-model.md), [Promotion and adoption](planning/handoffs/docs/04-promotion-and-adoption.md), [Discovery Report template](planning/handoffs/templates/DISCOVERY-REPORT.md), [Discovery Comparison template](planning/handoffs/templates/DISCOVERY-COMPARISON.md), decisions 5–8, 12, 23, 31–35.

[back to index](#terminology-index)

## Responsibility and ownership boundaries

| Boundary | Owns | Relationship to the other boundaries |
|---|---|---|
| Governance repository | Normative artifacts, Conformance Proofs, durable Discovery Reports and Discovery Comparisons, proposals | Governs Product and Discovery Repo; classifies Conformance Proofs separately from authority |
| Product repository | Releasable code, production history, compatibility, tests, delivery, Product-specific bootstrap logic | Consumes Governance through a pinned, read-only submodule; reviews Discovery Repo code for promotion |
| Discovery Repo | One Discovery Repo, its charter, Discovery Repo code, and fixed Governance submodule pin | Produces Conformance Proofs under explicit Governance Reading Scope and Product-access choices |
| This marketplace repository | Reusable plugins, skills, workflow references, templates, schemas, and helpers | Operates workflows across project repositories; supplies neither project authority nor Product implementation |

Governance, Product, and each Discovery Repo are separate Git repositories. A Discovery Repo is not a Product branch or worktree. These are target roles in projects using the workflows, not directories to create inside this repository.

Sources: [Architecture](planning/handoffs/docs/01-architecture.md), [Plugin architecture](planning/handoffs/docs/05-plugin-architecture.md), [Repository layouts](planning/handoffs/reference-layouts/beeline-technologies.md).
