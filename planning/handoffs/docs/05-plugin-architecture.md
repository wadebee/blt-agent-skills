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

- “Set this project up for governed exploration.” → Project Setup
- “Explore an alternate engine lifecycle.” → Discovery Repo creation
- “Governance changed; continue the Discovery Repo.” → successor Discovery Repo
- “Wrap up this Discovery Repo.” → Discovery Review
- “Compare these Discovery Repos.” → Discovery Comparison
- “Turn this finding into project policy.” → Governance proposal
- “Accept or reject this proposal.” → proposal resolution
- “Move this implementation into Product.” → Discovery Code Promotion
- “Update Product to the new Governance revision.” → Governance adoption

When intent is ambiguous, explain the inferred workflow in plain language and ask one concise clarification. Never present a menu of internal skill names as the primary user experience.

### Internal modularity

In version 1, internal workflows should be supporting references under the public skill rather than independently discoverable skills:

```text
skills/governed-development/
├── SKILL.md
├── references/workflows/
│   ├── project-setup.md
│   ├── discovery-repo-create.md
│   ├── discovery-repo-successor.md
│   ├── discovery-review.md
│   ├── discovery-compare.md
│   ├── discovery-governance-promote.md
│   ├── governance-resolve.md
│   ├── discovery-code-promote.md
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
6. optionally hand off to governed Project Setup when the user is developing Shimmy rather than merely installing it.

If the bootstrap entrypoint cannot be established from Product sources, stop and surface the missing contract. Do not invent a command.

## Materialized Governance

Materialized Governance includes generated instructions and other artifacts derived from Governance. Materialization does not add authority. Product and Discovery consume versioned source through read-only Governance submodules; Discovery reading scope is an independent agent boundary. Derived checks remain Conformance Proofs.

The governed-development plugin generates the initial role-specific `AGENTS.md` during Project Setup or Discovery Repo creation. It then transfers ownership to the repository.

Rules:

- existing files are not automatically regenerated;
- later plugin versions affect newly generated repos only;
- generated files record originating plugin/version metadata;
- humans and agents may evolve them normally;
- cross-repository workflow invariants remain enforced by the plugin workflow, not by assuming `AGENTS.md` stayed unchanged.

## Local project configuration

Workstation-specific metadata lives in user-local plugin storage, not a repository. It includes project name, Product path, Governance path, Product submodule path, and Discovery Repo parent directory.

Another workstation repeats Project Setup. Repository-intrinsic state remains committed in the repos.

The concrete local path is an implementation detail; code must use the plugin runtime’s writable data location when available.

## Git boundary

The capability follows Decision 30 and the authoritative plan. Initial project creation may stage approved generated files, create one initial commit in each newly created Governance/Product repository, and establish their local submodule connection. Existing-project registration preserves history, index, and pins.

Discovery creation may configure its local Governance submodule and stage only `.gitmodules` and its Governance Git link. It creates no commit and adds no Product remote. Other generated Discovery files remain unstaged. Later workflows do not stage, commit, or advance Discovery pins.

Show staged and unstaged changes separately for review. Never push, publish, archive, or delete remote repositories. Marketplace Git permissions and disposable fixture setup are defined independently by root guidance.
