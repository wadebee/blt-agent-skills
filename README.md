# Beeline Technologies Agent Skills

This repository contains plans and reference material for independent plugins
and skills. Governed exploratory development implementation is in progress;
its production workflows are not yet available.

## Prerequisites

Work on governed exploratory development's metadata processing and validation
requires these CLI tools, provided through **activated Shimmy shims**:

| Tool | Required implementation | Purpose |
| --- | --- | --- |
| `yq` | [Mike Farah's yq](https://github.com/mikefarah/yq) | Read, inspect, and write YAML/JSON metadata. |
| `jv` | [santhosh-tekuri/jsonschema's jv](https://github.com/santhosh-tekuri/jsonschema) | Validate JSON Schema Draft 2020-12 with format assertions, including calendar dates. |

These dependencies apply to governed exploratory development, not to unrelated
sibling plugins or simply reading this repository. Dependency capability checks
remain pending through the provisioned shims.

The user must provision the required tools through Shimmy before dependent work
can run. All agent CLI usage must go through activated Shimmy shims. Agents must
not download or install tools, including temporary binaries, or fall back to
direct host executables or ad hoc container commands. If a required shim is
missing or unusable, report the tool and blocker to the user.

## Repository guidance

- [Agent instructions](AGENTS.md)
- [Terminology](GLOSSARY.md)
- [Governed exploratory development implementation plan](planning/wip/governed-exploratory-development.md)
