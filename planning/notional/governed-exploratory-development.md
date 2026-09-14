# Governed exploratory development

## Plan status and authorization

- State: **PLAN — persisted for review; implementation is not authorized.**
- Authoritative plan: `planning/notional/governed-exploratory-development.md`.
- Objective and planning root were confirmed by the user.
- The user confirmed `planning/handoffs/` as the authoritative handoff, replacing the absent `docs/handoffs/governed-exploratory-development/` location named in the original request and root instructions.
- The user authorized creation of this plan only: “do not start implementation until I have reviewed from persisted plan”.
- This document persists the proposed plan presented in chat. Its design choices and implementation chunks remain subject to review; permission to create this file is not approval to execute them.
- No implementation chunk is active. Do not move this plan to `wip`, install dependencies, or modify implementation files until explicitly authorized.
- The latest review prohibits a Python dependency and makes simplicity a standing goal and review metric. Bash is acceptable; any additional tool must address a specific capability and be chosen by the user before it becomes a requirement.
- The user selected Mike Farah’s `yq` for YAML/JSON processing and `jv` from santhosh-tekuri/jsonschema for schema validation. No Python dependency is permitted.
- The user approved commits solely for building disposable test fixtures. This exception does not permit commits in this repository or real project repositories, and does not permit the production workflow to commit.
- These two decisions are approved; implementation and dependency installation remain paused until the user explicitly authorizes starting a chunk.

## Objective

Implement the capability in this repository, preserving separate Governance, Product, and Discovery repositories.

The first increment comprises the handoff’s first two milestones:

1. Marketplace/plugin skeletons and validation infrastructure.
2. Local registration, Product/Governance onboarding, and creation of one valid local Discovery repository.

Retain a human review checkpoint between those milestones. Subsequent lifecycle operations require separate approval.

Success means the single public router can conduct the required interview, honor explicit choices, create the minimal local Discovery, and validate its immutable Governance provenance. Simplicity is a success criterion: minimize setup steps, extra tools, custom mechanisms, and the amount of code needed to maintain the workflow.

Excluded throughout: automatic workflow commits, staging, pushes, remote creation, hosting actions, and duplicated Shimmy bootstrap logic.

## Verified implementation inventory

At the planning baseline, the repository contained only root `AGENTS.md` and the handoff. There was no production code, test suite, runtime configuration, or existing plan. This document is the only subsequently authorized repository addition.

The complete handoff was inspected, including its package README, the six required documents in order, all referenced documentation, schemas, templates, reference layouts, workflow specifications, and open implementation details. Decisions take precedence over lower-level package material.

The following planning checks completed:

| Check | Result |
|---|---|
| Complete handoff inventory and reading | 52 files inspected |
| JSON parsing | All six JSON files passed |
| `git diff --check` | Passed |
| `git status --short` | Clean at the planning baseline |
| Baseline runtime inspection | Python 3.9.6 was available during investigation; this does not establish or authorize a repository dependency. |
| Shell/tool inspection during plan review | Bash 3.2.57, Git 2.50.1, and SHA-256 utilities are available locally. |
| Codex command inspection | No `plugin validate` or `--plugin-dir` command |

These are planning diagnostics, not implementation acceptance tests. This inventory is a verified baseline, not permission to ignore newly discovered dependencies.

## Packaging verification and differences

**Keep the reference portable packaging.** Current official documentation supports root `plugin.json`, `$schema`, and `extensions.com.openai.interface`. A `.codex-plugin/plugin.json` overlay is optional; no layout conversion is needed. [OpenAI packaging documentation](https://developers.openai.com/plugins/build/plugins)

The marketplace location, sibling plugin layout, and `skills/<name>/SKILL.md` structure also match current documentation. Internal workflows can remain supporting references beneath the router. [Build plugins](https://learn.chatgpt.com/docs/build-plugins), [Build skills](https://developers.openai.com/plugins/build/skills)

Two tooling differences affect the plan:

- The installed plugin-creator validator targets the compatibility manifest and cannot validate these portable manifests unchanged. Implement documented portable-format checks instead of changing valid packaging to satisfy that validator.
- `PLUGIN_DATA` is documented for hooks; its presence is not established for ordinary skill-launched scripts. Use it when supplied, with an explicit local-storage fallback. [OpenAI hooks documentation](https://learn.chatgpt.com/docs/hooks)

Standalone skill discovery can be checked through the app-server `skills/list` API using additional skill roots. Packaged installation and namespacing require a separate local installation smoke test. [App-server skills API](https://learn.chatgpt.com/docs/app-server#skills)

The documented standalone check starts `codex app-server --stdio`, completes the `initialize`/`initialized` handshake, and calls `skills/list` with the two production skill roots supplied through `perCwdExtraUserRoots`. It does not install the plugins or prove marketplace loading. No `CODEX_HOME` override is required. This check was not executed during read-only planning.

## Target layout and terminology

All implementation paths below are repository-relative.

Abbreviations:

- `P` = `plugins/governed-exploratory-development`
- `S` = `plugins/governed-exploratory-development/skills/governed-development`
- `H` = `plugins/shimmy-onboarding`

These identify exact path prefixes, not additional directories.

```text
.agents/plugins/marketplace.json
plugins/
  governed-exploratory-development/
    plugin.json
    skills/governed-development/
      SKILL.md
      assets/
        schemas/
        templates/
      references/
        runtime-contract.md
        workflows/
      scripts/
        governed.sh
        lib/
  shimmy-onboarding/
    plugin.json
    skills/shimmy-onboarding/
      SKILL.md
      references/onboarding-contract.md
scripts/
tests/
docs/
planning/
  handoffs/                 # read-only
  notional/
  wip/
  complete/
```

Generated Discovery layout:

```text
<project>-disc-0001-<slug>/
  .git/
  AGENTS.md
  DISCOVERY.yaml
  .governance/
    SNAPSHOT.yaml
    CONTENT-MANIFEST.json
    corpus/<selected Governance paths>
    CONTRACT-EXPORT.yaml    # contract-aware mode only
    contracts/<approved exports>
```

The three non-Git root entries remain exactly those required by Decision 13. Contract exports are explicitly identified as Product-derived evidence; placing them inside the immutable context does not grant them Governance authority.

`discoveries/` means a directory relative to the Governance repository root. No extra nested `governance/` directory will be introduced.

## Capabilities and dependency choices

**No Python dependency.** Remove the earlier Python runtime, package requirements, virtual environment, and Python test-runner proposal. Do not replace them with another general-purpose runtime requirement by default.

Use Bash for straightforward orchestration and tests, Git for repository operations, and existing platform utilities for file operations and hashing. The proposed shell scripts must work with the available Bash 3.2 baseline unless a specific need for a newer version is demonstrated and approved. No external shell test framework is required.

The user approved the following narrow data dependencies:

| Capability | Where needed | Why it is needed | Selection status |
|---|---|---|---|
| Read and write YAML/JSON, including safe string escaping and deterministic output | Governed-development metadata, registration, templates, and packaging checks | The handoff supplies structured manifests, schemas, and Markdown frontmatter. Text matching is not a reliable substitute for parsing them. | Mike Farah’s `yq` — approved |
| Check data against JSON Schema Draft 2020-12, including the required date/format assertions | Governed-development validation and tests | Preserve the supplied validation contract without writing a schema engine in shell. | santhosh-tekuri/jsonschema `jv` — approved |

Use direct, documented calls to these two tools; do not build a configurable provider framework. Scope the requirement to the governed-development operations and checks that need it; unrelated sibling plugins and reading this repository must not inherit it. Approval of the dependency choices does not start implementation or dependency installation.

Selected tools:

- Mike Farah’s `yq` reads/writes YAML and JSON and is distributed as a standalone binary. Use it for structured-data processing; schema validation belongs to `jv`. [Upstream yq documentation](https://github.com/mikefarah/yq)
- `jv` from santhosh-tekuri/jsonschema validates YAML/JSON against JSON Schema, including Draft 2020-12 and explicit format assertions. Do not impose a Go toolchain on consumers merely because its upstream build uses Go. [Upstream jv documentation](https://github.com/santhosh-tekuri/jsonschema)

During authorized implementation, verify the exact tool identity/version and the required behavior, including duplicate-key rejection, safe handling of values, deterministic output, and offline schema resolution. Record the tested versions and acquisition instructions in `docs/dependencies.md`. Do not silently substitute another tool named `yq` or weaken checks if either selected tool fails a requirement; report the concrete gap. Neither tool has been installed or behavior-tested during planning.

Bash alone is sufficient for much of the workflow. Preserving general YAML handling and the supplied schema contract using Bash alone would require substantial custom parsing/validation code. That would increase maintenance complexity. Do not silently reduce accepted formats, omit schema checks, or claim that grep/sed checks implement JSON Schema. Any deliberate reduction of the handoff’s validation scope requires an explicit reviewed decision.

Initial platform verification targets macOS and Linux. Other hosts remain unverified until tested. Git and available hashing/file utilities are operational prerequisites; a dependency on Python, Node, a compiler, a package manager, or a container engine is not proposed.

## Simplicity goal and metrics

Choose the simplest implementation that satisfies the approved behavior and safety requirements. Simplicity means low total operating and maintenance effort, not just a low count of installed tools.

At each chunk review, report:

| Metric | Review target |
|---|---|
| Additional required tools | Count and name each tool, the exact capability it supplies, and which operations require it. Add none without the user’s choice. |
| Setup steps | Count documented actions needed before the first successful run; avoid automatic bootstrap and unnecessary setup layers. |
| Implementation size | Report production script count and nonblank source lines, explaining material growth. These are comparison signals, not quotas that reward compressed code. |
| Custom mechanisms | Identify any new parser, framework, storage mechanism, or abstraction; prefer existing tools and direct operations. |
| Developer effort | Count avoidable manual steps and repeated questions; preserve the explicit choices required by the handoff. |
| Repeatability | A documented command runs each test group without an extra test framework or manual repository preparation, using the approved disposable test fixtures. |

Start with a small shell entrypoint and a few supporting files. Add modules only for concrete responsibilities, not one module per concept in the handoff. A focused external utility can be simpler than maintaining a custom implementation. Record that tradeoff for the user instead of deciding it silently.

## Recorded design decisions

The following combine settled handoff constraints, explicitly approved review decisions, and proposed implementation details. The dependency selection and disposable-test-fixture exception are approved. Starting implementation still requires explicit authorization.

| Area | Proposed behavior |
|---|---|
| Authority | Constitution > Policies > Specifications > Active ADRs. Resolve explicit same-level supersession; surface ambiguous conflicts. Evidence and operational instructions never become additional normative levels. |
| Simplicity | Minimize setup, dependencies, custom mechanisms, and maintenance effort; report the metrics above at every review. |
| Dependencies | No Python requirement. Bash and Git cover straightforward work; Mike Farah’s `yq` and santhosh-tekuri/jsonschema `jv` are the approved data-processing and validation dependencies. |
| Test fixtures | Test setup may create commits only in disposable example repositories under a dedicated temporary directory. The production workflow, this repository, and real project repositories retain the no-commits rule. |
| Router | One public governed-development skill. Natural-language routing and recommendations belong in the skill; deterministic helpers validate state and perform filesystem operations. |
| Interviews | One outstanding decision at a time. Persist answers locally. Recommendations never populate missing choices. Reuse explicit authorization already given for the same action. |
| Registration | Store confirmed project paths and a stable, credential-free Governance identity outside repositories. |
| Data location | Explicit `--data-dir`, otherwise supplied `PLUGIN_DATA`, otherwise `${XDG_DATA_HOME:-$HOME/.local/share}/beeline-technologies/governed-exploratory-development`. Reject storage inside project repositories or the installed plugin tree. |
| Onboarding | Validate an existing Product/Governance pair and existing committed submodule relationship. Diagnose missing history or pins; do not create them. |
| Existing files | Seed missing role `AGENTS.md` files once. Preserve existing files and surface conflicts. |
| Revision selection | Present and explicitly confirm an exact Governance commit; never silently follow HEAD. Product’s adopted pin and a newer experimental baseline remain distinct. |
| Snapshot source | Enumerate the selected Git tree and read blobs by object ID. Never copy dirty checkout contents or use archive transformations. |
| Git compatibility | Initially support the handoff’s SHA-1 commit format. Reject unsupported object formats explicitly. |
| Integrity | Canonical JSON manifest: sorted relative paths, source classification, mode, byte count, and SHA-256. Hash its exact bytes in `SNAPSHOT.yaml`; exclude the manifest and snapshot from recursive self-hashing. |
| Contract exports | Explicit allowlist, source identity, optional source commit, and per-file hashes. No arbitrary Product scanning or inferred exports. |
| Discovery IDs | Governance-owned `discoveries/.reservations/DISC-xxxx.json`; atomic exclusive creation and collision retries. Failed reservations remain consumed; IDs are sequential, not necessarily gapless. |
| Concurrency | Guarantee local uniqueness against the same Governance checkout. Do not claim coordination across independent clones. |
| Recovery | Journal operation-owned files locally. Remove only unchanged files created by the failed operation; preserve unexpected edits. |
| Isolation | Policy and workflow guardrails across transports. Detect obvious contamination and surface exposure; make no hard-sandbox claim. |

## Package inconsistencies and proposed handling

The handoff remains unchanged.

| Finding | Proposed production handling |
|---|---|
| Requested handoff path is absent | Use confirmed `planning/handoffs/`; correct root `AGENTS.md` references after implementation approval. |
| Templates permit workstation paths in provenance, conflicting with Decision 29 | Add `governance_repository` to the production registration model; write that stable identity into Discovery provenance. |
| Contract export location/provenance is unspecified | Use the separate immutable contract namespace and manifest shown above. |
| Snapshot digest has no defined content-manifest format | Define the canonical format and semantic cross-document checks in `runtime-contract.md`. |
| Concurrency is required but deferred by phase outlines | Implement basic atomic reservations and recovery in the first increment. |
| Reference layout permits inherited scaffolding | Follow Decision 13: creation is always minimal, including full-reference mode. |
| Full Governance may contain Product-derived implementation evidence | Surface incompatible context/access selections and require a revised choice. Never silently omit material while claiming a full snapshot. |
| Product `AGENTS.md` lists implementation as a fifth precedence item | Keep implementation in a separate evidence paragraph beneath the four normative levels. |
| Pending proposal template includes `resolution: pending` | Follow Decision 34: directory location carries pending state; resolution metadata records accepted/rejected outcomes. |
| Closeout reference adds record approval before disposition | Follow Decision 11’s generated-and-surfaced requirement without inventing an additional mandatory approval gate. |

## Approved test-fixture approach

A **test fixture** means sample data used by a test: here, a tiny example Governance repository and a tiny example Product repository.

The user approved creating these examples automatically, including their initial Git commits, under a dedicated temporary directory. This keeps the tests repeatable and avoids manual preparation or maintaining prebuilt repository archives.

Only test setup may create these example commits. Before doing so, it must verify that the target repositories are inside its own temporary directory and that inherited Git settings cannot redirect writes to a real repository. Test-only identity and configuration must not modify global Git configuration. Cleanup is limited to files owned by that test run.

This exception does not permit commits in this repository or real Product, Governance, or Discovery repositories. It does not permit pushes or remote creation. The production workflow under test must still leave source history unchanged and the new Discovery uncommitted. Test setup and workflow execution must be distinguishable in the command audit so fixture commits cannot mask a workflow violation.

## Unresolved

None for the first implementation increment. Both previously open review choices are resolved. Implementation authorization remains pending.

The exact Shimmy Product bootstrap contract remains a prerequisite for approving Chunk 5, not a blocker for the first increment.

## Progress Checklist

- [x] Read repository instructions and complete handoff.
- [x] Confirm source directory, objective, and planning root.
- [x] Verify current official packaging requirements.
- [x] Remove the Python dependency proposal and make simplicity an explicit goal and metric.
- [x] Choose the YAML/JSON processing and schema-validation tools: Mike Farah’s `yq` and santhosh-tekuri/jsonschema `jv`.
- [x] Permit commits solely when constructing disposable test fixtures; retain the no-commits rule for production workflows and real repositories.
- [x] Persist proposed plan with explicit user permission, for review only.
- [ ] Obtain approval to start implementation.
- [ ] Chunk 1 — Skeleton and validation.
- [ ] Chunk 2 — Registration, onboarding, and Discovery creation.
- [ ] Chunk 3 — Successor, closeout, and synthesis.
- [ ] Chunk 4 — Governance, promotion, and adoption.
- [ ] Chunk 5 — Shimmy delegation.
- [ ] Chunk 6 — Hardening and installation verification.

Active state: **PLAN**, awaiting review of this persisted document. No implementation chunk is active.

## Execution protocol

For every chunk:

1. Read `AGENTS.md`, `GLOSSARY.md`, every child context on the path to a changed
   file, this plan, and the chunk's target files.
2. Execute only that chunk's scope.
3. Run its verification checklist and record `[x]`, `[ ]`, or `[~]` with notes.
4. Update the cumulative **Lessons learned** block.
5. Summarize changes, tests, failures, uncertainties, and remaining risks.
6. Stop for human review and explicit acceptance before starting the next
   chunk.

Repository paths in this plan are relative to `<repo>` so it remains portable
across workstations and sessions.

## Chunk 1 — Skeleton and validation

### Goal

Deliver the handoff’s first milestone: coherent, independently packaged plugin skeletons and reusable validation infrastructure.

### Files

Create:

- `.agents/plugins/marketplace.json`
- `README.md`, `.gitignore`
- `docs/packaging.md`, `docs/testing.md`, `docs/dependencies.md`
- `P/plugin.json`
- `S/SKILL.md`
- `S/references/runtime-contract.md`
- `S/references/workflows/project-onboard.md`
- `S/references/workflows/discovery-create.md`
- `S/references/workflows/discovery-successor.md`
- `S/references/workflows/discovery-closeout.md`
- `S/references/workflows/discovery-synthesize.md`
- `S/references/workflows/governance-propose.md`
- `S/references/workflows/governance-resolve.md`
- `S/references/workflows/product-promote.md`
- `S/references/workflows/governance-adopt.md`
- `S/assets/schemas/discovery.schema.json`
- `S/assets/schemas/governance-snapshot.schema.json`
- `S/assets/schemas/project-registration.schema.json`
- `S/assets/templates/DISCOVERY.yaml`
- `S/assets/templates/GOVERNANCE-SNAPSHOT.yaml`
- `S/assets/templates/PROJECT-REGISTRATION.yaml`
- `S/assets/templates/agents/product/AGENTS.md`
- `S/assets/templates/agents/governance/AGENTS.md`
- `S/assets/templates/agents/discovery/AGENTS.md`
- `S/scripts/governed.sh`
- `S/scripts/lib/data.sh` — structured-data operations and template rendering using the user-selected tools
- `H/plugin.json`
- `H/skills/shimmy-onboarding/SKILL.md`
- `H/skills/shimmy-onboarding/references/onboarding-contract.md`
- `scripts/check_packaging.sh`
- `scripts/check_skill_discovery.sh`
- `tests/run.sh`, `tests/support.sh`
- `tests/test_packaging.sh`
- `tests/test_validation.sh`
- `tests/test_templates.sh`

Modify root `AGENTS.md` only to correct the confirmed handoff location.

### Implementation requirements and suggested reasoning level

Suggested reasoning: high for contracts and packaging; medium for mechanical assets.

Keep portable root manifests. Mark unavailable lifecycle functionality clearly; skeleton instructions must not imply operational support. The Shimmy skeleton contains no bootstrap execution implementation.

Use strict YAML loading, reject duplicate keys and unresolved template variables, validate schemas themselves, and provide deterministic rendering.

Dependencies: Bash, Git, existing platform utilities, and the user-selected tools for the two data capabilities. Record each narrow requirement in `docs/dependencies.md`; do not add a general runtime or automatic installer.

### Verification checklist

- [ ] Portable manifests, marketplace paths, skill metadata, and references validate.
- [ ] Exactly one governed-development public skill exists.
- [ ] Templates render deterministically and satisfy schemas.
- [ ] Invalid YAML, unknown fields, malformed dates, and missing substitutions fail clearly.
- [ ] Actual standalone skill parsing succeeds through the documented app-server API.
- [ ] Handoff contents remain unchanged.

Commands:

```text
bash scripts/check_packaging.sh
bash tests/run.sh packaging validation templates
bash scripts/check_skill_discovery.sh
git diff --check
```

Packaged installation/namespacing remains explicitly unverified until Chunk 6.

### Human review gate

Review packaging, capability-specific dependencies, schema adaptations, and intentionally unavailable functionality.

Checkpoint: record exact changed files, results, and diff in the plan. Rollback removes only this chunk’s unchanged additions and restores its specific `AGENTS.md` edit—never a blanket reset.

## Chunk 2 — Onboard and create

### Goal

Complete the first requested increment through two internal phases: onboarding, then Discovery creation.

### Files

Create:

- `S/scripts/lib/files.sh` — containment, exclusive creation, and operation-owned recovery
- `S/scripts/lib/git.sh` — restricted Git inspection and local initialization
- `S/scripts/lib/interview.sh` — sequential answer state
- `S/scripts/lib/onboarding.sh` — registration and pair validation
- `S/scripts/lib/snapshot.sh` — authority metadata, selected content, and integrity
- `S/scripts/lib/discovery.sh` — ID reservation and minimal repository creation
- `S/assets/schemas/interview-session.schema.json`
- `S/assets/schemas/operation.schema.json`
- `S/assets/schemas/id-reservation.schema.json`
- `S/assets/schemas/content-manifest.schema.json`
- `S/assets/schemas/contract-export.schema.json`
- `docs/onboarding.md`, `docs/discovery-creation.md`
- `tests/test_registration.sh`
- `tests/test_interview.sh`
- `tests/test_onboarding.sh`
- `tests/test_authority.sh`
- `tests/test_ids.sh`
- `tests/test_snapshot.sh`
- `tests/test_discovery.sh`
- `tests/test_recovery.sh`
- `tests/test_git_boundary.sh`

Update the router, relevant workflow references, runtime contract, CLI, schemas, and templates from Chunk 1.

Runtime outputs, outside this implementation repository:

- Plugin data: `projects.yaml`, `sessions/<uuid>.json`, `operations/<uuid>.json`
- Missing Product/Governance role `AGENTS.md` files
- Governance reservation files
- The Discovery repository shown in the target layout

### Implementation requirements and suggested reasoning level

Suggested reasoning: high.

**Phase 1 — Registration and onboarding**

Confirm project identity and paths one field at a time. Verify distinct Git repositories, Product’s committed gitlink, index state, submodule checkout, and availability of the pinned commit in Governance. Diagnose inconsistent or missing relationships without staging, creating remotes, or advancing the pin.

Preserve existing instructions and unrelated changes. Registration must be idempotent and independent across workstations.

**Phase 2 — Discovery creation**

Conduct explicit choices for context, experiment type, framing, Product access, charter, and optional comparison. Curated mode always carries the Constitution and records each candidate’s inclusion/exclusion decision.

Validate the approved inputs before allocating an ID or creating a destination. Extract exact committed blobs; disable replacement-object interpretation and implicit fetch behavior. Reject unsafe paths, symlinks, nested gitlinks, and collisions.

Initialize an empty local Git repository without inherited templates. Validate the minimal scaffold, source provenance, content hashes, authority classifications, contract allowlist, and obvious contamination.

Dependencies: accepted Chunk 1 with `yq` and `jv`, the approved disposable test-fixture setup, and valid committed Product/Governance input.

### Verification checklist

- [ ] AT-001–008 and AT-019 pass.
- [ ] AT-022–025 pass within structural and workflow guardrail scope.
- [ ] Full and curated creation produce valid repositories.
- [ ] Missing choices cannot become defaults; rejected recommendations are honored.
- [ ] Existing files, Product index, pins, and source history remain unchanged.
- [ ] Dirty/untracked Governance files do not enter snapshots.
- [ ] Duplicate IDs, invalid supersession, missing Constitution, and malformed provenance fail.
- [ ] Concurrent creation yields unique IDs or safe failure.
- [ ] Fault injection leaves no unreported partial repository and preserves user edits.
- [ ] New Discovery HEAD is unborn; no remotes or staged files exist.
- [ ] Fixture commits are confined to test-owned temporary repositories; the command audit separately proves the production workflow never commits.
- [ ] One complete router-driven onboarding-to-Discovery walkthrough succeeds.

Commands:

```text
bash tests/run.sh registration interview onboarding
bash tests/run.sh authority ids snapshot discovery recovery git_boundary
bash tests/run.sh
git diff --check
```

Record commands and results separately after each internal phase.

### Human review gate

Review the generated Discovery tree, approved interview record, provenance, diffs, test evidence, and recovery behavior.

Checkpoint: operation journals identify owned writes. Failed/canceled IDs remain reserved. Rollback never deletes changed user files or rewrites source history.

## Chunk 3 — Successor, closeout, and synthesis

### Goal

Implement immutable continuation and durable evidence preservation.

### Files

Create:

- `S/scripts/lib/lifecycle.sh` — successor, closeout, and synthesis operations
- `S/assets/templates/DISCOVERY-RECORD.md`
- `S/assets/templates/SYNTHESIS-RECORD.md`
- `tests/test_successor.sh`
- `tests/test_closeout.sh`
- `tests/test_synthesis.sh`
- `docs/discovery-lifecycle.md`

Update the three corresponding workflow references, router, CLI, ID allocation, and validation.

### Implementation requirements and suggested reasoning level

Suggested reasoning: high. Depends on accepted Chunk 2.

Successors reuse the creation path with explicit predecessor and reason. Closeout surfaces durable evidence before disposition. Synthesis remains optional and non-normative. Record + Delete provides manual removal guidance; it does not delete repositories automatically.

### Verification checklist

- [ ] AT-009–012 and AT-019 pass.
- [ ] Predecessor contents remain byte-for-byte unchanged.
- [ ] Closeout ordering and separate promotion decisions are preserved.
- [ ] Failed record writes cannot advance disposition.
- [ ] Synthesis preserves uncertainty and authority boundaries.

Run `bash tests/run.sh successor closeout synthesis`, then `bash tests/run.sh` and `git diff --check`.

### Human review gate

Review successor linkage, generated records, disposition ordering, and optional synthesis.

Checkpoint: retain original repository state and journal generated evidence; rollback only operation-owned changes.

## Chunk 4 — Govern, promote, and adopt

### Goal

Implement human-controlled normative changes and independent Product promotion.

### Files

Create:

- `S/scripts/lib/proposals.sh`
- `S/scripts/lib/promotion.sh`
- `S/scripts/lib/adoption.sh`
- `S/assets/templates/GOVERNANCE-PROPOSAL.md`
- `S/assets/templates/GOVERNANCE-ARTIFACT.md`
- `tests/test_proposals.sh`
- `tests/test_promotion.sh`
- `tests/test_adoption.sh`
- `docs/promotion-and-adoption.md`

Update the corresponding workflow references, router, CLI, and validation.

### Implementation requirements and suggested reasoning level

Suggested reasoning: high. Depends on accepted Chunk 3.

Keep pending/resolved proposal state in directories. Accepted proposals require separate normative edits and Product impact assessment. Knowledge and code promotion remain independent. Adoption requires explicit developer direction after conformance review and does not commit or stage the result.

### Verification checklist

- [ ] AT-013–019 and AT-022–024 pass.
- [ ] Rejected proposals preserve rationale.
- [ ] Acceptance cannot silently modify Product.
- [ ] Failing adoption checks produce a recommendation while preserving developer choice.
- [ ] Only approved working-tree changes occur.

Run `bash tests/run.sh proposals promotion adoption`, then `bash tests/run.sh` and `git diff --check`.

### Human review gate

Review proposal transitions, human-choice evidence, Product-impact output, and exact adoption behavior.

Checkpoint: journal original affected file contents and submodule state; restore only unchanged operation-owned changes.

## Chunk 5 — Shimmy onboarding delegation

### Goal

Implement delegation to Product-owned bootstrap logic.

### Files

Create:

- `H/skills/shimmy-onboarding/scripts/onboard.sh`
- `tests/test_shimmy_onboarding.sh`
- `docs/shimmy-onboarding.md`

Update the existing Shimmy skill, contract reference, and manifest descriptions.

### Implementation requirements and suggested reasoning level

Suggested reasoning: high at the execution boundary.

Require authoritative Product source/release context and a verified bootstrap contract. Invoke only that contract with applicable authorization. No copied installation logic, inferred historical commands, or automatic Product changes.

The exact Product entrypoint must be established before this chunk is approved for execution.

### Verification checklist

- [ ] AT-020–021 pass using controlled test executables.
- [ ] Missing or contradictory contracts stop before execution.
- [ ] Argument handling preserves boundaries and avoids shell interpolation.
- [ ] Post-install checks come from the Product contract.

Run `bash tests/run.sh shimmy_onboarding`, then `bash tests/run.sh` and `git diff --check`.

### Human review gate

Review the verified Product contract and delegation behavior. A real installation is not required to prove the wrapper’s controlled test behavior.

Checkpoint: no plugin-owned installer state exists; installation rollback follows Product documentation.

## Chunk 6 — Hardening and installation verification

### Goal

Complete remaining robustness, compatibility documentation, and packaged-plugin verification.

### Files

Create:

- `tests/test_concurrency.sh`
- `tests/test_path_safety.sh`
- `tests/test_schema_versions.sh`
- `tests/test_installation.sh`
- `scripts/check_installation.sh`
- `docs/installation.md`
- `docs/recovery.md`
- `docs/schema-versioning.md`

Update affected helpers, capability-specific dependencies, packaging documentation, and root README.

### Implementation requirements and suggested reasoning level

Suggested reasoning: high for recovery and platform behavior.

Expand contention and interruption testing. Reject unknown schema versions; never migrate immutable Discovery snapshots in place. Verify local marketplace installation and fresh-conversation discovery without publishing anything.

### Verification checklist

- [ ] Entire AT-001–025 matrix is accounted for with evidence.
- [ ] Repeated concurrency and interruption tests pass.
- [ ] Supported-platform path behavior passes.
- [ ] Fresh installation discovers both plugins with correct namespacing.
- [ ] Governance workflows expose only their single router skill.
- [ ] No handoff modifications, workflow commits, or remote actions occurred.

Run `bash scripts/check_packaging.sh`, `bash tests/run.sh`, `bash scripts/check_installation.sh`, and `git diff --check`.

### Human review gate

Review final acceptance evidence and every remaining limitation. Completion requires explicit final acceptance.

Checkpoint: record any local installation changes and their reversal steps; no remote release occurs.

## Risk register

| Risk | Handling |
|---|---|
| Selected tool/version behaves differently than required | Verify `yq` and `jv` identities, tested versions, and required data/validation behavior; report concrete gaps without silently replacing tools. |
| Custom shell parsing becomes complex | Use a reviewed, focused utility rather than implement YAML or JSON Schema in shell. |
| Unnecessary implementation structure | Review dependency, setup, source-size, and custom-mechanism metrics; consolidate where it improves clarity. |
| Test-fixture exception escapes its scope | Assert temporary-directory ownership, isolate Git settings, and distinguish fixture setup from production workflow commands. |
| Packaging checks mistaken for installation proof | Report structural, standalone discovery, and installed-plugin checks separately. |
| Context contamination | Require explicit resolution of incompatible access/context selections; avoid hard-isolation claims. |
| Dirty files or interrupted writes | Exact-object reads, exclusive creation, and ownership-aware recovery. |
| ID collisions across independent clones | State the local-concurrency boundary clearly. |
| Future functionality advertised prematurely | Keep router behavior and manifest descriptions aligned with implemented milestones. |

## Lessons learned

### Initial

- The confirmed handoff location differs from root instructions.
- Current portable packaging is supported; the bundled validator targets a different format.
- Exact-commit provenance requires pre-existing source history.
- Basic concurrency and recovery cannot safely wait until final hardening.
- The supplied schemas need semantic checks beyond JSON Schema validation.
- Permission to persist this plan is explicitly separate from permission to implement it.

### Plan review — dependency scope and simplicity

- The earlier Python choice was broader than the demonstrated need and is withdrawn.
- Define needed capabilities first and let the user choose additional tools.
- Bash is acceptable for straightforward workflow and test orchestration; avoid a new test framework by default.
- A lower dependency count is not automatically simpler if it requires custom parsing or validation code.
- Explain test setup in terms of disposable example repositories, and keep its permissions separate from the production workflow.

### Plan review — approved dependencies and test setup

- The user approved `yq` and `jv` for their specific data-processing and validation capabilities.
- The user approved automatically creating commits only for disposable test fixtures, favoring repeatability and low manual effort.
- Resolving these choices does not authorize beginning implementation or installing dependencies during plan review.

## Session bootstrap

Read root instructions, this plan, the six required handoff documents in order, then the active chunk’s references and target files. The confirmed handoff paths are:

1. `planning/handoffs/codex/IMPLEMENTATION-BRIEF.md`
2. `planning/handoffs/docs/01-architecture.md`
3. `planning/handoffs/decisions/DECISIONS.md`
4. `planning/handoffs/docs/05-plugin-architecture.md`
5. `planning/handoffs/codex/IMPLEMENTATION-PHASES.md`
6. `planning/handoffs/codex/ACCEPTANCE-TEST-MATRIX.md`

Preserve the read-only handoff, separate repository roles, single public router, explicit developer choices, and Git/bootstrap boundaries.

**Current execution authorization permits only creating and revising this persisted plan. Wait for the user to explicitly authorize implementation.** The user has approved `yq`, `jv`, and commits confined to disposable test-fixture setup; preserve those decisions without asking again. Do not reinstate a Python dependency. Treat simplicity as a goal and report its metrics at every review. Do not treat approval of these choices as authorization to start a chunk.

After explicit implementation approval, recheck instructions and repository state, then move this authoritative plan from `planning/notional/` to `planning/wip/` before changing implementation files. Start only the approved chunk. Update progress, tests, partial verification, and lessons before stopping at its review gate. Move to `planning/complete/` only after final human acceptance, adding `Completed: YYYY-MM-DD` immediately after the title. Never overwrite a colliding plan destination.

At every executed chunk’s review, include a distinct partial-verification section. For each `[~]` item, state what passed, what remains, why, its impact, the next action, and whether it blocks acceptance or is proposed for explicit deferral. If none exists, state `None`.
