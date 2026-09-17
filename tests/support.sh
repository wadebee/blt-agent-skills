#!/usr/bin/env bash

set -u
TEST_ROOT=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
TEST_TMP="$TEST_ROOT/.governed-tests.$$"
mkdir -p "$TEST_TMP" || exit 1
cleanup_tests() { rm -rf "$TEST_TMP"; }
trap cleanup_tests EXIT HUP INT TERM

fail() { printf 'FAIL: %s\n' "$*" >&2; exit 1; }
pass() { printf 'PASS: %s\n' "$*"; }
expect_success() {
  "$@" > "$TEST_TMP/last-command.log" 2>&1 && return 0
  cat "$TEST_TMP/last-command.log" >&2
  fail "expected success: $*"
}
expect_failure() { "$@" >/dev/null 2>&1 && fail "expected failure: $*" || true; }
write_file() {
  local path="$1"
  shift
  printf '%s\n' "$@" > "$path"
}
