# Testing

The first chunk uses Bash scripts, disposable directories, available native tools
or activated Shimmy shims, and no test framework. Verify commands with
`command -v`; native Bash, Git, and platform utilities do not require shims.
Run selected groups with:

```text
bash tests/run.sh packaging harness validation templates installation
```

The tests distinguish fixture preparation from workflow behavior. They do not
initialize or modify real project repositories. `scripts/check_skill_discovery.sh`
checks the two skill structures. Set `RUN_CODEX_DISCOVERY=1` to run its
disposable Codex app-server discovery check. Use the same flag with
`scripts/check_installation.sh` to install both plugins from a disposable local
marketplace, query app-server discovery and namespace paths, then remove the
test installation. These host checks need access to the existing Codex
configuration and, for Shimmy tools, its Podman connection.

The validation tests cover one-document input, duplicate decoded keys, anchors
and aliases, schema references, real calendar dates, reading-scope paths, safe
substitutions, deterministic rendering, and decision-history conflicts. Path
checks compile the production schema and include both valid and invalid values.
Template checks compare parsed strings, including literal dollars, quotes,
backslashes, Unicode, empty values, and trailing newlines.
