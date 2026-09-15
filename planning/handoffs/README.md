# Governed Exploratory Agentic Development

**Durable design package for Codex implementation**  
Design baseline: **2026-09-14**  
Target marketplace repository: **`Beeline-Technologies`**

## Purpose

This package specifies a reusable workflow for software projects that separate:

1. authoritative project governance;
2. the releasable Product implementation; and
3. isolated Discovery Repos used for clean-room Discovery Repos, proofs of concept, benchmarks, and competing designs.

The workflow is implemented as Agent Plugins in the independent `Beeline-Technologies` marketplace repository. The generic plugin is not Shimmy-specific. A separate sibling plugin automates Shimmy onboarding while delegating installation to the Product-owned Shimmy bootstrap logic.

[GLOSSARY.md](../../GLOSSARY.md) is authoritative for terminology. The user-approved terminology alignment updates this package without authorizing a production implementation milestone.

## Start here

Codex should read these files in order:

1. [`codex/IMPLEMENTATION-BRIEF.md`](codex/IMPLEMENTATION-BRIEF.md)
2. [`docs/01-architecture.md`](docs/01-architecture.md)
3. [`decisions/DECISIONS.md`](decisions/DECISIONS.md)
4. [`docs/05-plugin-architecture.md`](docs/05-plugin-architecture.md)
5. [`codex/IMPLEMENTATION-PHASES.md`](codex/IMPLEMENTATION-PHASES.md)
6. [`codex/ACCEPTANCE-TEST-MATRIX.md`](codex/ACCEPTANCE-TEST-MATRIX.md)

## Non-negotiable design constraints

- Governance, Product, and Discovery Repo remain separate Git repositories.
- Governance Artifacts include a narrow Constitution plus policies, specifications, ADRs, Conformance Proofs, Discovery Reports, Discovery Comparisons, and proposals; only explicitly normative artifact classes have authority.
- Normative precedence is: **Constitution > Policies > Specifications > Active ADRs**.
- Conformance Proofs are derived evidence, not independent authority.
- Product and Discovery Repos independently pin Governance through read-only Git submodules.
- Full and Curated Governance Reading Scope control permitted agent reads over the complete pinned tree.
- A Governance revision change creates a successor Discovery Repo while preserving the predecessor’s pin and reading scope.
- Discovery Governance Promotion and Discovery Code Promotion are independent decisions.
- Humans approve all promotions into normative Governance.
- The plugin must make context-sensitive recommendations, but required choices remain explicit developer decisions.
- New Discovery Repos begin with `AGENTS.md`, `DISCOVERY.yaml`, `GOVERNANCE-READING-SCOPE.yaml`, `.gitmodules`, and the `.governance/` submodule; Contract-aware mode alone adds `.contracts/`.
- The public governed-development experience is one context-aware router skill; lifecycle modules are hidden implementation details.
- Initial Governance/Product creation may make its approved initial commits. Discovery initialization stages only its submodule relationship and leaves the repository uncommitted.
- Remote Git hosting is outside the first implementation; repository creation is local only.
- Generated role-specific `AGENTS.md` files are seeded once, then owned and evolved independently by their repositories.

## Deliverables in this package

- Full architecture and governance model
- 36 active design decisions and one retired decision number with rationale
- Governance, Product, and Discovery Repo `AGENTS.md` templates
- `DISCOVERY.yaml` and reading-scope templates with JSON Schemas
- Discovery Repo, Discovery Comparison, and Governance-proposal record templates
- Reference layouts for all repository types
- Portable OpenAI Agent Plugin reference skeletons
- Public router and internal workflow specifications
- Shimmy onboarding skill contract
- Codex implementation phases, acceptance tests, and traceability

## Package status

This is an implementation specification, not finished runtime code. Reference plugin files are intentionally valid-looking scaffolds and must be validated against the current OpenAI plugin tooling during implementation. Where product-specific facts are unknown—especially the exact Shimmy bootstrap entrypoint—Codex must inspect the Product repository rather than inventing them.
