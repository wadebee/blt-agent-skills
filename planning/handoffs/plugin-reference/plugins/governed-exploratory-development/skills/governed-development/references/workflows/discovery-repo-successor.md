# Internal Workflow: Discovery Repo Successor

1. Read the predecessor manifest and durable record if present.
2. Confirm the Governance change is material enough to require a successor.
3. Allocate a new ID and run the normal creation interview, pre-filling relevant charter information.
4. Require `derived_from` and `successor_reason`.
5. Never alter the predecessor snapshot or rewrite its history.
6. Validate and show changes without committing.
