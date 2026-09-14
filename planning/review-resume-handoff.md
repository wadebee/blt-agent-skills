# Resume the governed exploratory development plan review

Prepared: 2026-09-14, America/New_York.
Repository baseline: `bb67b2d5b0c007f02ecaae618002e1340bfa9fc5`.
State: **PLAN / REVIEW. No implementation chunk is authorized or active.**

This is a context handoff, not another implementation plan or a replacement for
the [authoritative plan](notional/governed-exploratory-development.md). It preserves
the unfinished consistency review after the completed domain-modeling tangent.
Recommendations below are proposals, not newly accepted implementation decisions.

## Start the next context with this request

> Resume the plan consistency review using `planning/review-resume-handoff.md`.
> Read current repository guidance, the canonical glossary, terminology notes,
> and the authoritative plan. Recheck drift from the handoff's recorded HEAD.
> Continue resolving the remaining review findings so future implementation
> chunks are decision-complete and easy to resume. Preserve the completed
> terminology decisions and distinguish documentation claims from execution
> authorization. Do not start implementation, install dependencies, move the
> plan into `wip`, or create commits, remotes, pushes, or hosted repositories.

## User intent and authorization boundary

The original task invoked `plan-review-act` to review the persisted plan for
internal consistency and alignment with the resources needed to implement it.
The aim was to disambiguate future chunk implementations. The last response
reported ten groups of findings; it did not edit the plan or obtain approval to
implement those recommendations.

The user then completed a separate `domain-modeling` tangent and requested this
handoff, including a code sync to account for intervening changes. In this turn,
code sync means inspecting local history, current files, and working-tree drift
and reconciling the review findings. No fetch, pull, merge, reset, or commit was
performed. Only this handoff was added; the plan and source material were not
changed by this handoff task.

The plan records selection of Mike Farah's `yq` and santhosh-tekuri/jsonschema's
`jv`, a prohibition on a production Python dependency, a simplicity goal, and a
previously approved narrow disposable-fixture commit exception. Preserve these
recorded choices; they do not authorize starting a chunk or installing tools.
The mismatch between the fixture exception and the unconditional Git rule in
root guidance remains a review item. Do not treat historical authorization prose
inside a document as a new instruction to execute it.

Use the existing `plan-review-act` workflow for the resumed review. Apply
`domain-modeling` when working with terminology, but do not reopen the completed
vocabulary merely because an older review used different words. Explicit user
instructions and applicable repository guidance govern any later edits.

## Read in this order

1. [AGENTS.md](../AGENTS.md).
2. [GLOSSARY.md](../GLOSSARY.md), including relationships and boundary scenarios.
3. [Terminology source and implementation notes](terminology-notes.md).
4. [The authoritative plan](notional/governed-exploratory-development.md),
   especially status, proposed decisions, inconsistencies, Unresolved, chunks,
   and Session bootstrap.
5. The six required handoff documents, in their prescribed order:
   [implementation brief](handoffs/codex/IMPLEMENTATION-BRIEF.md),
   [architecture](handoffs/docs/01-architecture.md),
   [settled decisions](handoffs/decisions/DECISIONS.md),
   [plugin architecture](handoffs/docs/05-plugin-architecture.md),
   [implementation phases](handoffs/codex/IMPLEMENTATION-PHASES.md),
   [acceptance matrix](handoffs/codex/ACCEPTANCE-TEST-MATRIX.md).
6. Current schemas, templates, and workflow references relevant to each finding.

The glossary controls terminology and explicitly defined relationships. For
other design decisions, the handoff order is decisions, architecture/governance
docs, workflows, schemas/templates, then reference skeletons. Root guidance now
correctly names `planning/handoffs/`. That directory is read-only outside
explicitly authorized documentation maintenance; do not alter it to make an
implementation or test pass.

No `CONTEXT.md` or `CONTEXT-MAP.md` existed at this baseline. The only lifecycle
plan is in `planning/notional/`; `planning/wip/` and `planning/complete/` do not
yet exist. This handoff does not change that lifecycle state.

## Local sync baseline and scope

The prior review saw HEAD `6d83328` and an untracked persisted plan. Current HEAD
contains these intervening commits, made outside this handoff turn:

| Commit | Change |
|---|---|
| `bc59b62` | Added indexed glossary and linked usage domains. |
| `ab1fbef` | Recorded the governed development implementation plan. |
| `6991309` | Aligned glossary and handoff terminology. |
| `bb67b2d` | Clarified terminology and adopted Discovery Repo. |

The working tree was clean when this handoff task began. The sync compared
handoff/repository changes against `6d83328` and plan changes against `ab1fbef`,
the first committed plan snapshot. The earlier untracked plan is not available
as a Git baseline; do not claim a byte-exact Git comparison against it.

There are still **no production plugins, scripts, or tests**. Files beneath
`planning/handoffs/plugin-reference/` are reference packages, not installed or
operational production plugins. Before adding this handoff, the tree contained
56 files outside `.git`; six were JSON and three were YAML. Most changes are
documentation and reference-format changes, not runtime code changes.

On resumption, use read-only diagnostics such as:

```sh
git status --short
git log -6 --oneline
git diff --stat bb67b2d..HEAD
git diff bb67b2d..HEAD -- AGENTS.md GLOSSARY.md planning
git diff -- planning
git diff --cached -- planning
```

Inspect new untracked files separately; ordinary `git diff` does not show their
contents. Do not discard later work to return to this baseline.

## Completed domain decisions to retain

- **Discovery Repo** is the separate exploratory Git repository. A **Discovery
  Report** is the written output for one repo, shares its `DISC-*` ID, and lives
  under Governance's `discoveries/` directory.
- **Discovery Comparison** is a separate optional written output across related
  Discovery Repos, with a `CMPR-*` ID. Comparison dimensions or a comparison
  section inside an individual report are not this separate document.
- **Discovery Review** generates and surfaces the report, then records
  **Discovery Disposition**. Disposition includes independent Discovery
  Governance Promotion, Discovery Code Promotion, and retention choices.
  Retention is Archive, Report + Delete, or Keep Active. Promotions do not imply
  each other, retention, Governance Adoption, or closed status. Keep Active
  preserves `active`.
- **Finding** states what was learned. **Conformance Proofs** are supporting
  material, including failures, negative results, and observations unrelated to
  requirements. The word Proofs does not imply certainty, success, or authority.
- **Governance Artifacts** is the collection selected as Full or Curated. Full
  includes all material at the selected commit; curation always includes the
  Constitution. Selection does not override Product Access Mode.
- **Materialized Governance** includes snapshots, generated instructions, and
  other Governance-derived artifacts. It introduces no authority level or common
  update policy: snapshots stay immutable; generated instructions become
  repository-owned; derived checks remain Conformance Proofs.
- **Project Setup** produces **Local Project Configuration**. **Shimmy
  Onboarding** retains its separate name and delegates to Product-owned bootstrap.
- Glossary categories describe usage and responsibilities, not proposed code
  modules. The four normative authority levels remain unchanged.

These are pre-production reference changes. Schema versions remain `1.0` because
no production format has shipped. Do not add migration work for nonexistent
deployed data or propose rewriting future immutable snapshots for terminology.

## Current file and format map

Workflow filenames below are relative to
`planning/handoffs/plugin-reference/plugins/governed-exploratory-development/skills/governed-development/references/workflows/`.
Use the same new names in the plan's proposed production workflow paths.

| Earlier name | Current name |
|---|---|
| `project-onboard.md` | `project-setup.md` |
| `discovery-create.md` | `discovery-repo-create.md` |
| `discovery-successor.md` | `discovery-repo-successor.md` |
| `discovery-closeout.md` | `discovery-review.md` |
| `discovery-synthesize.md` | `discovery-compare.md` |
| `governance-propose.md` | `discovery-governance-promote.md` |
| `product-promote.md` | `discovery-code-promote.md` |

`governance-resolve.md` and `governance-adopt.md` retain their names.

Other reference paths, relative to `planning/handoffs/`:

| Earlier path | Current path |
|---|---|
| `schemas/discovery.schema.json` | `schemas/discovery-manifest.schema.json` |
| `schemas/project-registration.schema.json` | `schemas/local-project-configuration.schema.json` |
| `templates/PROJECT-REGISTRATION.yaml` | `templates/LOCAL-PROJECT-CONFIGURATION.yaml` |
| `templates/DISCOVERY-RECORD.md` | `templates/DISCOVERY-REPORT.md` |
| `templates/SYNTHESIS-RECORD.md` | `templates/DISCOVERY-COMPARISON.md` |
| `templates/agents/discovery/AGENTS.md` | `templates/agents/discovery-repo/AGENTS.md` |

| Field, value, or planned output | Current contract |
|---|---|
| Manifest `experiment` object | `discovery_repo` |
| Manifest `governance.context_mode` | `governance.artifacts_selection` |
| Snapshot `mode` | `artifacts_selection` |
| Local `discovery_parent_path` | `discovery_repo_parent_path` |
| Framing values | `neutral`, `optimize-quality`, `challenge-assumptions`, `custom` |
| Renamed type value | `compatibility-check` |
| Renamed comparison target values | `discovery-repo`, `discovery-report` |
| Comparison ID prefix | `CMPR-*`, replacing `SYNTH-*` |
| Planned copied snapshot content | `.governance/artifacts/`, replacing `.governance/corpus/` |
| Planned helper/test identifiers | `project_setup`, `local_project_configuration`, `discovery_repo` |

Public identifiers remain `governed-exploratory-development`,
`governed-development`, and `shimmy-onboarding`. `DISCOVERY.yaml` and
`GOVERNANCE-SNAPSHOT.yaml` retain their filenames.

## Reconciled findings from the previous review

The numbering preserves the ten groups in the previous user-facing review.
These are remaining review tasks, not instructions to implement now.

1. **Source-wide supersession — open; Chunk 2.** Resolve active/historical status
   against the complete selected Governance commit before curation. Excluding a
   superseder must not reactivate its predecessor. Define treatment of cycles,
   missing targets, cross-level references, duplicate IDs, and competing
   successors; preserve the resolved classification in the snapshot.

2. **Selection coverage — partly clarified; Chunk 2.** Full now explicitly means
   all material at the selected commit. Do not reopen that as a choice between
   all files and only designated normative directories. Remaining work is exact
   file enumeration/classification, unknown/supporting files, committed
   reservation metadata, unsupported entries, Constitution detection, and a
   complete curated candidate/decision record. Reject or surface incompatible
   content/access choices rather than silently filtering a purported Full copy.

3. **Production schema adaptations — open; Chunk 1.** The current
   [Discovery Manifest schema](handoffs/schemas/discovery-manifest.schema.json)
   still permits `2026-02-30` through its shape-only date regex. Add an asserted
   calendar-date format in the proposed production contract. The glossary's
   Discovery Charter objective still lacks a separate representation from
   `discovery_repo.framing.objective`. Define cross-document agreement for ID,
   source identity/commit, artifact selection, paths, workflow identity/version,
   and bidirectional predecessor/reason pairing before schema/template work.

4. **Data pipeline and canonical bytes — open; Chunk 1, consumed by Chunk 2.**
   Specify duplicate-key rejection on original YAML before conversion, exactly
   one document, treatment of anchors/merge keys/custom tags/non-string keys,
   and offline schema resolution. Define encoding, object/array ordering,
   whitespace, terminal newline, numeric/mode representation, and exact hash
   coverage. Do not assume ordinary `yq` parsing rejects duplicate keys or that
   sorted paths alone define canonical JSON. Self-contained schemas with only
   internal references are a proposed simple offline approach, not an accepted
   new restriction. Keep tool behavior canaries early; do not silently add tools.

5. **Persisted interview approval binding — open; Chunk 2.** Bind choices to the
   project, exact source revision, relevant inputs, and destination. Define which
   downstream choices must be revisited when source commit, access mode, exports,
   or destination changes. Test resumed/amended interviews without re-asking
   still-applicable explicit choices.

6. **Topology, identity, and pending adoption — open; Chunks 2 and 4.** Specify
   stable credential-free Governance identity and its confirmation for local-only
   repos. Decide whether the registered writable Governance checkout must be
   separate from Product's read-only submodule checkout. Define the expected
   checkout-versus-index/committed-gitlink mismatch after unstaged adoption and
   how later Project Setup and repo creation handle it. Preserve dirty files and
   Product's index/HEAD; test adoption followed by another router operation.

7. **ID occupancy and later namespaces — open; Chunks 2–4.** Account for existing
   `discoveries/DISC-*.md` reports without reservation files and consumed failed
   reservations before assigning a new ID. Define independent `CMPR-*` and
   `GOVP-*` allocation, storage, and collision/retry rules, including pending and
   resolved proposals. Reports reuse their repo's DISC ID. Reservation files
   must not contain workstation paths. Local concurrency is not cross-clone
   coordination. Reconcile allocation order too: the current creation workflow
   reserves before its interview, while the plan validates approved inputs before
   reservation. The latter is the proposed plan behavior; do not silently follow
   the conflicting reference order.

8. **Lifecycle transitions — partly resolved; Chunks 3–4.** Keep Active retaining
   active status and independent promotion/retention decisions are now settled.
   Repeat-review report update/versioning, preservation of human edits, retry,
   cancellation, and interrupted report finalization remain unresolved. Define
   how Modify proposal becomes accepted/rejected metadata; the earlier
   recommendation was review of the revised proposal followed by acceptance,
   with rationale preserved. Specify that Chunk 3 records selected/declined/
   deferred promotion intentions; it cannot execute Chunk 4's unavailable
   handlers or claim promotion completed.

9. **Discovery Code Promotion context — open; Chunk 4.** The current
   [Discovery Repo instructions](handoffs/templates/agents/discovery-repo/AGENTS.md)
   still restrict Product inspection in Isolated mode and Product writes from
   Discovery Repo context. Define a Product-context handoff for promotion,
   preserving the originating repo's access/provenance and avoiding feedback of
   Product-derived knowledge into an ongoing isolated investigation.

10. **Guidance and verification gates — partly resolved.** The stale handoff path
    is fixed. Root `AGENTS.md` still prohibits commits unconditionally while the
    plan/glossary record a fixture exception; the prerequisite fixture-only
    staging/gitlink setup also needs an explicit boundary. Reconcile this before
    fixture execution without expanding it to real repos or production workflows.
    Avoid fixture recipes that create remotes unintentionally. Basic packaged
    installation/namespacing is still deferred until Chunk 6; the earlier review
    recommended a smoke test by the first usable increment, leaving broader
    installation hardening in Chunk 6.

Do not report these repaired source defects as still open: missing handoff path,
inherited-scaffold wording, Product implementation as a fifth authority level,
`resolution: pending` in the proposal template, or the extra mandatory report
approval gate before recording disposition.

## Additional drift and current review housekeeping

- **Stale rollback action:** plan line 314 says preserve the already-corrected
  `AGENTS.md`; line 350 still describes rolling back a Chunk 1 edit to it. Remove
  that obsolete action when revising the plan. Never undo the authorized glossary
  guidance. The Initial lesson at line 632 also needs to label path drift as
  historical/resolved.
- **Shimmy test name mismatch:** plan line 542 creates
  `tests/test_shimmy_project_setup.sh`; line 562 runs group `shimmy_onboarding`.
  The proposed correction is `tests/test_shimmy_onboarding.sh`, keeping the
  canonical Shimmy capability distinct from Project Setup.
- **Readiness claim:** the plan's `## Unresolved` still says none for the first
  increment. It does not incorporate the earlier consistency findings. Replace
  that claim with explicit decisions, owners/chunks, recommendations, and status
  during the resumed plan review. Later chunks are not yet decision-complete.
- **Session bootstrap:** update the plan's bootstrap to name `GLOSSARY.md` and
  `planning/terminology-notes.md` explicitly. The source order now includes
  glossary-defined relationships, not just renamed labels.
- **Marketplace identity:** terminology notes explicitly preserve
  `Beeline-Technologies` in manifest provenance, `beeline-technologies` as catalog
  name, and `Beeline Technologies` as display name. Define their identity/mapping
  contract before enforcing equality; do not silently normalize settled labels.
- **Shimmy prerequisite:** the exact intended Product source/release and bootstrap
  contract still must be established before Chunk 5. The earlier review located
  `../shimmy/BOOTSTRAP.md` and `../shimmy/bootstrap.sh`; a separate `../shimmy2/`
  checkout then described an unimplemented Product. These are discovery leads,
  not a selection of the intended Product or permission to run bootstrap. Recheck
  current Product sources when this prerequisite becomes relevant.

Line numbers above refer to HEAD `bb67b2d`; use section names after later edits.

## Acceptance coverage and validation limits

The matrix now contains **AT-001–029**, not 25 cases. New cases are:

| Case | Required behavior |
|---|---|
| AT-026 | Record both promotion choices and independent Archive retention. |
| AT-027 | Keep Active retains the report and active manifest status. |
| AT-028 | Preserve failed or non-requirement observations as Conformance Proofs without overclaiming. |
| AT-029 | Preserve the distinct authority/update rules of snapshots, generated instructions, and derived checks. |

The current plan assigns AT-026–029 to Chunk 3 and requires all 29 at final
hardening. AT-026 records decisions; it does not require executing both
promotions before Chunk 4. The new cases are specified, not executed tests.

Fresh checks during this handoff preparation:

- `git status --short`: clean before creating this handoff.
- `git log`, `git diff --find-renames --stat 6d83328..HEAD`, and targeted plan
  diffs from `ab1fbef`: inspected the intervening changes.
- `git diff --check` and the baseline-to-HEAD whitespace check: passed.
- Read-only inline Ruby using its JSON/YAML libraries: all six JSON files and
  three YAML files parsed. The current date regex accepts `2026-02-30`; the
  current version regex correctly accepts `0.1.0`. The earlier suspected version
  regex defect was a serialization-reading false alarm and remains withdrawn.
- `command -v` found Git, Bash, and Codex, but not `yq` or `jv`. Do not mistake
  syntax checks for full JSON Schema validation or executed tool canaries.
- Repository inventory confirmed no production implementation or test suite.
- After adding this handoff, a read-only inline Ruby audit resolved all 275 local
  Markdown links and anchors. The new file's
  `git diff --no-index --check /dev/null planning/review-resume-handoff.md` check
  passed. Final working-tree changes consisted only of this new handoff; HEAD
  remained `bb67b2d5b0c007f02ecaae618002e1340bfa9fc5`.

The terminology notes retain their own earlier audit commands/results, including
link and YAML/frontmatter checks. They did not run full schema validation,
installed-plugin checks, or runtime acceptance tests. Their temporary Python/Ruby
diagnostics do not establish a production runtime dependency.

The preceding consistency review checked official
[portable plugin packaging](https://developers.openai.com/plugins/build/plugins)
and the [app-server skills API](https://learn.chatgpt.com/docs/app-server#skills).
Root portable manifests and standalone `skills/list` checks were supported.
Standalone parsing does not prove packaged installation. The
[`jv` documentation](https://github.com/santhosh-tekuri/jsonschema) supports
explicit format assertions; ordinary Draft 2020-12 validation alone is not that
assertion. These external checks belong to the earlier review, not a fresh
installation test in this handoff turn. Revalidate unstable tooling requirements
before relying on them for implementation.

## Next review step and stopping point

Resume with the current source inventory above, not the pre-tangent names.
First clear the small stale plan details, then resolve the contracts needed by
Chunks 1–2: schemas/data pipeline, selection/authority, identity/topology, approval
binding, ID occupancy, and validation gates. Record remaining Chunk 3–5 decisions
as explicit prerequisites rather than hiding them behind `Unresolved: None`.

Keep one authoritative implementation plan. If the resumed user request
authorizes plan revisions, incorporate accepted decisions there and preserve
unresolved choices for review; do not create a competing plan. Do not edit the
glossary or protected handoff simply to settle implementation details. Distinguish
settled domain relationships, proposed runtime mechanisms, and executed checks.

The next checkpoint is a reviewed, updated assessment/plan with remaining
material choices surfaced. It is **not** permission to execute Chunk 1. Only an
explicit subsequent implementation instruction activates a chunk and the plan's
`notional` → `wip` lifecycle transition.
