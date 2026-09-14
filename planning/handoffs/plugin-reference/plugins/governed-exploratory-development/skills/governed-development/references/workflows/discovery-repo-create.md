# Internal Workflow: Discovery Repo Creation

1. Confirm Local Project Configuration and clean enough source state for snapshotting.
2. Allocate the next `DISC-xxxx` ID with collision protection.
3. Interview: Full vs Curated Governance Artifacts, Discovery Type, framing, Product access, charter, optional comparison.
4. For Curated mode, conduct the per-artifact include/exclude interview with relevance and pros/cons.
5. Create a local repo using the sequential ID and slug.
6. Generate `AGENTS.md`, `DISCOVERY.yaml`, `.governance/SNAPSHOT.yaml`, and selected immutable artifacts only.
7. Initialize Git but do not commit or publish.
8. Validate schemas, snapshot integrity, minimal scaffold, and access-mode leaks.
9. Show results and a suggested commit message.
