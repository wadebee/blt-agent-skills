# Chunk 1 acceptance coverage

| Acceptance area | Owner | Check/scenario | Result at this gate |
| --- | --- | --- | --- |
| Portable manifests and skill layout | Chunk 1 | `scripts/check_packaging.sh`; `tests/run.sh packaging` | Partial: syntax/layout checks passed; Shimmy-backed packaging check blocked |
| Shared YAML profile and schemas | Chunk 1 | `tests/run.sh validation templates` | Not run after wrapper became unresponsive |
| Template paths and local configuration | Chunk 1 | `tests/run.sh templates` | Not run after wrapper became unresponsive |
| Fixture containment and separate installation smoke | Chunk 1 | `scripts/check_installation.sh` | Passed reversible filesystem smoke |
| Standalone skill parsing | Chunk 1 | `scripts/check_skill_discovery.sh` | Passed structural check; app-server discovery not run |
| Actual installed-plugin discovery/namespacing | Chunk 1 | Host app-server/local install smoke | Not run; environment-dependent |
| Project creation, Discovery creation, Shimmy bootstrap | Later chunks | No runtime handler in Chunk 1 | Explicitly unavailable |

The table records the first owner rather than duplicating tests in later chunks.
Natural-language routing and behavior across arbitrary agent transports require
separate scenario review; structural checks cannot prove them.
