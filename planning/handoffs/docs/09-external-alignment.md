# External Alignment

Verification date: **2026-09-14**.

This design uses the current portable OpenAI Agent Plugin shape:

- a root `plugin.json` identifies the plugin;
- reusable skills live under `skills/<skill-name>/SKILL.md`;
- supporting skill material may live under `references/`, `scripts/`, and `assets/`;
- a repository marketplace may be declared at `.agents/plugins/marketplace.json`;
- one marketplace may expose multiple sibling plugins.

The reference package deliberately uses root portable manifests rather than making `.codex-plugin/plugin.json` canonical. A compatibility overlay may be added later if tooling requires it.

Authoritative references:

- [OpenAI: Package your plugin](https://developers.openai.com/plugins/build/plugins)
- [OpenAI: Skills](https://developers.openai.com/api/docs/guides/tools-skills)
- [OpenAI: Build plugins](https://developers.openai.com/codex/build-plugins)

Implementation must validate these assumptions against current tooling because plugin schemas and install surfaces can evolve.
