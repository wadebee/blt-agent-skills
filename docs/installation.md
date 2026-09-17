# Installation and discovery

The package is intended for local installation from this marketplace checkout.
The filesystem smoke copies both plugin roots into a temporary directory and
runs the packaged schema checker from an unrelated caller directory:

```text
bash scripts/check_installation.sh
```

Set `RUN_CODEX_DISCOVERY=1` to extend the smoke with an actual local Codex
marketplace registration, installation of both plugins, execution of the
governed schema checker from Codex's installed cache, and app-server skill
discovery and namespace assertions. The test first checks that its marketplace
name is unused, then removes both installed test plugins, the registration, and
its temporary files on exit. It does not publish a marketplace or run Shimmy
bootstrap. Report the filesystem and host checks separately.
