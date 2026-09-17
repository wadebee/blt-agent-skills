#!/usr/bin/env bash

set -u
test_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
. "$test_dir/support.sh"

fixture="$TEST_TMP/runner"
mkdir -p "$fixture" || fail "cannot create runner fixture"
cp "$test_dir/run.sh" "$fixture/run.sh" || fail "cannot copy runner"
write_file "$fixture/test_packaging.sh" '#!/usr/bin/env bash' 'exit 1'
write_file "$fixture/test_validation.sh" '#!/usr/bin/env bash' 'printf "later group ran\n"'
result=0
bash "$fixture/run.sh" packaging validation > "$TEST_TMP/runner.log" 2>&1 || result=$?
[[ "$result" -eq 1 ]] || fail "runner masked an early group failure"
grep -q 'later group ran' "$TEST_TMP/runner.log" || fail "runner skipped a later group"

write_file "$TEST_TMP/signal.sh" \
  '#!/usr/bin/env bash' \
  ". \"$test_dir/support.sh\"" \
  'printf "%s\n" "$TEST_TMP"' \
  'kill -TERM "$$"' \
  'exit 0'
result=0
bash "$TEST_TMP/signal.sh" > "$TEST_TMP/signal.log" 2>&1 || result=$?
[[ "$result" -eq 143 ]] || fail "signal did not terminate the test with status 143"
IFS= read -r signal_tmp < "$TEST_TMP/signal.log"
[[ -n "$signal_tmp" && ! -e "$signal_tmp" ]] || fail "signal cleanup left its temporary directory"

pass "runner failure propagation and signal cleanup"
