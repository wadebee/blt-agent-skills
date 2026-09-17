#!/usr/bin/env bash

set -u
root_dir=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
install_dir=$(mktemp -d "${TMPDIR:-/tmp}/beeline-plugin-install.XXXXXX") || exit 1
cleanup() { rm -rf "$install_dir"; }
trap cleanup EXIT HUP INT TERM

mkdir -p "$install_dir/plugins" "$install_dir/.agents/plugins"
cp -R "$root_dir/plugins/governed-exploratory-development" "$install_dir/plugins/"
cp -R "$root_dir/plugins/shimmy-onboarding" "$install_dir/plugins/"
cp "$root_dir/.agents/plugins/marketplace.json" "$install_dir/.agents/plugins/"

[[ -f "$install_dir/plugins/governed-exploratory-development/plugin.json" ]] || exit 1
[[ -f "$install_dir/plugins/shimmy-onboarding/plugin.json" ]] || exit 1
[[ -f "$install_dir/.agents/plugins/marketplace.json" ]] || exit 1
[[ -f "$install_dir/plugins/governed-exploratory-development/skills/governed-development/SKILL.md" ]] || exit 1
[[ -f "$install_dir/plugins/shimmy-onboarding/skills/shimmy-onboarding/SKILL.md" ]] || exit 1

printf 'reversible local packaged installation and namespace smoke: passed\n'
printf 'host application installation/discovery: not claimed by this filesystem smoke\n'
