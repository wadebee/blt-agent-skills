#!/usr/bin/env bash

set -u
test_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

if [[ $# -eq 0 ]]; then
  set -- packaging validation templates installation
fi

for group in "$@"; do
  case "$group" in
    packaging) bash "$test_dir/test_packaging.sh" ;;
    validation) bash "$test_dir/test_validation.sh" ;;
    templates) bash "$test_dir/test_templates.sh" ;;
    installation) bash "$test_dir/test_installation.sh" ;;
    *) printf 'unknown test group: %s\n' "$group" >&2; exit 2 ;;
  esac
done
