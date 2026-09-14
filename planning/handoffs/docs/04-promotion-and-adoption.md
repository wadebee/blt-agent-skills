# Promotion and Adoption

## Independent Discovery Disposition choices

Discovery Governance Promotion and Discovery Code Promotion are forms of Discovery Disposition. They are independent of each other and of repository retention (Archive, Report + Delete, or Keep Active). Both promotions may be selected, and either can be declined or deferred.

```text
Discovery Implementation
   ├── Discovery Governance Promotion ──► Governance proposal ──► human decision
   └── Discovery Code Promotion ───────► Product review ───────► human decision
```

A useful finding does not imply useful production code. Good Discovery Implementation code does not automatically justify a Governance change.

## Discovery Governance Promotion

The agent generates a structured proposal that distinguishes:

- **Finding** — what was observed;
- **Conformance Proofs** — why the finding is credible;
- **Implication** — why project intent may need to change;
- **Target** — Constitution, Policy, Specification, ADR, or none;
- **Suggested change** — concrete proposed modification;
- **Source** — Discovery Implementation or Discovery Comparison identifiers.

The proposal is stored under `proposals/pending/`. The agent cannot promote it directly into normative Governance.

### Resolution

A human accepts, modifies, or rejects the proposal. The workflow then:

1. moves it to `proposals/resolved/`;
2. adds minimal resolution metadata;
3. for acceptance, prepares separate normative edits; and
4. requires a Product impact assessment.

## Product impact assessment

Every accepted Governance proposal records one or more impacts:

- None
- Documentation only
- Conformance/tests affected
- Implementation change required
- Migration/backward-compatibility concern
- Unknown — investigation required

The skill summarizes the recommended next action but does not modify Product or advance the submodule automatically.

## Discovery Code Promotion

When the developer approves Discovery Code Promotion, conduct an interview and recommend:

### Transplant

Copy or cherry-pick code because it is already production-quality and fits Product architecture with minimal risk.

### Adapt

Reuse selected code while refactoring dependencies, structure, tests, error handling, security, portability, or integration behavior.

### Reimplement

Preserve the accepted design and behavior but implement it fresh inside Product because the Discovery Implementation code carries shortcuts, assumptions, or architecture unsuitable for production.

The recommendation evaluates:

- test quality;
- dependency choices;
- Product conventions;
- security and portability;
- integration risk;
- shortcuts in the Discovery Implementation;
- clean-room assumptions;
- migration implications; and
- whether the code relies on a context unavailable in Product.

The developer makes the final decision.

## Governance adoption by Product

Product does not automatically track Governance. Before advancing the pinned submodule, conduct a conformance-ready review:

- Product-impact items addressed;
- required implementation changes complete;
- derived Conformance Proofs updated;
- relevant tests pass;
- known incompatibilities documented.

The skill recommends against advancement when Conformance Proofs are incomplete, but the developer retains final control. The skill modifies and validates the submodule pointer only when asked; it never commits the change.
