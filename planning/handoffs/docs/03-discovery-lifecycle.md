# Discovery Lifecycle

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
Experiment
   │
   ▼
Closeout record is generated and surfaced
   │
   ├── optional Governance proposal
   ├── optional code-promotion review
   ├── optional related-experiment synthesis
   └── developer disposition: Archive / Record + Delete / Keep Active
```

## Required creation interview

The public router should infer that the user intends to create a Discovery and then conduct one concise decision at a time.

### 1. Governance context

Required choice:

- **Full Governance Corpus**
- **Curated Discovery Context**

The router provides a context-sensitive recommendation but does not select automatically.

### 2. Experiment type

Small fixed taxonomy:

- Architecture Candidate
- Spike
- Prototype / PoC
- Benchmark
- Compatibility Experiment
- Adversarial Investigation
- Other

The router recommends a type. The type is descriptive metadata; the charter remains authoritative.

### 3. Framing

Required choice:

- **Neutral** — no imposed optimization bias.
- **Divergent** — optimize for an explicit quality such as simplicity, security, performance, portability, or operability.
- **Adversarial** — challenge assumptions and seek failure modes or materially different designs.
- **Custom** — developer-defined architectural lens.

The router recommends a framing based on whether the experiment is a baseline, one of several candidates, or a challenge to a settled design.

### 4. Product access

Required choice:

- **Isolated** — no Product implementation access through any transport.
- **Contract-aware** — only explicitly exported public interfaces, schemas, formats, compatibility constraints, and extension contracts.
- **Full-reference** — Product implementation and history may be inspected, while work remains in a separate Discovery repo.

The access rule applies equally to Git, GitHub, web search, local files, previous Discovery repositories, other agents, and connected tools.

### 5. Experiment charter

The router interviews the developer to clarify:

- objective;
- research question;
- suggested success criteria;
- suggested non-goals.

The agent proposes concrete criteria and non-goals; the developer reviews and approves them.

### 6. Optional comparison target

Possible targets:

- current Product implementation;
- another Discovery repository;
- a durable Discovery Record;
- a quantitative baseline;
- none.

When a target exists, the router proposes comparison dimensions.

## Identity and naming

Allocate an immutable sequential ID from Governance, for example `DISC-0042`, and combine it with a descriptive slug:

```text
shimmy-disc-0042-shared-engine
```

The ID links the repository, manifest, durable record, synthesis records, comparison references, and successor chain.

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
- A status field may transition from `active` to `closed`; closeout findings belong in the durable Discovery Record, not in the original charter.
- A material Governance update creates a successor repository with `derived_from: DISC-xxxx` and a reason.

## Closeout

Closeout is two-stage.

### Stage 1: durable record

Create and surface `governance/discoveries/DISC-xxxx.md` containing:

- identity and repository name;
- Governance source and context mode;
- framing and Product-access mode;
- charter;
- result against success criteria;
- findings and evidence;
- rejected approaches and limitations;
- proposed Governance implications;
- knowledge-promotion decision;
- code-promotion decision;
- provenance and links.

The record is non-normative.

### Stage 2: disposition

Present with a recommendation:

- **Archive** — preserve implementation and history read-only.
- **Record + Delete** — preserve durable evidence, then allow the local/remote repo to be removed manually.
- **Keep Active** — experiment is incomplete or expected to continue.

The plugin does not delete a remote repository in version 1.

## Related-experiment synthesis

At closeout, detect related Discovery records by comparison target, predecessor, question, or explicit grouping. Recommend synthesis when experiments address the same question from different lenses or contain conflicting evidence.

If approved, create `governance/discoveries/SYNTH-xxxx.md`. A synthesis is non-normative but may generate Governance proposals subject to human approval.
