# AGENTS.md — Discovery Repo

> Generated initially by the `governed-exploratory-development` plugin version `{{PLUGIN_VERSION}}` on `{{GENERATED_AT}}`. This repository owns this file after generation; do not expect automatic synchronization.

## Repository role

This Discovery Repo investigates its approved charter under a fixed Governance
revision. `.governance/` is a read-only submodule. Its purpose is learning, not
automatic production delivery.

## First actions

1. Read `DISCOVERY.yaml` and `GOVERNANCE-READING-SCOPE.yaml` before any Governance artifact bodies or nested instructions.
2. Validate that their source, commit, and scope agree with the submodule and parent Git link. For a newly initialized repo, distinguish the staged pending pin from a committed pin. Surface dirty or unexpected submodule state without resetting it.
3. Apply the reading rules below, then read the Constitution and other permitted artifacts.
4. Restate the objective, question, success criteria, and non-goals before implementing.

## Governance Reading Scope

The full Governance tree is present; file presence is not reading permission.

- Full permits artifact bodies at the pinned commit only when Product Access Mode also permits them.
- Curated permits only paths recorded as `allow`. Excluded and unlisted bodies must not be read, searched, summarized, or retrieved indirectly.
- Apply these rules to filesystem reads, repository-wide searches, Git object access, connectors, linked documents, nested `AGENTS.md` files, summaries, and any delegated work. Restrict tool inputs to allowed paths before execution. Do not use history or another checkout to bypass the scope.
- Path names and minimal authority metadata (ID, title, class, supersession links) may be inspected for the selection interview and source-wide validation. Do not read excluded bodies to assess whether they are safe.
- Always allow the Constitution. Selection cannot remove obligations or reactivate superseded requirements. Resolve uncertainty through the developer; do not silently broaden the scope.
- Changes require explicit amended scope choices and a rationale. Preserve previous review scope and any exposure in durable reports. Editing this instruction file alone grants no new permission.

These are agent and workflow boundaries, not a hard filesystem sandbox.

## Governance

Apply Constitution > Policies > Specifications > Active ADRs. Conformance Proofs
and non-normative records do not create requirements. Do not edit `.governance/`
or advance its pin. A different Governance revision requires a successor Repo.

## Product access

Selected mode: `{{PRODUCT_ACCESS_MODE}}`.

- `isolated`: do not inspect Product implementation or previous Discovery Repo implementations through any transport, including Product-derived content stored in Governance.
- `contract-aware`: use only explicitly approved public exports under `.contracts/` or approved charter references; no implementation internals or history.
- `full-reference`: Product implementation inspection is permitted, but do not modify Product from this repo. Governance Reading Scope remains applicable.

If accidental exposure violates either boundary, stop, surface it, and record
whether the investigation's clean-room claim remains valid.

## Discovery Repo discipline

- Follow the recorded framing and charter; do not expand non-goals without approval.
- Record failed approaches, uncertainty, and conflicting Governance interpretations.
- Prefer Conformance Proofs over claims.
- Creation may stage only `.gitmodules` and the Governance Git link and configure the required local submodule connection. Do not stage other files, create commits, or publish. Later work does not repeat this initialization allowance.

## Completion

Use Discovery Review. Generate and surface the durable Discovery Report before
Archive, Report + Delete, or Keep Active. Record both promotion choices and
retention independently, along with the pinned revision and reading scope used.
