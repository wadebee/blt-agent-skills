# Governance Repository Reference Layout

```text
<project>-governance/
├── AGENTS.md
├── constitution/
│   └── constitution.md
├── policies/
├── specs/
├── adr/
├── conformance/
├── discoveries/
│   ├── DISC-0001.md
│   └── SYNTH-0001.md
└── proposals/
    ├── pending/
    │   └── GOVP-0002.md
    └── resolved/
        └── GOVP-0001.md
```

## Ownership

- Normative authority: `constitution/`, `policies/`, `specs/`, active `adr/`
- Derived evidence: `conformance/`
- Non-normative evidence: `discoveries/`, `proposals/`

Do not place generic Agent Skill implementation in this repo.
