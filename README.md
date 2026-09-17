# Beeline Technologies Agent Skills

This repository contains plans and reference material for independent plugins
and skills. Governed exploratory development implementation is in progress;
its production workflows are not yet available.

## Prerequisites

Work on governed exploratory development's metadata processing and validation
requires these CLI tools. If you do not wish to install them locally, they
may be provided through **[activated Shimmy shims](https://github.com/wadebee/shimmy)**:

| Tool | Required implementation | Purpose |
| --- | --- | --- |
| `yq` | [Mike Farah's yq](https://github.com/mikefarah/yq) | Read, inspect, and write YAML/JSON metadata. |
| `jv` | [santhosh-tekuri/jsonschema's jv](https://github.com/santhosh-tekuri/jsonschema) | Validate JSON Schema Draft 2020-12 with format assertions, including calendar dates. |

These dependencies apply to governed exploratory development, not to unrelated
sibling plugins or simply reading this repository.

The user must provision the required tools before dependent work can run.
Agents may use existing native tools or activated Shimmy shims after verifying
resolution with `command -v`. Native Bash, Git, and standard platform utilities
do not require shims. Agents must not download or install tools, including
temporary binaries, or use ad hoc container commands to acquire missing tools.
If a required tool is missing or unusable, report the blocker to the user.

## Repository guidance

- [Agent instructions](AGENTS.md)
- [Terminology](GLOSSARY.md)
- [Governed exploratory development implementation plan](planning/wip/governed-exploratory-development.md)
