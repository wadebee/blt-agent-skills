#!/usr/bin/env bash

set -u
root_dir=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
install_dir=$(mktemp -d "${TMPDIR:-/tmp}/beeline-plugin-install.XXXXXX") || exit 1
install_dir=$(CDPATH= cd -- "$install_dir" && pwd -P) || exit 1
marketplace_added=0
governed_added=0
shimmy_added=0
cleanup() {
  local result=$1
  if [[ "$shimmy_added" -eq 1 ]]; then codex plugin remove shimmy-onboarding@beeline-technologies >/dev/null || result=1; fi
  if [[ "$governed_added" -eq 1 ]]; then codex plugin remove governed-exploratory-development@beeline-technologies >/dev/null || result=1; fi
  if [[ "$marketplace_added" -eq 1 ]]; then codex plugin marketplace remove beeline-technologies >/dev/null || result=1; fi
  rm -rf -- "$install_dir"
  exit "$result"
}
trap 'cleanup $?' EXIT
trap 'exit 129' HUP
trap 'exit 130' INT
trap 'exit 143' TERM

mkdir -p "$install_dir/plugins" "$install_dir/.agents/plugins"
cp -R "$root_dir/plugins/governed-exploratory-development" "$install_dir/plugins/"
cp -R "$root_dir/plugins/shimmy-onboarding" "$install_dir/plugins/"
cp "$root_dir/.agents/plugins/marketplace.json" "$install_dir/.agents/plugins/"

[[ -f "$install_dir/plugins/governed-exploratory-development/plugin.json" ]] || exit 1
[[ -f "$install_dir/plugins/shimmy-onboarding/plugin.json" ]] || exit 1
[[ -f "$install_dir/.agents/plugins/marketplace.json" ]] || exit 1
[[ -f "$install_dir/plugins/governed-exploratory-development/skills/governed-development/SKILL.md" ]] || exit 1
[[ -f "$install_dir/plugins/shimmy-onboarding/skills/shimmy-onboarding/SKILL.md" ]] || exit 1
[[ -f "$install_dir/plugins/governed-exploratory-development/.codex-plugin/plugin.json" ]] || exit 1
[[ -f "$install_dir/plugins/shimmy-onboarding/.codex-plugin/plugin.json" ]] || exit 1

installed_tool="$install_dir/plugins/governed-exploratory-development/skills/governed-development/scripts/governed.sh"
installed_schema="$install_dir/plugins/governed-exploratory-development/skills/governed-development/assets/schemas/governance-context.schema.json"
mkdir -p "$install_dir/caller"
(
  cd "$install_dir/caller" || exit 1
  "$installed_tool" check-schema "$installed_schema"
) || exit 1

printf 'relocated packaged-script and schema smoke: passed\n'
if [[ "${RUN_CODEX_DISCOVERY:-0}" == "1" ]]; then
  for required_tool in codex yq grep sleep; do
    command -v "$required_tool" >/dev/null 2>&1 || { printf 'installed discovery requires %s\n' "$required_tool" >&2; exit 2; }
  done
  codex plugin marketplace list > "$install_dir/marketplaces"
  if grep -E '^beeline-technologies[[:space:]]' "$install_dir/marketplaces" >/dev/null; then
    printf 'beeline-technologies marketplace already configured; cannot run disposable install safely\n' >&2
    exit 2
  fi
  marketplace_added=1
  codex plugin marketplace add "$install_dir" || exit 2
  governed_added=1
  codex plugin add governed-exploratory-development@beeline-technologies > "$install_dir/governed-install.log" || exit 2
  cat "$install_dir/governed-install.log"
  shimmy_added=1
  codex plugin add shimmy-onboarding@beeline-technologies || exit 2
  installed_root=''
  while IFS= read -r line; do
    case "$line" in
      'Installed plugin root: '*) installed_root=${line#'Installed plugin root: '} ;;
    esac
  done < "$install_dir/governed-install.log"
  [[ -n "$installed_root" && -f "$installed_root/skills/governed-development/scripts/governed.sh" ]] || { printf 'Codex did not report an installed governed plugin root\n' >&2; exit 2; }
  cd "$install_dir/caller" || exit 2
  "$installed_root/skills/governed-development/scripts/governed.sh" check-schema "$installed_root/skills/governed-development/assets/schemas/governance-context.schema.json" || exit 1
  printf 'installed-cache schema execution: passed\n'
  {
    printf '%s\n' '{"method":"initialize","id":0,"params":{"clientInfo":{"name":"beeline_install_smoke","title":"Beeline Install Smoke","version":"0.1.0"}}}'
    printf '%s\n' '{"method":"initialized","params":{}}'
    printf '{"method":"skills/list","id":1,"params":{"cwds":["%s"],"forceReload":true}}\n' "$PWD"
    sleep 5
  } | codex app-server --stdio > "$install_dir/host.log" 2> "$install_dir/host.err" || { cat "$install_dir/host.err" >&2; exit 2; }
  grep '^{"id":1,"result":' "$install_dir/host.log" > "$install_dir/skills.json" || { cat "$install_dir/host.err" >&2; exit 2; }
  cd "$install_dir" || exit 2
  yq -p=json -o=yaml -r '.result.data[0].skills[] | select(.path | test("cache/beeline-technologies")) | [.name, .path] | @tsv' skills.json > discovered-skills || exit 2
  grep -E '^governed-exploratory-development:governed-development[[:space:]]' discovered-skills >/dev/null || { printf 'installed governed skill was not discovered in its namespace\n' >&2; exit 1; }
  grep -E '^shimmy-onboarding:shimmy-onboarding[[:space:]]' discovered-skills >/dev/null || { printf 'installed Shimmy skill was not discovered in its namespace\n' >&2; exit 1; }
  printf 'actual installed-plugin discovery and namespacing: passed\n'
else
  printf 'host application installation/discovery: not run (set RUN_CODEX_DISCOVERY=1)\n'
fi
