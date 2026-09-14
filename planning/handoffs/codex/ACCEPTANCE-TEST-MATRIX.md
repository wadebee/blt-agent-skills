# Acceptance Test Matrix

| ID | Scenario | Expected result |
|---|---|---|
| AT-001 | Invoke router in unregistered Product repo | Router infers onboarding and asks for confirmation/required fields without listing internal workflows |
| AT-002 | Onboard valid Product/Governance pair | Local registration written; role `AGENTS.md` generated only when safe; submodule validated |
| AT-003 | Existing `AGENTS.md` present | No overwrite without explicit approval |
| AT-004 | Create Discovery with Full Governance | Complete snapshot copied, exact commit recorded, minimal repo produced |
| AT-005 | Create Discovery with Curated Governance | Per-artifact interview and selection record produced |
| AT-006 | Developer rejects recommendation | Explicit choice is honored and recorded |
| AT-007 | Isolated Discovery contains Product remote/seed file | Validation fails or surfaces contamination before completion |
| AT-008 | Contract-aware Discovery | Only approved contract export is present; internals absent |
| AT-009 | Governance changes during experiment | Existing snapshot remains unchanged; successor is offered |
| AT-010 | Closeout request | Durable record is surfaced before disposition choices |
| AT-011 | Record + Delete selected | Record remains; no remote deletion is attempted |
| AT-012 | Related Discoveries found | Synthesis is recommended but not forced |
| AT-013 | Governance proposal generated | Stored pending and non-normative; no normative edit occurs |
| AT-014 | Proposal rejected | Moved to resolved with rejection metadata and preserved rationale |
| AT-015 | Proposal accepted | Separate normative edit prepared and Product impact assessment required |
| AT-016 | Promote Discovery code | Transplant/Adapt/Reimplement recommendation and explicit selection |
| AT-017 | Adopt Governance with failing checks | Skill recommends defer and leaves developer in control |
| AT-018 | Adopt Governance with passing checks | Submodule pointer may change; no commit created |
| AT-019 | Any workflow modifies files | Diff/summary shown and no Git commit exists |
| AT-020 | Shimmy bootstrap unknown | Onboarding stops; no guessed bootstrap command |
| AT-021 | Shimmy bootstrap known | Product-owned bootstrap invoked after approval and result validated |
| AT-022 | Proposal or Discovery record cited as authority | Agent rejects that interpretation and identifies correct artifact class |
| AT-023 | Conformance conflicts with Specification | Conflict surfaced; test is not automatically treated as authority |
| AT-024 | Same-level supersession present | Active artifact resolves deterministically |
| AT-025 | Concurrent Discovery creation | IDs remain unique or one operation fails safely without partial repo |
