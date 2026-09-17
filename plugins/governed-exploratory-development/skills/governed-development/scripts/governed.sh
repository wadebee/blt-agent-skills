#!/usr/bin/env bash

set -u
script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
GOVERNED_REPO_ROOT=$(CDPATH= cd -- "$script_dir/../../../../.." && pwd)
export GOVERNED_REPO_ROOT
cd "$GOVERNED_REPO_ROOT" || exit 1
# shellcheck source=lib/data.sh
. "$script_dir/lib/data.sh"

usage() {
  cat <<'EOF'
Usage:
  governed.sh validate SCHEMA INSTANCE
  governed.sh check-schema SCHEMA
  governed.sh render TEMPLATE SCHEMA OUTPUT NAME=value...
  governed.sh render-text TEMPLATE OUTPUT NAME=value...
  governed.sh validate-decisions INSTANCE
EOF
}

command_name=${1:-}
case "$command_name" in
  validate)
    [[ $# -eq 3 ]] || { usage >&2; exit 2; }
    governed_validate_instance "$2" "$3" || exit 1
    if yq eval -e '.creation_decisions' "$3" >/dev/null 2>&1; then
      governed_validate_decisions "$3" || exit 1
    fi
    ;;
  check-schema)
    [[ $# -eq 2 ]] || { usage >&2; exit 2; }
    governed_check_schema "$2" || exit 1
    ;;
  render)
    [[ $# -ge 4 ]] || { usage >&2; exit 2; }
    governed_render_yaml "$2" "$3" "$4" "${@:5}" || exit 1
    ;;
  render-text)
    [[ $# -ge 3 ]] || { usage >&2; exit 2; }
    governed_render_text "$2" "$3" "${@:4}" || exit 1
    ;;
  validate-decisions)
    [[ $# -eq 2 ]] || { usage >&2; exit 2; }
    governed_require_tools || exit 1
    governed_validate_decisions "$2" || exit 1
    ;;
  *)
    usage >&2
    exit 2
    ;;
esac
