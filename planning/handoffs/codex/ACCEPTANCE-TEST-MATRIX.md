# Acceptance Test Matrix

| ID | Scenario | Expected result |
|---|---|---|
| AT-001 | Invoke router in an existing Product repo without local configuration | Router infers Project Activation and asks for confirmation/required fields without listing internal workflows |
| AT-002 | Set up valid Product/Governance pair | Local Project Configuration written; role `AGENTS.md` generated only when safe; submodule validated |
| AT-003 | Existing `AGENTS.md` present | No overwrite without explicit approval |
| AT-004 | Create Discovery Repo with Full Governance Reading Scope | Complete Governance submodule initialized at exact commit; Full reading scope recorded; minimal repo produced |
| AT-005 | Create Discovery Repo with Curated Governance Reading Scope | Complete submodule retained; per-path allow/exclude interview and reading record produced; excluded/unlisted bodies remain unread |
| AT-006 | Developer rejects recommendation | Explicit choice is honored and recorded |
| AT-007 | Isolated Discovery Repo contains Product remote/seed file | Validation fails or surfaces contamination before completion |
| AT-008 | Contract-aware Discovery Repo | Only approved Product exports are supplied under `.contracts/`; Product-derived Governance bodies are read only if both access mode and reading scope permit them |
| AT-009 | Governance changes during Discovery Repo | Existing Governance pin and reading scope remain unchanged; successor is offered |
| AT-010 | Discovery Review request | Durable record is surfaced before Discovery Disposition choices |
| AT-011 | Report + Delete selected | Record remains; no remote deletion is attempted |
| AT-012 | Related Discovery Repos found | Discovery Comparison is recommended but not forced |
| AT-013 | Governance proposal generated | Stored pending and non-normative; no normative edit occurs |
| AT-014 | Proposal rejected | Moved to resolved with rejection metadata and preserved rationale |
| AT-015 | Proposal accepted | Separate normative edit prepared and Product impact assessment required |
| AT-016 | Promote Discovery code | Transplant/Adapt/Reimplement recommendation and explicit selection |
| AT-017 | Adopt Governance with failing checks | Skill recommends defer and leaves developer in control |
| AT-018 | Adopt Governance with passing checks | Submodule pointer may change; no commit created |
| AT-019 | Workflow modifies files | Staged/unstaged summary shown; only initial Governance/Product creation makes approved initial commits; Discovery stages only `.gitmodules` and its Governance Git link and creates no commit; later workflows preserve the index |
| AT-020 | Shimmy bootstrap unknown | Onboarding stops; no guessed bootstrap command |
| AT-021 | Shimmy bootstrap known | Product-owned bootstrap invoked after approval and result validated |
| AT-022 | Proposal or Discovery Report cited as authority | Agent rejects that interpretation and identifies correct artifact class |
| AT-023 | Conformance conflicts with Specification | Conflict surfaced; test is not automatically treated as authority |
| AT-024 | Same-level supersession present | Active artifact resolves deterministically |
| AT-025 | Concurrent Discovery Repo creation | IDs remain unique or one operation fails safely without partial repo |
| AT-026 | Select both Discovery Governance Promotion and Discovery Code Promotion, then Archive | Both promotion decisions and the independent retention choice are recorded in the Discovery Report; neither promotion implies the other or automatic Governance adoption |
| AT-027 | Discovery Review selects Keep Active | Discovery Report persists, manifest stays active, and promotion decisions do not force closure |
| AT-028 | Failed benchmark or observation unrelated to requirements | Preserved as Conformance Proofs with limitations; no successful-conformance or normative-authority claim is inferred |
| AT-029 | Generated instructions and a derived check use pinned Governance | Instructions remain repository-owned and subordinate to Governance and reading scope; pin stays fixed; the check supplies Conformance Proofs without creating requirements |
| AT-030 | Curated scope excludes a local report; agent attempts search, Git show, link traversal, or a summary through another tool | Body access is refused before execution across all transports; minimal authority metadata alone remains available for validation |
| AT-031 | Discovery submodule checkout differs from recorded pin or has modified/untracked/ignored files | Discrepancy surfaced; no silent reset, stage, commit, or pin advancement; retained source commit supports initialization in a fresh clone |
| AT-032 | Reading scope is missing, belongs to another commit, omits Constitution, or has duplicate/unsafe paths | Validation fails before Governance body reads; no fallback to Full; source-wide supersession still governs excluded artifacts |
| AT-033 | Agent resumes with edited instructions or a request to broaden Curated scope | Existing scope remains binding; a change requires explicit affected choices and rationale; prior review scope and exposure are preserved |
