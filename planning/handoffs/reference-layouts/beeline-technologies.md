# Beeline-Technologies Marketplace Reference Layout

```text
Beeline-Technologies/
├── .agents/
│   └── plugins/
│       └── marketplace.json
├── plugins/
│   ├── governed-exploratory-development/
│   │   ├── plugin.json
│   │   └── skills/
│   │       └── governed-development/
│   │           ├── SKILL.md
│   │           ├── references/
│   │           │   └── workflows/
│   │           ├── scripts/
│   │           └── assets/
│   └── shimmy-onboarding/
│       ├── plugin.json
│       └── skills/
│           └── shimmy-onboarding/
│               ├── SKILL.md
│               └── references/
└── tests/
```

The marketplace may contain unrelated sibling plugins, but each plugin must remain coherent and independently installable.
