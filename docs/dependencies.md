# Dependencies

Governed exploratory development requires these approved capabilities, provided
by existing native tools or activated Shimmy shims:

| Tool | Capability | Canary identity observed on 2026-09-15 |
| --- | --- | --- |
| Mike Farah `yq` | YAML/JSON parsing, node inspection, deterministic rendering | `yq ... version v4.53.6` |
| santhosh-tekuri/jsonschema `jv` | Draft 2020-12 validation and asserted date formats | `jv v0.0.0-20260628173800-b0fc661f4939` |

The canaries were run through the installed Shimmy wrappers with narrow outer
approval. `jv` rejected nested escaped duplicate keys and invalid leap dates;
`yq eval-all` counted YAML documents and parsed-node inspection exposed anchors
and aliases. The Bash helper combines those checks before invoking `jv`.

Verify each command with `command -v`; native tools are eligible without shims,
including Bash, Git, and platform file/hash utilities. Agents must not download,
install, or build missing tools, or acquire them through ad hoc containers.
There is no Python, Node, compiler, package manager, or automatic installer
dependency. The native `yq` implementation, if used, must be Mike Farah's tool.
