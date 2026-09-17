#!/usr/bin/env bash

set -u
test_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
. "$test_dir/support.sh"

tool="$TEST_ROOT/plugins/governed-exploratory-development/skills/governed-development/scripts/governed.sh"
manifest_schema="$TEST_ROOT/plugins/governed-exploratory-development/skills/governed-development/assets/schemas/discovery-manifest.schema.json"
scope_schema="$TEST_ROOT/plugins/governed-exploratory-development/skills/governed-development/assets/schemas/governance-reading-scope.schema.json"
schema="$TEST_TMP/manifest.schema.json"
write_file "$schema" '{"$schema":"https://json-schema.org/draft/2020-12/schema","type":"object","properties":{"value":{"type":"string"}},"required":["value"]}'

valid="$TEST_TMP/valid.yaml"
write_file "$valid" 'value: "quote: \" and newline\n"'
expect_success "$tool" validate "$schema" "$valid"

duplicate="$TEST_TMP/duplicate.yaml"
write_file "$duplicate" 'outer:' '  nested:' '    "value": one' '    value: two'
expect_failure "$tool" validate "$schema" "$duplicate"

multi="$TEST_TMP/multi.yaml"
write_file "$multi" 'value: one' '---' 'value: two'
expect_failure "$tool" validate "$schema" "$multi"

anchor="$TEST_TMP/anchor.yaml"
write_file "$anchor" 'value: &value one' 'other: *value'
expect_failure "$tool" validate "$schema" "$anchor"

date_schema="$TEST_TMP/date.schema.json"
write_file "$date_schema" '{"$schema":"https://json-schema.org/draft/2020-12/schema","type":"object","properties":{"created_at":{"type":"string","format":"date"}},"required":["created_at"]}'
valid_date="$TEST_TMP/valid-date.yaml"
invalid_date="$TEST_TMP/invalid-date.yaml"
write_file "$valid_date" 'created_at: "2024-02-29"'
write_file "$invalid_date" 'created_at: "2023-02-29"'
expect_success "$tool" validate "$date_schema" "$valid_date"
expect_failure "$tool" validate "$date_schema" "$invalid_date"

bad_schema="$TEST_TMP/external.schema.json"
write_file "$bad_schema" '{"$schema":"https://json-schema.org/draft/2020-12/schema","$ref":"https://example.invalid/schema.json"}'
expect_failure "$tool" validate "$bad_schema" "$valid"

# Compile the complete production schema before testing its path constraint.
# Positive cases prevent an uncompilable schema from passing negative tests.
expect_success "$tool" check-schema "$scope_schema"
path_schema="$TEST_TMP/path.schema.json"
path_instance="$TEST_TMP/path.json"
cd "$TEST_ROOT" || fail "cannot enter the test workspace"
yq -o=json '.properties.decisions.items.properties.path' "${scope_schema#"$TEST_ROOT"/}" > "$path_schema" || fail "cannot extract path schema"
for path_json in '"constitution.md"' '"specs/quality.md"' '".hidden/rule.md"' '"docs/version..md"' '"docs/space and café.md"'; do
  write_file "$path_instance" "$path_json"
  expect_success jv -f "${path_schema#"$TEST_ROOT"/}" "${path_instance#"$TEST_ROOT"/}"
done
for path_json in '""' '"/absolute.md"' '"."' '".."' '"./rule.md"' '"../rule.md"' '"docs/."' '"docs/.."' '"docs/./rule.md"' '"docs/../rule.md"' '"docs/*.md"' '"docs/?.md"' '"docs/[ab].md"' '"docs/{a,b}.md"' '"docs/\u0000rule.md"'; do
  write_file "$path_instance" "$path_json"
  expect_failure jv -f "${path_schema#"$TEST_ROOT"/}" "${path_instance#"$TEST_ROOT"/}"
done

decisions="$TEST_TMP/decisions.yaml"
write_file "$decisions" \
  'creation_decisions:' \
  '  - decision_id: DEC-0001' \
  '    subject: governance-revision' \
  '    status: approved' \
  '    replaces: null' \
  '  - decision_id: DEC-0002' \
  '    subject: reading-scope' \
  '    status: approved' \
  '    replaces: null' \
  '  - decision_id: DEC-0003' \
  '    subject: discovery-type' \
  '    status: approved' \
  '    replaces: null' \
  '  - decision_id: DEC-0004' \
  '    subject: discovery-framing' \
  '    status: approved' \
  '    replaces: null' \
  '  - decision_id: DEC-0005' \
  '    subject: product-access' \
  '    status: approved' \
  '    replaces: null' \
  '  - decision_id: DEC-0006' \
  '    subject: discovery-charter' \
  '    status: approved' \
  '    replaces: null' \
  '  - decision_id: DEC-0007' \
  '    subject: comparison' \
  '    status: approved' \
  '    replaces: null'
expect_success "$tool" validate-decisions "$decisions"
write_file "$decisions" \
  'creation_decisions:' \
  '  - decision_id: DEC-0001' \
  '    subject: governance-revision' \
  '    status: approved' \
  '    replaces: null' \
  '  - decision_id: DEC-0002' \
  '    subject: governance-revision' \
  '    status: approved' \
  '    replaces: null'
expect_failure "$tool" validate-decisions "$decisions"

pass "metadata profile, schema formats, and decision binding checks"
