#!/usr/bin/env bash

set -u
root_dir=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
failures=0

for skill in "$root_dir/plugins"/*/skills/*/SKILL.md; do
  [[ -f "$skill" ]] || continue
  name_count=0
  name_value=''
  while IFS= read -r line; do
    case "$line" in
      name:*) name_count=$((name_count + 1)); name_value=${line#name:}; name_value=${name_value## } ;;
    esac
  done < "$skill"
  [[ "$name_count" -eq 1 && -n "$name_value" ]] || { printf 'invalid skill frontmatter: %s\n' "$skill" >&2; failures=$((failures + 1)); }
done

governed_skill="$root_dir/plugins/governed-exploratory-development/skills/governed-development/SKILL.md"
shimmy_skill="$root_dir/plugins/shimmy-onboarding/skills/shimmy-onboarding/SKILL.md"
[[ -f "$governed_skill" && -f "$shimmy_skill" ]] || failures=$((failures + 1))

if [[ "${RUN_CODEX_DISCOVERY:-0}" == "1" ]]; then
  for required_tool in codex yq grep sleep mktemp cp; do
    command -v "$required_tool" >/dev/null 2>&1 || { printf 'host discovery requires %s\n' "$required_tool" >&2; exit 2; }
  done
  discovery_dir=$(mktemp -d "${TMPDIR:-/tmp}/beeline-skill-discovery.XXXXXX") || exit 2
  discovery_dir=$(CDPATH= cd -- "$discovery_dir" && pwd -P) || exit 2
  cleanup_discovery() { rm -rf -- "$discovery_dir"; }
  trap cleanup_discovery EXIT
  trap 'exit 129' HUP
  trap 'exit 130' INT
  trap 'exit 143' TERM
  mkdir -p "$discovery_dir/project/.agents/skills" || exit 2
  cp -R "$root_dir/plugins/governed-exploratory-development/skills/governed-development" "$discovery_dir/project/.agents/skills/" || exit 2
  cp -R "$root_dir/plugins/shimmy-onboarding/skills/shimmy-onboarding" "$discovery_dir/project/.agents/skills/" || exit 2
  cd "$discovery_dir/project" || exit 2
  {
    printf '%s\n' '{"method":"initialize","id":0,"params":{"clientInfo":{"name":"beeline_discovery_smoke","title":"Beeline Discovery Smoke","version":"0.1.0"}}}'
    printf '%s\n' '{"method":"initialized","params":{}}'
    printf '{"method":"skills/list","id":1,"params":{"cwds":["%s"],"forceReload":true}}\n' "$PWD"
    sleep 5
  } | codex app-server --stdio > "$discovery_dir/host.log" 2> "$discovery_dir/host.err" || { cat "$discovery_dir/host.err" >&2; printf 'app-server discovery failed\n' >&2; exit 2; }
  grep '^{"id":1,"result":' "$discovery_dir/host.log" > "$discovery_dir/skills.json" || { cat "$discovery_dir/host.err" >&2; printf 'app-server did not return skills/list\n' >&2; exit 2; }
  cd "$discovery_dir" || exit 2
  yq -p=json -o=yaml -r '[.result.data[0].skills[] | select(.name == "governed-development" or .name == "shimmy-onboarding") | .path] | .[]' skills.json > paths || { printf 'cannot parse app-server skills/list\n' >&2; exit 2; }
  grep -Fx "$discovery_dir/project/.agents/skills/governed-development/SKILL.md" "$discovery_dir/paths" >/dev/null || { printf 'governed-development was not discovered at the expected path; observed paths:\n' >&2; cat "$discovery_dir/paths" >&2; exit 1; }
  grep -Fx "$discovery_dir/project/.agents/skills/shimmy-onboarding/SKILL.md" "$discovery_dir/paths" >/dev/null || { printf 'shimmy-onboarding was not discovered at the expected path; observed paths:\n' >&2; cat "$discovery_dir/paths" >&2; exit 1; }
  printf 'standalone app-server skill discovery: passed\n'
fi

[[ "$failures" -eq 0 ]] || exit 1
printf 'standalone skill structure: passed\n'
if [[ "${RUN_CODEX_DISCOVERY:-0}" != "1" ]]; then
  printf 'standalone app-server discovery: not run (set RUN_CODEX_DISCOVERY=1)\n'
fi
