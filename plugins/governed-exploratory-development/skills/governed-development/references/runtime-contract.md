# Governed Development Runtime Contract

Chunk 1 supplies packaging and shared metadata validation only. Project Setup,
Project Activation, Discovery Repo creation, reviews, promotions, adoption, and
Shimmy bootstrap are unavailable until their owning chunks and contracts are
implemented. A router or helper must report unavailable work rather than execute
an older reference workflow.

The capability keeps Governance, Product, and each Discovery Repo as separate
repositories. Product and Discovery use independent exact Governance submodule
pins. `.governed/governance.yaml` is the local Governance context;
`.governed/discovery.yaml` records the Discovery Manifest and
`.governed/reading-scope.yaml` records the fixed Governance Reading Scope.

The governed-development Git boundary is narrow: only initial Project Setup may
stage approved generated files, create one initial commit in new Governance and
Product repositories, and configure Product's local submodule connection.
Discovery creation may stage only `.gitmodules` and its Governance Git link and
never creates a commit. Activation and later workflows preserve history, index,
remotes, pins, and unrelated edits. This repository itself is not committed by
the capability.

Metadata uses the constrained YAML profile: one UTF-8 document, string mapping
keys, JSON-compatible values, no duplicate decoded keys, anchors, aliases,
merge keys, custom tags, external schema references, or unresolved substitutions.
Schemas are Draft 2020-12 and are validated offline with the approved `jv` tool.

Existing native tools and activated Shimmy shims are eligible after checking
`command -v`, including native Bash, Git, and platform utilities. `yq` must be
Mike Farah's implementation. Agents do not download or install missing tools;
report missing dependencies for user provisioning.

Workstation paths and recovery data remain local. Portable records retain actual
approved values, relevant inputs/revisions, approval dates, supplied rationale,
replacement references, and relevant prior exposure. Recommendations never
stand in for explicit developer choices.
