#!/usr/bin/env bash

set -u
TEST_ROOT=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
TEST_TMP=$(mktemp -d "${TMPDIR:-/tmp}/governed-tests.XXXXXX") || exit 1
cleanup_tests() { rm -rf -- "$TEST_TMP"; }
trap cleanup_tests EXIT
trap 'exit 129' HUP
trap 'exit 130' INT
trap 'exit 143' TERM

fail() { printf 'FAIL: %s\n' "$*" >&2; exit 1; }
pass() { printf 'PASS: %s\n' "$*"; }
expect_success() {
  "$@" > "$TEST_TMP/last-command.log" 2>&1 && return 0
  cat "$TEST_TMP/last-command.log" >&2
  fail "expected success: $*"
}
expect_failure() {
  local result=0
  "$@" > "$TEST_TMP/last-command.log" 2>&1 || result=$?
  if [[ "$result" -eq 1 ]]; then return 0; fi
  cat "$TEST_TMP/last-command.log" >&2
  fail "expected input rejection (exit 1, got $result): $*"
}
write_file() {
  local path="$1"
  shift
  printf '%s\n' "$@" > "$path"
}
