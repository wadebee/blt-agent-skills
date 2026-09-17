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
write_file "$bad_schema" '{"$schema":"https://json-schema.org/draft/2020-12/schema","$dynamicRef":"https://example.invalid/schema.json"}'
expect_failure "$tool" validate "$bad_schema" "$valid"

# Compile the complete production schema before testing its path constraint.
# Positive cases prevent an uncompilable schema from passing negative tests.
expect_success "$tool" check-schema "$scope_schema"
path_schema="$TEST_TMP/path.schema.json"
path_instance="$TEST_TMP/path.json"
cp "$scope_schema" "$TEST_TMP/scope.schema.json" || fail "cannot copy path schema source"
cd "$TEST_TMP" || fail "cannot enter the test workspace"
yq -o=json '.properties.decisions.items.properties.path' scope.schema.json > "$path_schema" || fail "cannot extract path schema"
for path_json in '"constitution.md"' '"specs/quality.md"' '".hidden/rule.md"' '"docs/version..md"' '"docs/space and café.md"'; do
  write_file "$path_instance" "$path_json"
  expect_success jv -f path.schema.json path.json
done
for path_json in '""' '"/absolute.md"' '"."' '".."' '"./rule.md"' '"../rule.md"' '"docs/."' '"docs/.."' '"docs/./rule.md"' '"docs/../rule.md"' '"docs/*.md"' '"docs/?.md"' '"docs/[ab].md"' '"docs/{a,b}.md"' '"docs/\u0000rule.md"'; do
  write_file "$path_instance" "$path_json"
  expect_failure jv -f path.schema.json path.json
done

decisions="$TEST_TMP/decisions.yaml"
base="$TEST_ROOT/plugins/governed-exploratory-development/skills/governed-development"
commit=0123456789abcdef0123456789abcdef01234567
expect_success "$tool" render "$base/assets/templates/governed/discovery.yaml" "$manifest_schema" "$decisions" GOVERNANCE_REPOSITORY=urn:example:governance PROJECT_NAME=example GOVERNANCE_COMMIT=$commit CREATED_AT=2024-02-29 DISCOVERY_ID=DISC-0001 READING_SCOPE=full DISCOVERY_TITLE=Example DISCOVERY_REPOSITORY_NAME=example-disc-0001 FRAMING_OBJECTIVE=quality CHARTER_OBJECTIVE=objective RESEARCH_QUESTION=question SUCCESS_CRITERION=works NON_GOAL=production
expect_success "$tool" validate-decisions "$decisions"

sed 's/approved_value: "isolated"/approved_value: "full-reference"/' "$decisions" > "$TEST_TMP/wrong-access.yaml"
expect_failure "$tool" validate-decisions "$TEST_TMP/wrong-access.yaml"
sed 's/        - "DEC-0001"/        - "DEC-9999"/' "$decisions" > "$TEST_TMP/dangling-input.yaml"
expect_failure "$tool" validate-decisions "$TEST_TMP/dangling-input.yaml"
sed 's/decision_id: "DEC-0007"/decision_id: "DEC-0006"/' "$decisions" > "$TEST_TMP/duplicate-id.yaml"
expect_failure "$tool" validate-decisions "$TEST_TMP/duplicate-id.yaml"
sed 's/    subject: "comparison"/    subject: "product-access"/' "$decisions" > "$TEST_TMP/competing.yaml"
expect_failure "$tool" validate-decisions "$TEST_TMP/competing.yaml"
cp "$decisions" "$TEST_TMP/replacement-cycle.yaml" || fail "cannot copy cycle fixture"
cat >> "$TEST_TMP/replacement-cycle.yaml" <<'EOF'
  - decision_id: "DEC-0008"
    subject: "comparison"
    approved_value: "none"
    inputs: {values: {}, revisions: [], decision_ids: []}
    approval_date: "2024-02-29"
    rationale: null
    replaces: "DEC-0009"
    prior_exposure: []
    status: "superseded"
  - decision_id: "DEC-0009"
    subject: "comparison"
    approved_value: "none"
    inputs: {values: {}, revisions: [], decision_ids: []}
    approval_date: "2024-02-29"
    rationale: null
    replaces: "DEC-0008"
    prior_exposure: []
    status: "superseded"
EOF
expect_failure "$tool" validate-decisions "$TEST_TMP/replacement-cycle.yaml"
write_file "$TEST_TMP/malformed-decisions.yaml" 'creation_decisions: ['
expect_failure "$tool" validate-decisions "$TEST_TMP/malformed-decisions.yaml"

pass "metadata profile, schema formats, and manifest decision bindings"
