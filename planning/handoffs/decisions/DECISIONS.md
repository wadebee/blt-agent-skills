# Settled Design Decisions

All decisions below are **accepted**. Complexity is the estimated implementation/conceptual cost on a 1–5 scale, where 1 is simplest.

## 1. Governance Corpus with narrow Constitution — 2/5

Use a broad Governance Corpus containing a small, highest-authority Constitution plus policies, specifications, ADRs, conformance artifacts, and supporting records. This avoids treating every artifact as equally foundational while retaining the user’s umbrella concept of project governance.

## 2. Discovery Governance scope is a required choice — 3/5

At creation, present **Full Governance Corpus** and **Curated Discovery Context**, explain each briefly, and provide a context-sensitive recommendation. The developer must choose explicitly; no automatic default.

## 3. Generated Governance snapshot in Discovery — 2/5

Copy the chosen, version-pinned Governance material into `.governance/` with provenance. A checked-out experiment must be self-contained and reveal exactly what governed it.

## 4. Immutable snapshot with successor repository — 2/5

Do not refresh Governance inside an active Discovery. If Governance changes materially, create a new successor repository referencing the predecessor and reason. This preserves causality and reproducibility.

## 5. Separate knowledge and code promotion — 2/5

Treat lessons entering Governance and code entering Product as independent decisions. Experimental code may be rejected while its findings are accepted, or vice versa.

## 6. Agent proposal with mandatory human approval — 2/5

Agents may synthesize structured Governance proposals, but humans accept, modify, or reject them. Discovery creates evidence; people decide when evidence becomes project law.

## 7. Fixed authority hierarchy plus same-level supersession — 2/5

Use Constitution > Policies > Specifications > Active ADRs. Lower levels cannot override higher ones. Same-level artifacts may explicitly supersede predecessors; unresolved conflicts are surfaced.

## 8. Conformance is derived evidence — 2/5

Tests and conformance artifacts prove or challenge Governance but do not silently create authority. A requirement/test conflict is a Governance inconsistency, not an automatic test victory.

## 9. Developer-selected experiment framing — 3/5

Present Neutral, Divergent, Adversarial, and Custom framing with concise descriptions and a recommendation. Explicit selection prevents hidden optimization assumptions and helps create genuinely different candidates.

## 10. Developer-selected Product access — 3/5

Present Isolated, Contract-aware, and Full-reference with a recommendation. This lets clean-room experiments and integration-aware PoCs coexist without pretending they are equivalent.

## 11. Durable record before selectable closeout disposition — 3/5

Every closeout first generates and surfaces a durable record. Then present Archive, Record + Delete, and Keep Active with a recommendation. Knowledge preservation is mandatory; repo retention is contextual.

## 12. Discovery records live in Governance — 1/5

Store durable `DISC-*` and `SYNTH-*` records under `governance/discoveries/` as explicitly non-normative evidence. This keeps institutional memory searchable even when experiment repos are removed.

## 13. Truly minimal Discovery scaffold — 1/5

Create only `AGENTS.md`, `DISCOVERY.yaml`, and `.governance/`. Language, build, dependency, test, and directory choices remain part of the experiment rather than preloaded bias.

## 14. Compact structured `DISCOVERY.yaml` — 2/5

Record identity, Governance source/context mode, framing/objective, Product access, predecessor, charter, comparison, workflow version, and status. Do not require broad model/tool telemetry by default.

## 15. Governance-first; Product code as evidence — 2/5

Existing Product patterns are important implementation evidence but are not normative authority. Preserve them when compatible with Governance; surface suspected architectural sediment instead of propagating it silently.

## 16. Product consumes Governance via pinned Git submodule — 2/5

Use a read-only submodule at an exact Governance commit. Updates are explicit Product changes, and release provenance is native to Git.

## 17. Independent `Beeline-Technologies` plugin marketplace — 3/5

Agent Skills, templates, scripts, schemas, and workflow automation live in a Shimmy-independent marketplace repo. Governed exploration is one cohesive plugin; unrelated capabilities are sibling plugins. Shimmy bootstrap remains Product-owned, with a separate onboarding skill delegating to it.

## 18. Seed-and-transfer `AGENTS.md` ownership — 1/5

The plugin generates each role-specific `AGENTS.md` once. The repository owns it afterward; the plugin never silently regenerates or synchronizes existing files.

## 19. Policy plus workflow guardrails for isolation — 2/5

Record access mode and enforce obvious constraints across all transports. Do not claim a hard sandbox; prevent accidental leakage and make violations visible.

## 20. Curated context via decision-by-decision interview — 3/5

For each candidate Governance artifact or constraint, explain relevance and concise pros/cons of carrying it forward, recommend include/exclude, and require explicit developer approval.

## 21. Required compact experiment charter — 2/5

Clarify the question and propose success criteria and non-goals through an interview. The developer approves the charter before code generation begins.

## 22. Optional comparison target — 2/5

A Discovery may compare against Product, another Discovery, a prior record, a baseline metric, or nothing. When useful, suggest dimensions and record the approved comparison.

## 23. Optional, recommended synthesis — 2/5

Detect related Discoveries and recommend synthesis when evidence warrants it. The developer chooses; accepted synthesis creates a non-normative `SYNTH-*` record.

## 24. Code promotion interview — 2/5

Recommend Transplant, Adapt, or Reimplement based on production quality, dependencies, conventions, security, portability, integration risk, and experimental shortcuts. The developer decides.

## 25. Small fixed experiment taxonomy — 2/5

Use Architecture Candidate, Spike, Prototype/PoC, Benchmark, Compatibility Experiment, Adversarial Investigation, or Other. The type aids routing/search but does not override the charter.

## 26. Sequential ID plus descriptive slug — 2/5

Use immutable IDs such as `DISC-0042` and readable names such as `shimmy-disc-0042-shared-engine`. The ID connects all records and successor/comparison relationships.

## 27. Local Git creation only — 1/5

Version 1 initializes local repos but leaves GitHub or other hosting to the developer. This avoids provider coupling and destructive remote operations.

## 28. One-time project onboarding interview — 2/5

Confirm project name, Product path, Governance path, and submodule path. The plugin may infer likely values but never assumes them silently.

## 29. User-local project registration — 2/5

Store workstation paths in plugin-local data, not committed repositories. Another machine repeats onboarding; repositories retain only intrinsic state.

## 30. Skills never create Git commits — 1/5

Skills may edit, validate, show diffs, and suggest messages. Developers retain staging, signing, hooks, branch, and commit control.

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

Expose one governed-development skill. Hide onboarding, creation, closeout, synthesis, proposal, promotion, and adoption mechanics behind AI intent routing and concise interviews. Additional internal complexity is justified by much lower user cognitive load.
