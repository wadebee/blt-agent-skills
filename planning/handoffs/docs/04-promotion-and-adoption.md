# Promotion and Adoption

## Separate decisions

```text
Discovery
   ├── Knowledge promotion ──► Governance proposal ──► human decision
   └── Code promotion ───────► Product review ───────► human decision
```

A useful finding does not imply useful production code. Good experimental code does not automatically justify a Governance change.

## Knowledge promotion

The agent generates a structured proposal that distinguishes:

- **Finding** — what was observed;
- **Evidence** — why the finding is credible;
- **Implication** — why project intent may need to change;
- **Target** — Constitution, Policy, Specification, ADR, or none;
- **Suggested change** — concrete proposed modification;
- **Source** — Discovery or synthesis identifiers.

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

## Code promotion

When the developer approves code promotion, conduct an interview and recommend:

### Transplant

Copy or cherry-pick code because it is already production-quality and fits Product architecture with minimal risk.

### Adapt

Reuse selected code while refactoring dependencies, structure, tests, error handling, security, portability, or integration behavior.

### Reimplement

Preserve the accepted design and behavior but implement it fresh inside Product because the experimental code carries shortcuts, assumptions, or architecture unsuitable for production.

The recommendation evaluates:

- test quality;
- dependency choices;
- Product conventions;
- security and portability;
- integration risk;
- experimental shortcuts;
- clean-room assumptions;
- migration implications; and
- whether the code relies on a context unavailable in Product.

The developer makes the final decision.

## Governance adoption by Product

Product does not automatically track Governance. Before advancing the pinned submodule, conduct a conformance-ready review:

- Product-impact items addressed;
- required implementation changes complete;
- derived conformance artifacts updated;
- relevant tests pass;
- known incompatibilities documented.

The skill recommends against advancement when evidence is incomplete, but the developer retains final control. The skill modifies and validates the submodule pointer only when asked; it never commits the change.
