#!/usr/bin/env bash

set -u
script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
caller_dir=$PWD
GOVERNED_REPO_ROOT=$(mktemp -d "${TMPDIR:-/tmp}/governed-data.XXXXXX") || exit 1
export GOVERNED_REPO_ROOT
trap 'rm -rf -- "$GOVERNED_REPO_ROOT"' EXIT
trap 'exit 129' HUP
trap 'exit 130' INT
trap 'exit 143' TERM
# shellcheck source=lib/data.sh
. "$script_dir/lib/data.sh"

stage_input() {
  local source=$1 name=$2
  [[ "$source" == /* ]] || source="$caller_dir/$source"
  [[ -f "$source" ]] || { governed_die "input file not found: $source"; return 1; }
  cp "$source" "$GOVERNED_REPO_ROOT/$name" || return 1
}

publish_output() {
  local source=$1 destination=$2 temporary
  [[ "$destination" == /* ]] || destination="$caller_dir/$destination"
  temporary=$(mktemp "$destination.XXXXXX") || return 1
  cp "$GOVERNED_REPO_ROOT/$source" "$temporary" || { rm -f "$temporary"; return 1; }
  mv "$temporary" "$destination" || { rm -f "$temporary"; return 1; }
}

usage() {
  cat <<'EOF'
Usage:
  governed.sh validate SCHEMA INSTANCE
  governed.sh check-schema SCHEMA
  governed.sh render TEMPLATE SCHEMA OUTPUT NAME=value...
  governed.sh render-text TEMPLATE OUTPUT NAME=value...
  governed.sh validate-decisions INSTANCE
  governed.sh validate-context MANIFEST GOVERNANCE_CONTEXT READING_SCOPE
EOF
}

command_name=${1:-}
case "$command_name" in
  validate)
    [[ $# -eq 3 ]] || { usage >&2; exit 2; }
    stage_input "$2" schema.json || exit 1
    case "$3" in
      *.json) staged_instance=./instance.json ;;
      *) staged_instance=./instance.yaml ;;
    esac
    stage_input "$3" "${staged_instance#./}" || exit 1
    cd "$GOVERNED_REPO_ROOT" || exit 1
    governed_validate_instance ./schema.json "$staged_instance" || exit 1
    if [[ "$GOVERNED_HAS_DECISIONS" == true ]]; then
      governed_validate_decisions "$staged_instance" || exit 1
    fi
    ;;
  check-schema)
    [[ $# -eq 2 ]] || { usage >&2; exit 2; }
    stage_input "$2" schema.json || exit 1
    cd "$GOVERNED_REPO_ROOT" || exit 1
    governed_check_schema ./schema.json || exit 1
    ;;
  render)
    [[ $# -ge 4 ]] || { usage >&2; exit 2; }
    stage_input "$2" template || exit 1
    stage_input "$3" schema.json || exit 1
    cd "$GOVERNED_REPO_ROOT" || exit 1
    governed_render_yaml ./template ./schema.json ./rendered.yaml "${@:5}" || exit 1
    publish_output rendered.yaml "$4" || exit 1
    ;;
  render-text)
    [[ $# -ge 3 ]] || { usage >&2; exit 2; }
    stage_input "$2" template || exit 1
    cd "$GOVERNED_REPO_ROOT" || exit 1
    governed_render_text ./template ./rendered "${@:4}" || exit 1
    publish_output rendered "$3" || exit 1
    ;;
  validate-decisions)
    [[ $# -eq 2 ]] || { usage >&2; exit 2; }
    stage_input "$2" instance.yaml || exit 1
    cd "$GOVERNED_REPO_ROOT" || exit 1
    governed_validate_decisions ./instance.yaml || exit 1
    ;;
  validate-context)
    [[ $# -eq 4 ]] || { usage >&2; exit 2; }
    stage_input "$2" manifest.yaml || exit 1
    stage_input "$3" governance.yaml || exit 1
    stage_input "$4" scope.yaml || exit 1
    stage_input "$script_dir/../assets/schemas/discovery-manifest.schema.json" manifest.schema.json || exit 1
    stage_input "$script_dir/../assets/schemas/governance-context.schema.json" governance.schema.json || exit 1
    stage_input "$script_dir/../assets/schemas/governance-reading-scope.schema.json" scope.schema.json || exit 1
    cd "$GOVERNED_REPO_ROOT" || exit 1
    governed_validate_instance ./manifest.schema.json ./manifest.yaml || exit 1
    governed_validate_instance ./governance.schema.json ./governance.yaml || exit 1
    governed_validate_instance ./scope.schema.json ./scope.yaml || exit 1
    governed_validate_decisions ./manifest.yaml || exit 1
    governed_validate_context ./manifest.yaml || exit 1
    ;;
  *)
    usage >&2
    exit 2
    ;;
esac
