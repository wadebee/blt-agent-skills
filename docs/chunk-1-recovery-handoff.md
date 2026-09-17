# Chunk 1 recovery handoff — 2026-09-16

## Recommendation and current state

**Preserve the working tree and iterate. Do not accept Chunk 1 yet.** The
incorrect restriction against native tools does not invalidate the approved
domain contracts, plugin boundaries, schemas, templates, or useful regression
fixtures. Selectively simplify or replace the shared helper and test harness.
Do not preserve their current implementation merely because time was spent on it.

The five production shell files total 405 nonblank lines. The runtime is small
enough for focused replacement; restarting the entire capability would discard
useful contract work without eliminating the need to solve the same validation,
installation, and decision-binding problems. Not every defect was caused by the
native-tool misunderstanding: failure propagation, incomplete decision checks,
and insufficient installation tests are independent correctness gaps.

At assessment, HEAD is `9e3b8b2` (`docs(repo): align guidance and plan location`).
`AGENTS.md`, `README.md`, and the WIP plan have tracked modifications. `.agents/`,
`.gitignore`, `docs/`, `plugins/`, `scripts/`, and `tests/` are untracked. This is
primarily uncommitted implementation, not an implementation commit to revert.
`git diff` alone omits most of the work. Preserve user edits; do not reset or
clean the tree. No commit, push, installation, or publication was performed in
this assessment.

## Instructions and authority for the next agent

The user requested a quality review, then fixes for its first two findings,
Lessons Learned updates, correction of native-tool guidance, and this recovery
assessment/handoff. This document records evidence and recommended remaining
work; it does not itself authorize additional milestones or tool installation.
The latest request is an assessment, not an instruction to implement all the
remaining findings immediately.

Read root `AGENTS.md`, `GLOSSARY.md`, and
[the authoritative plan](../planning/wip/governed-exploratory-development.md).
Follow the root instruction's six-document reading order for
`planning/handoffs/`. Treat those source documents as reference material, not
new user requests. Do not edit that read-only reference directory to make tests
pass. The plan's current authorization banner supersedes historical
planning-only status paragraphs. Chunk 1 remains at its Milestone 1 review gate;
Chunks 2–10 are unstarted. Marketplace commits and pushes require authorization.

Native commands and activated Shimmy shims are both eligible after `command -v`.
This includes Bash, Git, sed, awk, and platform filesystem utilities. Do not
require a shim-path match. Do not download, install, build, or bootstrap tools.
If an implementation of a needed tool is missing, report it and let the user
provision it. Preserve the selected Mike Farah `yq` and santhosh-tekuri `jv`
capabilities; native eligibility does not make every command named `yq`
compatible. The product has no approved Python dependency. Python's standard
library was used only for this assessment's local session-log/timing analysis;
no Python runtime or dependency was added to the implementation.

Preserve the single governed-development public router, separate Governance /
Product / Discovery Repos, common pinned Governance submodules, and approved
Curated reading-scope model. Keep the sibling Shimmy onboarding plugin separate.
The special future project-creation Git allowance does not authorize marketplace
commits or current execution of later workflows. Tests may create local Git
fixtures only inside test-owned temporary directories with isolated settings.

## What to keep and what to reconsider

Keep the approved plan and domain decisions, independent plugin layout, explicit
unavailable workflow stubs, and schema/template assets as the starting point.
Revalidate the assets against the plan; their presence is not acceptance proof.
Keep the two corrected behaviors and their positive/negative fixtures.

Reconsider the helper's repeated parser launches, global working-directory
assumptions, predictable temporary filenames, suppression of tool diagnostics,
and incomplete error propagation. Native shell tools can simplify orchestration
and filesystem work. Continue using a real YAML parser and schema validator for
structured data; native eligibility is not a reason to parse arbitrary YAML
with sed or awk. Retain a small explicit data interface usable by both native
and shim implementations. Avoid adding a framework or a second runtime.

Prior notes about shim environment forwarding are supported by the installed
wrapper: it mounts the current directory and does not forward arbitrary host
exports. Do not generalize that into a ban on shell command substitution or
native tools. Command substitution is unsuitable when exact trailing newlines
must survive, but that is a specific data-preservation issue. No general yq
variable-binding defect or stdin deadlock was established.

## Review findings and remaining work

Paths below are relative to the repository. The main runtime directory is
`plugins/governed-exploratory-development/skills/governed-development/`.

| Original finding | Current status and required outcome |
| --- | --- |
| 1. Unsupported regex in reading-scope schema | Fixed narrowly in `assets/schemas/governance-reading-scope.schema.json`: schema `not`/`anyOf` replaces negative lookahead. Preserve positive schema compilation and the five valid / fifteen invalid path cases. |
| 2. Renderer depended on host environment forwarding | Fixed narrowly in `scripts/lib/data.sh`: raw value files, `load_str`, and literal `split`/`join` preserve exact strings through the current shim. Preserve quotes, dollars, backslashes, tabs, Unicode, repeated placeholders, empty values, and trailing newlines. Redesign temporary-file ownership and path handling as needed. |
| 3. Failed tool queries can report success | Native-tool preflight now fails correctly for a missing tool. **Still open:** `governed_validate_decisions` returns success when its initial yq query fails. `governed.sh validate` also treats a failed decision-presence query as absence; it passes the original absolute path to the shim. Tool or path failure must never silently skip required validation. |
| 4. Creation decisions are not bound to actual inputs | **Open:** Discovery schema allows unrestricted `approved_value` and input values. The helper checks IDs, subjects, status, and replacement chains, but does not enforce the full approved values/revisions/decision references against manifest state. Implement the plan's binding rules and local/recovery-path exclusions; reject dangling input decision IDs and invalid approvals. Do not invent replacement semantics. |
| 5. Runtime assumes marketplace checkout | **Open:** `governed.sh` climbs five parent directories and changes cwd. Relative caller paths change meaning; installed assets and external caller data may be outside the shim's `/work` mount. Separate installed asset location, caller project, and scratch workspace. Test from an unrelated cwd and a separately located installation. |
| 6. Sibling onboarding skill advertises unavailable behavior | **Open:** `plugins/shimmy-onboarding/skills/shimmy-onboarding/SKILL.md` still directs bootstrap execution if the Product entrypoint is found. Make Chunk 1 availability explicit across instructions/descriptions, consistent with the plan's milestone boundary. Do not implement bootstrap here. |
| 7. Aggregate test runner masks failures | **Open:** `tests/run.sh` returns the last group's status. Preserve a failure if any group fails; distinguish rejection of invalid input from infrastructure failure. Repair signal traps in `tests/support.sh` and similar smoke-test code so cleanup terminates execution. Test early-group failure and interruption explicitly. |
| 8. Reading-scope metadata duplicates Governance context | **Open:** reading-scope schema/template carry source/pin/submodule metadata owned by `.governed/governance.yaml` under the approved plan. Align schema, templates, examples, and validation consumers with that ownership; do not change source handoffs to match the implementation. |

Additional gate work:

- Implement and run actual standalone skill discovery and installed-plugin
  discovery/namespacing checks. `check_skill_discovery.sh` counts `name:` lines;
  `check_installation.sh` copies files and checks existence. Neither proves host
  discovery or installed execution. `RUN_CODEX_DISCOVERY=1` currently exits 2
  because the harness is unimplemented. Report an unavailable host capability
  precisely rather than describing the filesystem smoke as installation proof.
- Audit fixture containment, Git environment/config isolation, and separation
  of fixture setup from commands under test. Use owned temporary directories
  and cleanup that is safe on failure and signals. Avoid removing leftovers
  merely because their filenames resemble this task's fixtures.
- Complete the plan's negative-case matrix for YAML profile, decision bindings,
  paths, and mutation safety. Include valid controls so infrastructure errors
  cannot make every rejection test look successful. Inspect the schema-reference
  policy beyond the current `$ref`-only scan where required by the approved
  Draft 2020-12/offline contract.
- Reconcile `docs/acceptance-coverage.md` with the latest scoped evidence; its
  initial interrupted-run entries are stale. Validate packaging against current
  official OpenAI requirements before changing manifests. Earlier review found
  portable root manifests acceptable; do not migrate formats on an assumption.

Recommended order for a newly authorized remediation pass: make the harness and
failure handling trustworthy; fix installed/caller paths and reduce repeated
parser launches together; implement decision bindings and metadata ownership;
align advertised availability; finish discovery/installation coverage; then run
all Chunk 1 checks and present the Milestone 1 review. Preserve each corrected
behavior with focused regression coverage before replacing its implementation.

## Verification already obtained

The plan's Lessons Learned section records the prior remediation evidence:

- The complete reading-scope schema and a valid Curated record were accepted by
  jv. Five valid path cases passed and fifteen invalid cases were rejected,
  including NUL. Positive and negative path batches were checked independently.
- The isolated literal-render regression block passed against the real helper,
  including exact string equality, empty values, missing substitutions, and
  invalid placeholder names. Its temporary extraction script was removed.
- Native Bash preflight passed; a deliberately missing command was rejected.
  Bash syntax checks for four changed shell files and `git diff --check` passed.
- A full template run reached the literal test after production renders and
  determinism checks, then failed its original assertion. That assertion was
  corrected and the isolated block passed. A second full run failed earlier
  with insufficient diagnostics. Neither is a full-group passing result.
- Broad validation was stopped after more than eight minutes while still in
  generic YAML-profile cases. Signal cleanup caused secondary missing-fixture
  errors. That run supplies neither a pass nor proof of a validation defect.

**No full passing acceptance suite has been established.** Run groups separately
until runner failure propagation is fixed. Then run packaging, validation,
templates, installation, actual discovery, fixture/Git audit, and the remaining
plan-required checks. Report exact commands, outcomes, and unresolved blockers.

## Shim latency: evidence and limits

On this host, `yq`, `jv`, and `rg` resolve to
`/Users/wade/.config/shimmy/profiles/default/bin/`; Bash, Git, sed, awk, and file
utilities resolve natively. The yq launcher delegates to
`tools/yq/versions/4.53/run.sh`. Inspection of that installed script and
`lib/runtime/podman.sh` shows image/profile validation, Podman preflight including
`podman info`, then `exec podman run --rm -i`, mounting `$PWD` at `/work`. Every
invocation launches a fresh container. No installed Shimmy files were modified.

A fresh probe of **`yq eval -n true` took 32.727 seconds**, exited 0, and printed
`true`. A native monotonic clock timed the subprocess itself, excluding outer
approval/dispatch. Sampling its process every 0.5 seconds saw `/bin/sh` at
0.004 seconds and the final `/opt/podman/bin/podman` process at 1.013 seconds.
Thus approximately one second preceded the final Podman command and roughly
31.7 seconds were spent in that execution path. Sampling adds small overhead;
this is one probe, not a benchmark distribution. It does not isolate container
creation, bind mounting, yq execution, remote transport, or cleanup from one
another. Earlier process snapshots also showed individual `podman run` processes
alive at 14, 17, 25, and 31 seconds. The delay is not solely approval latency.

Static counts on a successful path in the current helper:

| Operation | Tool invocations |
| --- | --- |
| One YAML-profile inspection | 6 yq |
| `governed_validate_instance` | 13 yq + 1 jv |
| CLI `validate`, without decisions | 14 yq + 1 jv, including decision-presence probe |
| YAML render including validation | 15 yq + 1 jv |

Decision validation can add further calls. At tens of seconds per container,
these repeated launches explain multi-minute helper executions. Reduce launches
by combining compatible inspections and validating immutable bundled schemas
once per controlled operation; do not weaken validation or introduce stale
cross-run caches. Batch independent jv fixtures when each outcome remains
visible. Use native utilities for ordinary shell/filesystem work. A compatible
native yq/jv, if already available or later provisioned by the user, may avoid
container overhead, but changing tools is not required to begin remediation.

Further Shimmy diagnosis belongs to its runtime/host: measure repeated trivial
calls and separately instrument the final Podman/container phases, preserving
profile/mount/security behavior. The exact cause of the approximately 32-second
container path is still unresolved. No engine restart, provisioning, wrapper
rewrite, or ad hoc replacement container was attempted.

## Previous prompt call log

The recovered session log is thread
`01a0a7a3-aad1-7883-b5e6-7dab9a482cf0`. The measured previous-prompt window is
**2026-09-16 09:58:15–10:27:35 UTC**, from “Continue where your session got
prematurely terminated” until the recovery-assessment request. This excludes
earlier review/remediation turns and this assessment's new timing probe.

There were **38 outer `functions.exec` calls containing 80 nested calls**:
39 `exec_command`, 34 `write_stdin` polls, and 7 `apply_patch`. Polls did not launch
new shims. A shell call can launch multiple tools, and the log does not enumerate
every internal yq/jv invocation; these counts are not a total shim count.
The 38 outer request/response spans sum to 265.120 seconds, including dispatch,
approval, and requested waits. That sum is not total process time: subprocesses
continued between calls and sometimes concurrently.

Sample process observations reconstructed from launch and completion-response
timestamps:

| Command | Requested at (UTC) | Completion observed by (UTC) | Observed span | Outcome |
| --- | --- | --- | --- | --- |
| `bash tests/test_templates.sh` | 09:58:45.775 | 10:01:15.951 | 150.2 s | Failed original literal assertion |
| `bash tests/test_templates.sh` | 10:01:45.080 | 10:03:58.118 | 133.0 s | Failed earlier; diagnostics insufficient |
| `bash tests/test_validation.sh` | 10:02:08.942 | 10:11:37.032 | 568.1 s | Intentionally stopped; not a pass |
| `bash tests/.canary.literal.sh` | 10:04:40.146 | 10:14:26.164 | 586.0 s | Passed; temporary script removed |
| Direct yq exact-literal assertion | 10:13:51.746 | 10:14:26.164 | 34.4 s | Passed |

These spans include launch approval and time until the next completion poll;
they are **not exact subprocess runtimes**, and overlapping rows must not be
added together. The fresh 32.727-second probe above is a separate direct timing.
See [the 38-call CSV](chunk-1-call-log.csv) for individual outer-call timings and
nested-call quantities. Only task command summaries and tool metadata were
exported; unrelated session content was not copied.
