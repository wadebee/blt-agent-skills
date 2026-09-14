# Internal Workflow: Project Setup

1. Inspect the current filesystem and Git metadata for likely Product/Governance repos and submodule path.
2. Present inferred values as suggestions, not assumptions.
3. Interview one field at a time: project name, Product path, Governance path, Product Governance-submodule path, Discovery Implementation parent path.
4. Validate both repos and the submodule relationship.
5. Generate role-specific `AGENTS.md` only when absent or after explicit overwrite approval.
6. Record workstation paths in plugin-local configuration.
7. Show all changes; do not commit.

Failure conditions: ambiguous repo role, inaccessible path, non-Git directory, conflicting existing Local Project Configuration, or unsafe overwrite.
