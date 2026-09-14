# Product Repository Reference Layout

```text
<project>/
├── AGENTS.md
├── .governance/        # Git submodule pinned to exact Governance commit
├── <product source>
├── <tests>
└── <product-owned bootstrap/install logic>
```

## Ownership

Product owns releasable implementation, runtime behavior, tests, delivery, compatibility, and its bootstrap logic. `.governance/` is read-only from Product workflows.

Generic governed-development Agent Skills do not live here. Product-specific bootstrap implementation remains here even when a sibling plugin automates invoking it.
