#!/usr/bin/env bash

set -u
test_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
. "$test_dir/support.sh"

tool="$TEST_ROOT/plugins/governed-exploratory-development/skills/governed-development/scripts/governed.sh"
base="$TEST_ROOT/plugins/governed-exploratory-development/skills/governed-development"
commit=0123456789abcdef0123456789abcdef01234567
common=(GOVERNANCE_REPOSITORY=urn:example:governance PROJECT_NAME=example GOVERNANCE_COMMIT=$commit CREATED_AT=2024-02-29 DISCOVERY_ID=DISC-0001 READING_SCOPE=full)

expect_success "$tool" render "$base/assets/templates/governed/governance.yaml" "$base/assets/schemas/governance-context.schema.json" "$TEST_TMP/governance.yaml" "${common[@]}"
expect_success "$tool" render "$base/assets/templates/governed/reading-scope.yaml" "$base/assets/schemas/governance-reading-scope.schema.json" "$TEST_TMP/reading-scope.yaml" "${common[@]}"
expect_success "$tool" render "$base/assets/templates/governed/discovery.yaml" "$base/assets/schemas/discovery-manifest.schema.json" "$TEST_TMP/discovery.yaml" "${common[@]}" DISCOVERY_TITLE=Example DISCOVERY_REPOSITORY_NAME=example-disc-0001 FRAMING_OBJECTIVE=quality CHARTER_OBJECTIVE=objective RESEARCH_QUESTION=question SUCCESS_CRITERION=works NON_GOAL=production
expect_success "$tool" render "$base/assets/templates/LOCAL-PROJECT-CONFIGURATION.yaml" "$base/assets/schemas/local-project-configuration.schema.json" "$TEST_TMP/local.yaml" GOVERNANCE_REPOSITORY=urn:example:governance PRODUCT_PATH=/tmp/product GOVERNANCE_PATH=/tmp/governance DISCOVERY_REPO_PARENT_PATH=/tmp/discovery

expect_success "$tool" render-text "$base/assets/templates/agents/product/AGENTS.md" "$TEST_TMP/product.AGENTS.md" PLUGIN_VERSION=0.1.0 GENERATED_AT=2024-02-29 GOVERNANCE_SUBMODULE_PATH=.governance
expect_success "$tool" render-text "$base/assets/templates/agents/governance/AGENTS.md" "$TEST_TMP/governance.AGENTS.md" PLUGIN_VERSION=0.1.0 GENERATED_AT=2024-02-29
expect_success "$tool" render-text "$base/assets/templates/agents/discovery-repo/AGENTS.md" "$TEST_TMP/discovery.AGENTS.md" PLUGIN_VERSION=0.1.0 GENERATED_AT=2024-02-29

first="$TEST_TMP/discovery.yaml.first"
second="$TEST_TMP/discovery.yaml.second"
cp "$TEST_TMP/discovery.yaml" "$first"
expect_success "$tool" render "$base/assets/templates/governed/discovery.yaml" "$base/assets/schemas/discovery-manifest.schema.json" "$second" "${common[@]}" DISCOVERY_TITLE=Example DISCOVERY_REPOSITORY_NAME=example-disc-0001 FRAMING_OBJECTIVE=quality CHARTER_OBJECTIVE=objective RESEARCH_QUESTION=question SUCCESS_CRITERION=works NON_GOAL=production
cmp "$first" "$second" >/dev/null || fail "template rendering was not deterministic"

# The actual shim must receive values without host environment forwarding.
# Include capture-like dollar text, quotes, backslashes, Unicode, and trailing
# newlines; parse the output and compare exact strings instead of grepping YAML.
literal_template="$TEST_TMP/literal-template.yaml"
literal_schema="$TEST_TMP/literal.schema.json"
literal_output="$TEST_TMP/literal.yaml"
literal_value="$TEST_TMP/literal-value.txt"
write_file "$literal_template" 'value: "{{VALUE}}"' 'repeated: "{{VALUE}}|{{VALUE}}"' 'empty: "{{EMPTY}}"'
write_file "$literal_schema" '{"type":"object","required":["value","repeated","empty"],"additionalProperties":false,"properties":{"value":{"type":"string"},"repeated":{"type":"string"},"empty":{"type":"string"}}}'
literal=$'quote: " \' dollar: $1 ${NAME} backslash: \\ tab:\t café\nsecond line\n\n'
printf '%s' "$literal" > "$literal_value" || fail "cannot write literal value"
expect_success "$tool" render "$literal_template" "$literal_schema" "$literal_output" "VALUE=$literal" EMPTY=
cd "$TEST_ROOT" || fail "cannot enter the test workspace"
expected_file=${literal_value#"$TEST_ROOT"/}
expect_success yq eval -e "(.value == load_str(\"$expected_file\")) and (.repeated == (load_str(\"$expected_file\") + \"|\" + load_str(\"$expected_file\"))) and (.empty == \"\")" "${literal_output#"$TEST_ROOT"/}"
expect_failure "$tool" render "$literal_template" "$literal_schema" "$TEST_TMP/missing.yaml" "VALUE=$literal"
expect_failure "$tool" render "$literal_template" "$literal_schema" "$TEST_TMP/invalid-name.yaml" 'BAD-NAME=value'
pass "shared templates, substitutions, and deterministic output"
