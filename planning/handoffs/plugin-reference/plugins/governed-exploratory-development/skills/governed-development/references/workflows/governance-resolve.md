# Internal Workflow: Governance Proposal Resolution

1. Present the pending proposal's current wording and relevant authority context.
2. Require a human choice: accept, modify, or reject. Modify revises and surfaces the wording but keeps the proposal pending until that version is explicitly accepted or rejected. Honor explicit combined revision-and-acceptance instructions only when the resulting change is unambiguous.
3. On acceptance or rejection, move the proposal to `proposals/resolved/` and record the resolution against the reviewed wording. Preserve material revisions and supplied rationale; later edits cannot silently inherit acceptance.
4. Acceptance authorizes separate normative edits and requires a Product Impact Assessment. The proposal remains non-normative; moving or resolving it alone does not change requirements.
5. Preserve rejected proposals and supplied rejection reasons. Use conflict-aware writes and the operation journal to recover interruptions without overwriting human edits or fabricating a resolved outcome.
6. Never infer Product Governance Adoption or modify Product or its submodule automatically. Do not commit.
