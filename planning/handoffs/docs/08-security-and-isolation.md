# Security and Isolation

## Scope

Version 1 uses **policy plus workflow guardrails**, not a hard technical sandbox. Its purpose is to prevent accidental architectural anchoring and make violations visible, not to defend against a malicious model with unrestricted credentials.

## Protected boundaries

### Isolated mode

Prohibit Product implementation access through:

- local filesystem paths;
- Git remotes or branches;
- GitHub or other forge connectors;
- web search;
- previous Discovery Repos;
- other agents or generated summaries;
- copied build files, lockfiles, CI, or dependency declarations.

The agent may use Governance artifact bodies permitted by the recorded Governance Reading Scope at the pinned commit, plus public external documentation. Product-derived implementation content in Governance is still subject to the Product access restriction; its presence in the submodule does not grant permission to read it.

### Contract-aware mode

Permit only an explicit export containing public contracts such as:

- CLI behavior;
- public APIs;
- schemas and file formats;
- extension points;
- compatibility requirements;
- supported platform constraints.

Do not include implementation internals, history, or prior Discovery Repos.

### Full-reference mode

Product implementation access is allowed, but the Discovery Repo remains in a separate repo and still follows the charter, fixed Governance pin, and reading scope.

## Guardrails

- Record access mode in `DISCOVERY.yaml` and `AGENTS.md`.
- Validate obvious leaks during creation: Product remotes/submodules, seed files, and adjacent copied trees. The expected Governance submodule is allowed; inspect source identity instead of rejecting every submodule.
- Full and Curated modes both contain the complete Governance checkout. In Curated mode, apply exact path allow/exclude rules before reads, searches, Git object access, nested instructions, summaries, or delegated work. Unlisted bodies are excluded.
- Permit path enumeration and minimal authority metadata for interviews and source-wide validation; do not read excluded bodies to infer their exposure risk.
- Do not traverse history or follow links to bypass the pinned revision and reading scope. Scope approval cannot override Product Access Mode.
- Root instructions direct agents to the external scope record first. Version 1 does not promise automatic host enforcement: helpers enforce paths where used, while arbitrary agent tools must follow the same instructions.
- Surface accidental exposure immediately and record whether it invalidates the clean-room claim.
- Never claim hard isolation unless credentials, mounts, network access, and connectors are technically restricted.

## Supply chain

- Treat installed plugins and hook scripts as executable supply-chain inputs.
- Prefer a skills-only plugin in the first implementation; add hooks only for demonstrated needs.
- Validate plugin manifests and marketplace paths.
- Do not execute repository-provided scripts merely because they are present.
- Do not write credentials into Local Project Configuration, Discovery manifests, reading-scope records, or durable records.

## Path safety

Implementation must defend against:

- path traversal;
- symlinks or nested submodules that bypass approved file paths;
- unsafe submodule source URLs, Git configuration, or checkout hooks/filters;
- unexpected `.git` indirection or configuration pointing outside the owned submodule;
- overwriting existing files without review;
- writing outside registered project roots or the plugin data directory;
- unsafe shell interpolation.
