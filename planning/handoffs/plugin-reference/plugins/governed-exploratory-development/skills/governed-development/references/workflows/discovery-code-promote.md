# Internal Workflow: Discovery Code Promotion

1. Confirm the Discovery Code Promotion choice independently of Discovery Governance Promotion and repository retention.
2. Handoff the Discovery Report, approved source code/design, relevant Conformance Proofs, source identity/revision and applicable access/exposure history to a separate Product-scoped work session.
3. Inspect Product there and evaluate quality, dependencies, tests, conventions, security, portability, integration, shortcuts and migration. Do not inspect Product from the ongoing isolated Discovery context.
4. Recommend Transplant, Adapt or Reimplement with concise rationale and require developer selection.
5. Apply only approved Product working-tree changes, preserve existing edits, and run relevant checks. Report results and limitations in Product context.
6. Preserve provenance and the original Discovery Repo. Do not feed Product internals or integration findings back into its isolated investigation. Governance Adoption and retention remain separate decisions. Do not stage or commit.
