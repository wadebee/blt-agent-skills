# Packaging

The marketplace uses portable root `plugin.json` manifests and a catalog at
`.agents/plugins/marketplace.json`. The public governed-development skill is
the only user-facing lifecycle skill; the Shimmy onboarding capability is a
separate sibling plugin. Lifecycle workflow files under the public skill are
supporting references and are explicitly unavailable until their owning chunks.

Run `bash scripts/check_packaging.sh` for manifest, path, and packaged-schema
checks. This validates the repository layout; it does not install or publish a
plugin.
