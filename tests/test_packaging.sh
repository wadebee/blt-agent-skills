#!/usr/bin/env bash

set -u
test_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
. "$test_dir/support.sh"

expect_success "$TEST_ROOT/scripts/check_packaging.sh"
expect_success "$TEST_ROOT/scripts/check_skill_discovery.sh"
pass "portable plugin manifests and public skill structure"
