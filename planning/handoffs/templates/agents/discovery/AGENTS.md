# AGENTS.md — Discovery Repository

> Generated initially by the `governed-exploratory-development` plugin version `{{PLUGIN_VERSION}}` on `{{GENERATED_AT}}`. This repository owns this file after generation; do not expect automatic synchronization.

## Repository role

This repository is an isolated experiment governed by `DISCOVERY.yaml` and the immutable snapshot under `.governance/`. Its purpose is learning, not automatic production delivery.

## First actions

1. Read `DISCOVERY.yaml` completely.
2. Read `.governance/SNAPSHOT.yaml`.
3. Apply the recorded authority model.
4. Restate the research question, success criteria, and non-goals before implementing.

## Governance

Apply Constitution > Policies > Specifications > Active ADRs. Conformance is derived evidence. Non-normative records do not create requirements.

Do not modify `.governance/`. If the Governance baseline must change, create a successor Discovery rather than refreshing this repository.

## Product access

Selected mode: `{{PRODUCT_ACCESS_MODE}}`.

- `isolated`: do not inspect Product implementation or previous Discoveries through any transport.
- `contract-aware`: use only the explicitly exported contract material included or referenced by the charter.
- `full-reference`: Product implementation inspection is permitted, but do not modify Product from this repo.

If accidental exposure violates the selected mode, stop, surface it, and record whether the experiment’s clean-room claim remains valid.

## Experimental discipline

- Optimize according to the recorded framing, not unstated preferences.
- Treat type metadata as descriptive; the charter is authoritative.
- Do not expand into non-goals without developer approval.
- Record important failed approaches and ambiguous Governance interpretations.
- Prefer evidence over claims.
- Do not create Git commits automatically.

## Completion

Use the closeout workflow. A durable Discovery Record must be generated and surfaced before Archive, Record + Delete, or Keep Active is selected. Knowledge promotion and code promotion are separate decisions.
