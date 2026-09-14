# Open Implementation Details

These are intentionally left to Codex implementation judgment within the settled constraints.

1. **Implementation language for helper scripts.** Prefer the simplest runtime already available in supported ChatGPT/Codex environments; avoid unnecessary dependencies.
2. **Exact plugin-data path.** Use the runtime-provided writable plugin data location when available rather than hardcoding a home-directory convention.
3. **Sequential ID allocation mechanism.** It must detect collisions and support safe local concurrency; a lockfile or atomic create is acceptable.
4. **Schema validation library.** Choose a maintained implementation supporting JSON Schema 2020-12 or document any supported subset.
5. **Contract-aware export format.** Begin with an explicit directory or manifest selected during creation; do not infer arbitrary Product internals.
6. **Archive behavior.** Version 1 may mark or instruct local archival but must not perform remote operations.
7. **Exact Shimmy bootstrap entrypoint.** Inspect current Product sources. Do not derive it from this design package or chat history.
8. **Compatibility overlay.** Add `.codex-plugin/plugin.json` only if current tooling/testing requires it; root portable manifests remain canonical.
9. **Marketplace authentication policy value.** Validate the reference marketplace metadata against current schema/tooling and choose the least-privileged supported no-external-auth behavior.
10. **Presentation copy and branding.** May evolve without changing workflow semantics.
