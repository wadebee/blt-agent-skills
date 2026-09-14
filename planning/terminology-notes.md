# Terminology source and implementation notes

## Scope and source status

[GLOSSARY.md](../GLOSSARY.md) is authoritative for repository terminology, including the user-approved terminology revision of 2026-09-14. The artifacts share one vocabulary across Governance, Product, Discovery Repo, and workflow delivery; those responsibilities are described through term metadata and the ownership boundaries in the glossary without introducing new implementation modules.

As of 2026-09-14, the repository contains a design handoff, reference scaffolding, and a persisted implementation plan. There is no production plugin or test suite. Behavior described here is specified behavior, not a claim that it is implemented. The [persisted plan](notional/governed-exploratory-development.md#plan-status-and-authorization) remains awaiting implementation authorization; maintaining this glossary does not start an implementation milestone.

The glossary controls terminology and its explicitly defined relationships. For other design and implementation decisions, source precedence within the handoff is [settled decisions](handoffs/decisions/DECISIONS.md), architecture and governance documentation, workflow specifications, templates and schemas, then reference skeletons. Terminology alignment does not authorize production implementation or make this repository Governance for projects using the future plugins. The plan distinguishes approved review decisions from proposed implementation details.

[AGENTS.md](../AGENTS.md) now records the confirmed [planning/handoffs/](handoffs/README.md) location and glossary authority. The user authorized terminology alignment throughout the handoff and existing plan; unrelated implementation constraints remain in force.

## Artifact differences and open details

The [persisted plan's inconsistency register](notional/governed-exploratory-development.md#package-inconsistencies-and-proposed-handling) already identifies the principal reference mismatches. The terminology revision aligns source artifacts with the glossary; unresolved implementation details remain proposed, not completed work.

| Artifact difference or open detail | Model treatment |
|---|---|
| Reference provenance permits workstation paths despite Local Project Configuration; contract storage and content hashing are underspecified. | Keep local configuration distinct from durable provenance. Stable repository identities, separate contract namespaces, and canonical content manifests are proposed implementation details. |
| Inherited scaffolding and Product authority-list drift — resolved. | The layout now requires minimal creation, and the Product template separates implementation from the four authority levels. |
| Proposal metadata and Discovery Review approval-gate drift — resolved. | Pending state is directory-based; Discovery Review surfaces a report before independent Discovery Disposition choices without an extra mandatory approval gate. |
| The plan proposes consumed ID reservations and coordination against one Governance checkout. | Sequential immutable identity is settled. Gaps, reservation storage, recovery, and cross-clone coordination are implementation concerns, not established runtime guarantees. |
| Repeated Discovery Review after Keep Active is not fully specified. | Status, Discovery Disposition, and durable record remain distinct. The exact record update/versioning behavior needs resolution before implementing that case. |
| Marketplace spellings differ: the [Discovery Manifest schema](handoffs/schemas/discovery-manifest.schema.json) uses `Beeline-Technologies`, while the [marketplace reference](handoffs/plugin-reference/.agents/plugins/marketplace.json) uses `beeline-technologies` for `name` and `Beeline Technologies` for display. | Preserve the observed values. Their cross-field identity or normalization contract is not established by this glossary. |
| The Shimmy bootstrap entrypoint is not supplied by the handoff. | Its contract must be established from Product sources before implementation of Shimmy onboarding; do not invent it. |
| Plugin packaging and runtime support require current official validation. | Reference manifests and the plan's earlier verification are design artifacts, not fresh installation evidence. This glossary makes no packaging compatibility claim. |

No new ADR is introduced for the terminology revision. New implementation choices remain subject to the existing review process.

## Authorized terminology and format alignment

The 2026-09-14 revision includes human-facing names, reference filenames, schema fields, and example identifiers. Comparison IDs use `CMPR-*`. The Discovery Manifest uses `discovery_repo` and `governance.artifacts_selection`; snapshot provenance uses `artifacts_selection`. Framing values are `neutral`, `optimize-quality`, `challenge-assumptions`, and `custom`. Comparison targets use `discovery-repo` or `discovery-report` where applicable. Local Project Configuration uses `discovery_repo_parent_path`.

The subsequent user-authorized rename makes **Discovery Repo** the canonical name throughout the repository, including the handoff and planned implementation paths. The term identifies the separate Git repository used for the exploratory effort; its isolation, charter, immutable snapshot, and lifecycle rules remain unchanged. The glossary also preserves the practical distinctions between Findings and Conformance Proofs and between individual Discovery Reports and separate Discovery Comparisons.

These are pre-production reference changes, not a migration of existing project data. Reference schemas retain their initial `1.0` version because no production format has shipped. Immutable snapshots in future project repositories must never be rewritten merely to rename terminology.

Conformance Proofs include all supporting material, even negative results or observations unrelated to requirements. Materialized Governance includes snapshots, generated instructions, and other Governance-derived artifacts, each retaining its applicable authority and update rules. Discovery Code Promotion, Discovery Governance Promotion, and repository retention are independent Discovery Disposition choices.

## Verification of the terminology revision

Checks run on 2026-09-14 using temporary audit scripts; no runtime dependency or production test suite was added.

| Command | Result |
|---|---|
| `python3 /tmp/check_terminology.py` | Passed: 54 repository documents/data files checked for obsolete terms, 262 local Markdown links resolved, and skill workflow targets verified. |
| `ruby /tmp/check_terminology_data.rb` | Passed: 9 JSON/YAML files and 6 Markdown frontmatters parsed; both skills’ metadata checked; renamed template/schema keys, enum values, and comparison metadata agree. |
| `git diff --check` | Passed. |
| Bundled skill-creator `quick_validate.py` | Could not run: the available Python environment lacks PyYAML. Existing Ruby YAML parsing and equivalent frontmatter checks passed instead. |

These are documentation, syntax, and targeted cross-file consistency checks. Full JSON Schema validation, plugin installation, and runtime acceptance tests were not run; the approved `jv` validator and production implementation are not present. AT-026–029 specify the new semantic acceptance cases and are not reported as executed tests.

After the Discovery Repo rename, inline Python checks passed for stale names in all 56 working-tree files and paths, 262 local Markdown links and anchors, 6 JSON files, skill workflow references, and glossary alphabetization. Inline Ruby checks passed for 3 YAML files and agreement of the renamed manifest/configuration keys and comparison enum. `git diff --check` also passed. These checks do not constitute full JSON Schema or runtime validation.
