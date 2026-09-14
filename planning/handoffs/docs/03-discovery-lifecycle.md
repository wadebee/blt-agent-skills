# Discovery Repo Lifecycle

## Lifecycle overview

```text
Question
   │
   ▼
Creation interview
   │
   ▼
Minimal local Git repo
├── AGENTS.md
├── DISCOVERY.yaml
└── .governance/
   │
   ▼
Discovery Repo
   │
   ▼
Discovery Report is generated and surfaced
   │
   ├── optional Discovery Comparison
   └── independent Discovery Disposition choices
       ├── Discovery Governance Promotion
       ├── Discovery Code Promotion
       └── repository retention: Archive / Report + Delete / Keep Active
```

## Required creation interview

The public router should infer that the user intends to create a Discovery Repo and then conduct one concise decision at a time.

### 1. Governance Artifacts selection

Required choice:

- **Full Governance Artifacts**
- **Curated Governance Artifacts**

The router provides a context-sensitive recommendation but does not select automatically.

### 2. Discovery Type

Small fixed taxonomy:

- Architecture Candidate
- Spike
- Prototype / PoC
- Benchmark
- Compatibility Check
- Adversarial Investigation
- Other

The router recommends a type. The type is descriptive metadata; the charter remains authoritative.

### 3. Framing

Required choice:

- **Neutral** — no imposed optimization bias.
- **Optimize a quality** — optimize for an explicit quality such as simplicity, security, performance, portability, or operability.
- **Challenge assumptions** — challenge assumptions and seek failure modes or materially different designs.
- **Custom** — developer-defined architectural lens.

The router recommends a framing based on whether the Discovery Repo is a baseline, one of several candidates, or a challenge to a settled design.

### 4. Product access

Required choice:

- **Isolated** — no Product implementation access through any transport.
- **Contract-aware** — only explicitly exported public interfaces, schemas, formats, compatibility constraints, and extension contracts.
- **Full-reference** — Product implementation and history may be inspected, while work remains in a separate Discovery Repo.

The access rule applies equally to Git, GitHub, web search, local files, previous Discovery Repos, other agents, and connected tools.

### 5. Discovery Charter

The router interviews the developer to clarify:

- objective;
- research question;
- suggested success criteria;
- suggested non-goals.

The agent proposes concrete criteria and non-goals; the developer reviews and approves them.

### 6. Optional comparison target

Possible targets:

- current Product implementation;
- another Discovery Repo;
- a durable Discovery Report;
- a quantitative baseline;
- none.

When a target exists, the router proposes comparison dimensions.

## Identity and naming

Allocate an immutable sequential ID from Governance, for example `DISC-0042`, and combine it with a descriptive slug:

```text
shimmy-disc-0042-shared-engine
```

The ID links the repository, manifest, durable record, Discovery Comparisons, comparison references, and successor chain.

Version 1 creates the Git repository locally only. Publishing to a remote host is a separate developer action.

## Minimal scaffold

No language, build, dependency, directory, CI, or test scaffold is supplied.

```text
<project>-disc-<id>-<slug>/
├── AGENTS.md
├── DISCOVERY.yaml
└── .governance/
    ├── SNAPSHOT.yaml
    └── <copied selected artifacts>
```

## Immutability

- `.governance/` is immutable.
- The charter and provenance fields in `DISCOVERY.yaml` should be treated as immutable after coding begins.
- A status field may transition from `active` to `closed`; Discovery Review findings belong in the durable Discovery Report, not in the original charter.
- A material Governance update creates a successor repository with `derived_from: DISC-xxxx` and a reason.

## Discovery Review

Discovery Review is two-stage.

### Stage 1: durable record

Create and surface `governance/discoveries/DISC-xxxx.md` containing:

- identity and repository name;
- Governance source and artifacts selection;
- framing and Product-access mode;
- charter;
- result against success criteria;
- findings and Conformance Proofs;
- rejected approaches and limitations;
- proposed Implications;
- Discovery Governance Promotion decision;
- Discovery Code Promotion decision;
- provenance and links.

The record is non-normative.

### Stage 2: Discovery Disposition

Record three independent choices: Discovery Governance Promotion, Discovery Code Promotion, and repository retention. Both promotion types may be selected. Neither promotion requires closing the Discovery Repo or determines retention. Record promotion decisions and rationale in the Discovery Report.

For repository retention, present with a recommendation:

- **Archive** — preserve implementation and history read-only.
- **Report + Delete** — preserve durable Conformance Proofs, then allow the local/remote repo to be removed manually.
- **Keep Active** — Discovery Repo is incomplete or expected to continue.

The plugin does not delete a remote repository in version 1.

## Discovery Comparison

At Discovery Review, detect related Discovery Reports by comparison target, predecessor, question, or explicit grouping. Recommend Discovery Comparison when Discovery Repos address the same question from different lenses or contain conflicting Conformance Proofs.

If approved, create `governance/discoveries/CMPR-xxxx.md`. A Discovery Comparison is non-normative but may generate Governance proposals subject to human approval.
