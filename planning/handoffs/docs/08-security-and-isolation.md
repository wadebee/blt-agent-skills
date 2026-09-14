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
- previous Discovery repositories;
- other agents or generated summaries;
- copied build files, lockfiles, CI, or dependency declarations.

The agent may use the immutable Governance snapshot and public external documentation.

### Contract-aware mode

Permit only an explicit export containing public contracts such as:

- CLI behavior;
- public APIs;
- schemas and file formats;
- extension points;
- compatibility requirements;
- supported platform constraints.

Do not include implementation internals, history, or prior experiments.

### Full-reference mode

Product implementation access is allowed, but the experiment remains in a separate repo and still follows the charter and immutable Governance snapshot.

## Guardrails

- Record access mode in `DISCOVERY.yaml` and `AGENTS.md`.
- Validate obvious leaks during creation: Product remotes, submodules, seed files, adjacent copied trees.
- Surface accidental exposure immediately and record whether it invalidates the clean-room claim.
- Never claim hard isolation unless credentials, mounts, network access, and connectors are technically restricted.

## Supply chain

- Treat installed plugins and hook scripts as executable supply-chain inputs.
- Prefer a skills-only plugin in the first implementation; add hooks only for demonstrated needs.
- Validate plugin manifests and marketplace paths.
- Do not execute repository-provided scripts merely because they are present.
- Do not write credentials into project registration, Discovery manifests, snapshots, or durable records.

## Path safety

Implementation must defend against:

- path traversal;
- symlink escapes during snapshot copy;
- copying `.git/` data into Discovery snapshots;
- overwriting existing files without review;
- writing outside registered project roots or the plugin data directory;
- unsafe shell interpolation.
