# Internal Workflow: Governance Adoption by Product

1. Identify Product's current Governance context and the proposed target revision.
2. Review intervening accepted changes, Product Impact Assessments, implementation, conformance updates, relevant tests and incompatibilities. Recommend adopt or defer; the developer decides.
3. Before approved changes, journal previous affected state and the target in the workflow-owned local operation record.
4. Update Product's Governance submodule checkout and `.governed/governance.yaml` to the approved target. Preserve HEAD, index and unrelated edits; do not stage, commit, or edit Governance through the submodule.
5. Resume inspects completed effects and finishes missing steps. Roll back restores only unchanged operation-owned effects. Preserve subsequent user edits, staging or commits and ask for direction if safe recovery is prevented; never reset them automatically.
6. Report successful local adoption pending commit only when both checkout and manifest agree with the target. Otherwise report incomplete adoption. Follow the approved journal lifecycle; no ongoing monitoring is involved.
7. Preserve all Discovery Repos and their independently fixed Governance contexts. Adoption does not imply a Product release or certification of conformance.
