# System Acceptance Criteria

## User experience

- A user can invoke one public governed-development skill without knowing lifecycle workflow names.
- The router infers likely intent and uses a concise interview.
- Every required choice includes a short synopsis and context-sensitive recommendation.
- A recommendation never silently becomes the developer’s decision.
- Interviews proceed one decision at a time.

## Governance

- The implementation enforces the authority ordering Constitution > Policies > Specifications > Active ADRs.
- Same-level supersession can be resolved from minimal metadata.
- Conformance Proofs, Discovery Reports, Discovery Comparisons, and proposals cannot be mistaken for normative authority.
- Proposal presence in the Governance repo never makes it authoritative.

## Project Setup

- Product and Governance paths are confirmed explicitly.
- Product’s Governance submodule is validated and treated as read-only.
- Role-specific `AGENTS.md` files are generated once and are not later synchronized.
- Workstation-specific paths remain outside committed repositories.

## Discovery Implementation creation

- A new repo contains only `AGENTS.md`, `DISCOVERY.yaml`, `.governance/`, and Git administrative data.
- The Governance source commit is exact and recorded.
- Full vs Curated is an explicit developer choice.
- Curated selection records inclusion and materially relevant exclusion decisions.
- Type, framing, Product access, charter, and optional comparison are captured.
- Isolated and Contract-aware guardrails apply regardless of information transport.
- No remote repository is created or modified.

## Discovery Implementation continuation and Discovery Review

- Governance snapshot content cannot be silently refreshed.
- A changed Governance baseline creates a successor with `derived_from` and reason.
- Discovery Review always generates and surfaces a durable record before Discovery Disposition.
- Repository retention (Archive, Report + Delete, or Keep Active) is independent of Discovery Code Promotion and Discovery Governance Promotion. Both promotions may be selected.
- Keep Active preserves active status even after reports or promotion decisions exist.
- Related Discovery Implementations trigger a recommendation, not mandatory Discovery Comparison.

## Promotion

- Discovery Governance Promotion and Discovery Code Promotion are independent forms of Discovery Disposition.
- Normative Governance changes require human approval.
- Accepted proposals require Product impact assessment.
- Discovery Code Promotion presents Transplant, Adapt, and Reimplement with a recommendation.
- Governance adoption checks implementation, conformance, tests, and incompatibilities.

## Git behavior

- Skills never create commits.
- Skills may show suggested commit messages.
- Dirty working trees are detected and handled without destructive overwrite.
- Generated changes are reviewable before any developer Git action.

## Shimmy onboarding

- The skill delegates to Product-owned bootstrap logic.
- The skill never contains an independent copy of Shimmy installation behavior.
- Bootstrap ambiguity stops the workflow rather than producing a guessed command.

## Materialized Governance and Conformance Proofs

- Materialized Governance includes snapshots, generated instructions, and other Governance-derived artifacts without adding authority.
- Snapshot immutability and repository ownership of generated instructions remain distinct update rules.
- Conformance Proofs preserve negative results, uncertainty, and material unrelated to requirements; their name does not imply certainty or successful conformance.
