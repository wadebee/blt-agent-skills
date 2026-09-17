# Chunk 1 acceptance coverage — 2026-09-17

| Acceptance area | Owner | Check/scenario | Result at this gate |
| --- | --- | --- | --- |
| Portable manifests and skill layout | Chunk 1 | `bash tests/run.sh packaging` | Passed with the selected `yq` and `jv` wrappers. Portable root manifests remain; the tested Codex CLI also needs minimal `.codex-plugin/plugin.json` overlays for local installation. |
| Shared YAML profile and schemas | Chunk 1 | `bash tests/run.sh validation` | Passed: duplicate keys, documents, anchors, dates, offline references, reading-scope paths, decision bindings, dangling IDs, competing approvals, and replacement cycles. |
| Template paths and local configuration | Chunk 1 | `bash tests/run.sh templates` | Passed: renders from packaged assets and unrelated caller directories, cross-document context and changed-commit rejection, deterministic output, and literal substitutions. |
| Runner, fixture cleanup, and packaged relocation | Chunk 1 | `bash tests/run.sh harness installation` | Passed: early failure propagation, signal cleanup, and packaged schema execution from an unrelated directory. |
| Standalone skill discovery | Chunk 1 | `RUN_CODEX_DISCOVERY=1 bash scripts/check_skill_discovery.sh` | Passed actual Codex app-server `skills/list` discovery from a disposable project. |
| Installed-plugin execution, discovery and namespacing | Chunk 1 | `RUN_CODEX_DISCOVERY=1 bash scripts/check_installation.sh` | Passed schema execution from Codex's installed cache and namespaced app-server discovery for both plugins; test-owned plugins and marketplace registration were removed. |
| Project creation, Discovery creation, Shimmy bootstrap | Later chunks | No runtime handler in Chunk 1 | Explicitly unavailable |

Milestone 1 review remains open. The current fixtures do not yet demonstrate a
valid same-subject replacement history, Full-reference-to-Isolated exposure
history, predecessor/reason pairs, and every missing/unknown-field and
workstation/recovery-data rejection in the plan's Chunk 1 checklist. Those
cases block acceptance until tested or explicitly deferred at this review gate.
The table records the first owner rather than duplicating tests in later chunks.
