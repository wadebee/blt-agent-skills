# Internal Workflow: Project Activation

Connect an existing Product/Governance pair for use on this workstation. This does not create the initial repositories or perform Governance Adoption.

1. Inspect available context and Git metadata for likely existing Product/Governance repositories and their submodule relationship.
2. Present inferred values as suggestions; establish or reuse confirmed project identity, paths and Local Project Configuration.
3. Interview one missing decision at a time: project name, Product path, Governance path, Product Governance-submodule path, and Discovery Repo parent path.
4. Validate the relevant existing relationship while preserving files, pins, index and history. Ordinary unrelated unfinished edits are allowed. Activation may proceed while an intentional Governance Adoption is locally applied but uncommitted, whether unstaged or staged by the developer. Establish intent from an existing approval or user confirmation, require valid source/relationship and clean Governance contents, and distinguish the committed revision from the pending revision. Preserve both; Activation does not perform adoption or certify conformance.
5. Generate role-specific `AGENTS.md` only when absent and safe; preserve existing instructions unless an explicit reviewed change is requested.
6. Save workstation paths in plugin-local configuration. Reuse valid configuration on later invocations; missing configuration alone does not authorize creating repositories.
7. Show changes and limitations. Do not stage, commit, initialize replacement repositories or repair the relationship automatically.

Failure conditions: ambiguous repository identity/role, inaccessible path, non-Git directory, conflicting Local Project Configuration, unsafe overwrite, or unresolved relevant Governance relationship state. This workflow is not continuous monitoring. Discovery creation does not rerun Activation or depend on Product adoption readiness once the project is connected.
