# Testing

The first chunk uses Bash scripts, disposable directories, available native tools
or activated Shimmy shims, and no test framework. Verify commands with
`command -v`; native Bash, Git, and platform utilities do not require shims.
Run selected groups with:

```text
bash tests/run.sh packaging validation templates installation
```

The tests distinguish fixture preparation from workflow behavior. They do not
initialize or modify real project repositories. `scripts/check_skill_discovery.sh`
also performs the structural check for the two skills; the host app-server
discovery smoke remains a separately reported environment check.

The validation tests cover one-document input, duplicate decoded keys, anchors
and aliases, schema references, real calendar dates, reading-scope paths, safe
substitutions, deterministic rendering, and decision-history conflicts. Path
checks compile the production schema and include both valid and invalid values.
Template checks compare parsed strings, including literal dollars, quotes,
backslashes, Unicode, empty values, and trailing newlines.
