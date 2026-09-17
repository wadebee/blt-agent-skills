#!/usr/bin/env bash

set -u
test_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
. "$test_dir/support.sh"
expect_success "$TEST_ROOT/scripts/check_installation.sh"
pass "reversible packaged-install namespace smoke"
