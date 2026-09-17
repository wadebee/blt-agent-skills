#!/usr/bin/env bash

set -u
root_dir=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
cd "$root_dir" || exit 1
governed_dir="plugins/governed-exploratory-development/skills/governed-development"

failures=0
PACKAGING_VALUE=''
read_yq_value() {
  local expression="$1"
  local input="$2"
  local value_file=".packaging-value.$$"
  yq -r "$expression" "$input" > "$value_file" 2>/dev/null
  local status=$?
  [[ "$status" -eq 0 ]] || { rm -f "$value_file"; return 1; }
  PACKAGING_VALUE=''
  IFS= read -r PACKAGING_VALUE < "$value_file"
  rm -f "$value_file"
}
require_file() {
  if [[ ! -f "$root_dir/$1" ]]; then
    printf 'missing required packaging file: %s\n' "$1" >&2
    failures=$((failures + 1))
  fi
}

required_files=(
  .agents/plugins/marketplace.json
  plugins/governed-exploratory-development/plugin.json
  plugins/governed-exploratory-development/.codex-plugin/plugin.json
  plugins/governed-exploratory-development/skills/governed-development/SKILL.md
  plugins/shimmy-onboarding/plugin.json
  plugins/shimmy-onboarding/.codex-plugin/plugin.json
  plugins/shimmy-onboarding/skills/shimmy-onboarding/SKILL.md
  plugins/shimmy-onboarding/skills/shimmy-onboarding/references/onboarding-contract.md
  plugins/governed-exploratory-development/skills/governed-development/references/runtime-contract.md
  plugins/governed-exploratory-development/skills/governed-development/scripts/governed.sh
  plugins/governed-exploratory-development/skills/governed-development/scripts/lib/data.sh
)
for path in "${required_files[@]}"; do require_file "$path"; done

for schema in "$governed_dir/assets/schemas/"*.json; do
  [[ -f "$schema" ]] || continue
  "$governed_dir/scripts/governed.sh" check-schema "$schema" >/dev/null || failures=$((failures + 1))
done

if [[ -f ".agents/plugins/marketplace.json" ]]; then
  read_yq_value '.name' ".agents/plugins/marketplace.json" || PACKAGING_VALUE=''
  marketplace_name="$PACKAGING_VALUE"
  [[ "$marketplace_name" == "beeline-technologies" ]] || { printf 'invalid marketplace identity\n' >&2; failures=$((failures + 1)); }
fi
for manifest in plugins/*/plugin.json; do
  [[ -f "$manifest" ]] || continue
  read_yq_value '.name' "$manifest" || PACKAGING_VALUE=''
  plugin_name="$PACKAGING_VALUE"
  read_yq_value '.version' "$manifest" || PACKAGING_VALUE=''
  plugin_version="$PACKAGING_VALUE"
  [[ "$plugin_name" == "governed-exploratory-development" || "$plugin_name" == "shimmy-onboarding" ]] || { printf 'invalid plugin name in %s\n' "$manifest" >&2; failures=$((failures + 1)); }
  [[ "$plugin_version" =~ ^[0-9]+\.[0-9]+\.[0-9]+ ]] || { printf 'invalid plugin version in %s\n' "$manifest" >&2; failures=$((failures + 1)); }
done

[[ "$failures" -eq 0 ]] || exit 1
printf 'packaging structure and portable manifests: passed\n'
