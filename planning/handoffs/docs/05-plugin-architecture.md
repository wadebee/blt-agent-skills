# Beeline-Technologies Plugin Architecture

## Marketplace boundary

`Beeline-Technologies` is an independent Agent Plugin marketplace repository. The repository is the catalog boundary; each plugin remains a coherent installation and capability boundary.

```text
Beeline-Technologies/
├── .agents/plugins/marketplace.json
└── plugins/
    ├── governed-exploratory-development/
    ├── shimmy-onboarding/
    └── <unrelated sibling plugins>/
```

Do not combine unrelated capabilities into one catch-all plugin.

## Plugin 1: governed-exploratory-development

### Public surface

Expose one obvious public skill:

```text
governed-development
```

The user should express intent naturally. The router infers the likely lifecycle operation and hides internal workflow names.

Examples:

- “Set this project up for governed exploration.” → project onboarding
- “Explore an alternate engine lifecycle.” → Discovery creation
- “Governance changed; continue the experiment.” → successor Discovery
- “Wrap up this experiment.” → closeout
- “Compare these experiments.” → synthesis
- “Turn this finding into project policy.” → Governance proposal
- “Accept or reject this proposal.” → proposal resolution
- “Move this implementation into Product.” → code promotion
- “Update Product to the new Governance revision.” → Governance adoption

When intent is ambiguous, explain the inferred workflow in plain language and ask one concise clarification. Never present a menu of internal skill names as the primary user experience.

### Internal modularity

In version 1, internal workflows should be supporting references under the public skill rather than independently discoverable skills:

```text
skills/governed-development/
├── SKILL.md
├── references/workflows/
│   ├── project-onboard.md
│   ├── discovery-create.md
│   ├── discovery-successor.md
│   ├── discovery-closeout.md
│   ├── discovery-synthesize.md
│   ├── governance-propose.md
│   ├── governance-resolve.md
│   ├── product-promote.md
│   └── governance-adopt.md
├── scripts/
└── assets/
```

This realizes “one router with modular internal workflows” without forcing users or skill discovery to understand the lifecycle taxonomy.

## Plugin 2: shimmy-onboarding

The Shimmy bootstrap script remains owned by the Shimmy Product repository. The onboarding plugin must not duplicate or fork bootstrap logic.

The skill should:

1. determine the intended Shimmy source/release context;
2. locate the Product-owned bootstrap entrypoint from authoritative Product documentation or repository contents;
3. explain material effects and prerequisites;
4. invoke that bootstrap only after appropriate user authorization;
5. validate the resulting installation; and
6. optionally hand off to governed project onboarding when the user is developing Shimmy rather than merely installing it.

If the bootstrap entrypoint cannot be established from Product sources, stop and surface the missing contract. Do not invent a command.

## `AGENTS.md` seed-and-transfer

The governed-development plugin generates the initial role-specific `AGENTS.md` during project onboarding or Discovery creation. It then transfers ownership to the repository.

Rules:

- existing files are not automatically regenerated;
- later plugin versions affect newly generated repos only;
- generated files record originating plugin/version metadata;
- humans and agents may evolve them normally;
- cross-repository workflow invariants remain enforced by the plugin workflow, not by assuming `AGENTS.md` stayed unchanged.

## Local project registration

Workstation-specific metadata lives in user-local plugin storage, not a repository. It includes project name, Product path, Governance path, Product submodule path, and Discovery parent directory.

Another workstation repeats onboarding. Repository-intrinsic state remains committed in the repos.

The concrete local path is an implementation detail; code must use the plugin runtime’s writable data location when available.

## Git boundary

Skills may:

- initialize local Git repositories;
- create and modify files;
- stage nothing by default;
- validate working-tree state;
- show diffs and suggested commit messages.

Skills must not:

- create commits automatically;
- push or publish repositories;
- archive or delete remote repositories;
- assume GitHub-specific workflows in version 1.
