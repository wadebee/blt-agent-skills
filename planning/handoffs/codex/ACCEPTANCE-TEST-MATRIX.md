# Acceptance Test Matrix

| ID | Scenario | Expected result |
|---|---|---|
| AT-001 | Invoke router in unregistered Product repo | Router infers Project Setup and asks for confirmation/required fields without listing internal workflows |
| AT-002 | Set up valid Product/Governance pair | Local Project Configuration written; role `AGENTS.md` generated only when safe; submodule validated |
| AT-003 | Existing `AGENTS.md` present | No overwrite without explicit approval |
| AT-004 | Create Discovery Implementation with Full Governance Artifacts | Complete snapshot copied, exact commit recorded, minimal repo produced |
| AT-005 | Create Discovery Implementation with Curated Governance Artifacts | Per-artifact interview and selection record produced |
| AT-006 | Developer rejects recommendation | Explicit choice is honored and recorded |
| AT-007 | Isolated Discovery Implementation contains Product remote/seed file | Validation fails or surfaces contamination before completion |
| AT-008 | Contract-aware Discovery Implementation | Only approved contract export is present; internals absent |
| AT-009 | Governance changes during Discovery Implementation | Existing snapshot remains unchanged; successor is offered |
| AT-010 | Discovery Review request | Durable record is surfaced before Discovery Disposition choices |
| AT-011 | Report + Delete selected | Record remains; no remote deletion is attempted |
| AT-012 | Related Discovery Implementations found | Discovery Comparison is recommended but not forced |
| AT-013 | Governance proposal generated | Stored pending and non-normative; no normative edit occurs |
| AT-014 | Proposal rejected | Moved to resolved with rejection metadata and preserved rationale |
| AT-015 | Proposal accepted | Separate normative edit prepared and Product impact assessment required |
| AT-016 | Promote Discovery code | Transplant/Adapt/Reimplement recommendation and explicit selection |
| AT-017 | Adopt Governance with failing checks | Skill recommends defer and leaves developer in control |
| AT-018 | Adopt Governance with passing checks | Submodule pointer may change; no commit created |
| AT-019 | Any workflow modifies files | Diff/summary shown and no Git commit exists |
| AT-020 | Shimmy bootstrap unknown | Onboarding stops; no guessed bootstrap command |
| AT-021 | Shimmy bootstrap known | Product-owned bootstrap invoked after approval and result validated |
| AT-022 | Proposal or Discovery Report cited as authority | Agent rejects that interpretation and identifies correct artifact class |
| AT-023 | Conformance conflicts with Specification | Conflict surfaced; test is not automatically treated as authority |
| AT-024 | Same-level supersession present | Active artifact resolves deterministically |
| AT-025 | Concurrent Discovery Implementation creation | IDs remain unique or one operation fails safely without partial repo |
| AT-026 | Select both Discovery Governance Promotion and Discovery Code Promotion, then Archive | Both promotion decisions and the independent retention choice are recorded in the Discovery Report; neither promotion implies the other or automatic Governance adoption |
| AT-027 | Discovery Review selects Keep Active | Discovery Report persists, manifest stays active, and promotion decisions do not force closure |
| AT-028 | Failed benchmark or observation unrelated to requirements | Preserved as Conformance Proofs with limitations; no successful-conformance or normative-authority claim is inferred |
| AT-029 | Materialized Governance contains a snapshot, generated instructions, and a derived check | Snapshot remains immutable with original authority classifications; instructions remain repository-owned and subordinate; the check supplies Conformance Proofs without creating requirements |
