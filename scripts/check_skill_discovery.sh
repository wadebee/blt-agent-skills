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
  printf 'standalone app-server discovery was requested but is not implemented by this Bash harness; use the documented Codex app-server handshake.\n' >&2
  exit 2
fi

[[ "$failures" -eq 0 ]] || exit 1
printf 'standalone skill structure: passed\n'
printf 'standalone app-server discovery: not run (set RUN_CODEX_DISCOVERY=1 only when the host provides the approved app-server smoke harness)\n'
