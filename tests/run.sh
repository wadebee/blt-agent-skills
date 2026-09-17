#!/usr/bin/env bash

set -u
test_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

if [[ $# -eq 0 ]]; then
  set -- packaging harness validation templates installation
fi

result=0
for group in "$@"; do
  case "$group" in
    packaging|harness|validation|templates|installation)
      if ! bash "$test_dir/test_$group.sh"; then
        printf 'test group failed: %s\n' "$group" >&2
        result=1
      fi
      ;;
    *) printf 'unknown test group: %s\n' "$group" >&2; exit 2 ;;
  esac
done
exit "$result"
