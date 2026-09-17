#!/usr/bin/env bash

# Shared structured-data helpers. Keep this file Bash 3.2 compatible.

set -u

governed_die() {
  printf 'governed-development: %s\n' "$*" >&2
  return 1
}

governed_wrapper_path() {
  local path="$1"
  if [[ -n "${GOVERNED_REPO_ROOT:-}" && "$path" == "$GOVERNED_REPO_ROOT"/* ]]; then
    printf '.%s\n' "${path#"$GOVERNED_REPO_ROOT"}"
  else
    printf '%s\n' "$path"
  fi
}

governed_yaml_profile() {
  local instance="$1"
  local wrapper_instance documents root_map anchors tags non_string_keys decisions
  local result_file status
  [[ -f "$instance" ]] || governed_die "metadata file not found: $instance" || return 1
  wrapper_instance=$(governed_wrapper_path "$instance")
  result_file="${GOVERNED_REPO_ROOT:-.}/.governed-profile.$$"
  yq eval-all -r '[.] | [length, (.[0] | tag == "!!map"), (.[0] | [... | select((anchor != "") or (kind == "alias"))] | length > 0), (.[0] | [... | select(tag != "!!map" and tag != "!!seq" and tag != "!!str" and tag != "!!int" and tag != "!!float" and tag != "!!bool" and tag != "!!null")] | length > 0), (.[0] | [... | select(is_key and tag != "!!str")] | length > 0), (.[0] | has("creation_decisions"))] | @tsv' "$wrapper_instance" > "$result_file"
  status=$?
  [[ "$status" -eq 0 ]] || { rm -f "$result_file"; governed_die "cannot inspect YAML profile: $instance"; return 1; }
  IFS=$'\t' read -r documents root_map anchors tags non_string_keys decisions < "$result_file"
  rm -f "$result_file"
  [[ "$documents" == "1" ]] || governed_die "$instance must contain exactly one YAML document" || return 1
  [[ "$root_map" == "true" ]] || governed_die "$instance must contain a mapping" || return 1
  [[ "$anchors" == "false" ]] || governed_die "$instance uses anchors or aliases" || return 1
  [[ "$tags" == "false" ]] || governed_die "$instance uses a timestamp, binary, or custom YAML tag" || return 1
  [[ "$non_string_keys" == "false" ]] || governed_die "$instance uses a non-string mapping key" || return 1
  GOVERNED_HAS_DECISIONS=$decisions
}

governed_schema_refs() {
  local schema="$1"
  local refs ref wrapper_schema refs_file status
  wrapper_schema=$(governed_wrapper_path "$schema")
  refs_file="${GOVERNED_REPO_ROOT:-.}/.governed-schema-refs.$$"
  yq eval -r '(([.. | select(tag == "!!map" and has("$ref")) | .["$ref"]]) + ([.. | select(tag == "!!map" and has("$dynamicRef")) | .["$dynamicRef"]]) + ([.. | select(tag == "!!map" and has("$recursiveRef")) | .["$recursiveRef"]]) + ["__NO_SCHEMA_REFS__"])[]' "$wrapper_schema" > "$refs_file"
  status=$?
  [[ "$status" -eq 0 ]] || { rm -f "$refs_file"; governed_die "cannot inspect schema references: $schema"; return 1; }
  while IFS= read -r ref; do
    if [[ -n "$ref" && "$ref" != "__NO_SCHEMA_REFS__" && "$ref" != "#"* ]]; then
      rm -f "$refs_file"
      governed_die "external schema reference is not allowed: $ref"
      return 1
    fi
  done < "$refs_file"
  rm -f "$refs_file"
}

governed_validate_instance() {
  local schema="$1"
  local instance="$2"
  local wrapper_schema wrapper_instance
  [[ -f "$schema" ]] || governed_die "schema not found: $schema" || return 1
  wrapper_schema=$(governed_wrapper_path "$schema")
  wrapper_instance=$(governed_wrapper_path "$instance")
  governed_schema_refs "$schema" || return 1
  governed_yaml_profile "$schema" || return 1
  governed_yaml_profile "$instance" || return 1
  jv -f "$wrapper_schema" "$wrapper_instance"
}

governed_check_schema() {
  local schema="$1"
  local output wrapper_schema output_file status schema_ok line
  [[ -f "$schema" ]] || governed_die "schema not found: $schema" || return 1
  wrapper_schema=$(governed_wrapper_path "$schema")
  governed_schema_refs "$schema" || return 1
  governed_yaml_profile "$schema" || return 1
  output_file="${GOVERNED_REPO_ROOT:-.}/.governed-schema-check.$$"
  jv -f "$wrapper_schema" > "$output_file" 2>&1
  status=$?
  schema_ok=0
  while IFS= read -r line; do
    case "$line" in
      "schema "*": ok") schema_ok=1 ;;
    esac
  done < "$output_file"
  if [[ "$status" -eq 0 && "$schema_ok" -eq 1 ]]; then
    rm -f "$output_file"
    return 0
  fi
  while IFS= read -r line; do printf '%s\n' "$line" >&2; done < "$output_file"
  rm -f "$output_file"
  governed_die "jv did not accept schema syntax: $schema"
  return 1
}

governed_render_yaml() {
  local template="$1"
  local schema="$2"
  local output="$3"
  shift 3
  local expression='.'
  local assignment key value temporary unresolved wrapper_template unresolved_file status
  local value_file value_count=0
  local value_files=()

  [[ -f "$template" ]] || governed_die "template not found: $template" || return 1
  [[ -f "$schema" ]] || governed_die "schema not found: $schema" || return 1
  wrapper_template=$(governed_wrapper_path "$template")

  # Only placeholder names enter the yq expression; values remain raw data.
  for assignment in "$@"; do
    key=${assignment%%=*}
    [[ "$assignment" == *=* && "$key" =~ ^[A-Z][A-Z0-9_]*$ ]] || {
      governed_die "template values must use NAME=value with an uppercase NAME"
      return 1
    }
  done

  temporary=".governed-render.$$.yaml"
  for assignment in "$@"; do
    key=${assignment%%=*}
    value=${assignment#*=}
    value_file=".governed-render.$$.value.$value_count"
    value_files[$value_count]="$value_file"
    value_count=$((value_count + 1))
    printf '%s' "$value" > "$value_file" || { rm -f "${value_files[@]}"; return 1; }
    # Shimmy forwards the workspace, not host environment variables. Literal
    # split/join also preserves dollars that sub() treats as capture references.
    expression="$expression | (.. | select(tag == \"!!str\")) |= (split(\"{{$key}}\") | join(load_str(\"$value_file\")))"
  done

  yq eval "$expression" "$wrapper_template" > "$temporary"
  status=$?
  if [[ "$value_count" -gt 0 ]]; then rm -f "${value_files[@]}"; fi
  [[ "$status" -eq 0 ]] || { rm -f "$temporary"; return 1; }
  unresolved_file="${GOVERNED_REPO_ROOT:-.}/.governed-unresolved.$$"
  yq eval '[(.. | select(tag == "!!str" and test("\\{\\{[^}]+\\}\\}")))] | length > 0' "$temporary" > "$unresolved_file"
  status=$?
  [[ "$status" -eq 0 ]] || { rm -f "$temporary" "$unresolved_file"; return 1; }
  IFS= read -r unresolved < "$unresolved_file"
  rm -f "$unresolved_file"
  if [[ "$unresolved" != "false" ]]; then
    rm -f "$temporary"
    governed_die "unresolved template substitution in $template"
    return 1
  fi
  governed_validate_instance "$schema" "$temporary" || { rm -f "$temporary"; return 1; }
  mv "$temporary" "$output"
}

governed_render_text() {
  local template="$1"
  local output="$2"
  shift 2
  local assignment key value token line temporary
  [[ -f "$template" ]] || governed_die "template not found: $template" || return 1
  temporary="${output}.tmp.$$"
  while IFS= read -r line || [[ -n "$line" ]]; do
    for assignment in "$@"; do
      key=${assignment%%=*}
      value=${assignment#*=}
      token="{{${key}}}"
      line=${line//"$token"/"$value"}
    done
    case "$line" in
      *'{{'*'}}'*) rm -f "$temporary"; governed_die "unresolved text substitution in $template"; return 1 ;;
    esac
    printf '%s\n' "$line" >> "$temporary"
  done < "$template"
  mv "$temporary" "$output"
}

governed_validate_decisions() {
  local instance="$1"
  local id subject status replaces refs seen_ids approved_subjects required_subject
  local target target_subject target_status rows_file bindings_file query_status current next chain hops
  local candidate candidate_subject candidate_status candidate_replaces candidate_refs reference found
  local approved_governance_id approved_scope_refs binding_names binding_results index
  rows_file="${GOVERNED_REPO_ROOT:-.}/.governed-decision-rows.$$"
  yq eval -r '.creation_decisions[] | [.decision_id, .subject, .status, (.replaces // "-"), (.inputs.decision_ids | join(","))] | @tsv' "$(governed_wrapper_path "$instance")" > "$rows_file"
  query_status=$?
  [[ "$query_status" -eq 0 ]] || { rm -f "$rows_file"; governed_die "cannot inspect creation decisions: $instance"; return 1; }
  seen_ids='|'
  approved_subjects='|'
  approved_governance_id=''
  approved_scope_refs=''
  while IFS=$'\t' read -r id subject status replaces refs; do
    [[ -z "$id" ]] && continue
    case "$seen_ids" in *"|$id|"*) rm -f "$rows_file"; governed_die "duplicate creation decision ID: $id"; return 1 ;; esac
    seen_ids="${seen_ids}${id}|"
    if [[ "$status" == "approved" ]]; then
      case "$approved_subjects" in *"|$subject|"*) rm -f "$rows_file"; governed_die "competing approved creation decisions for subject: $subject"; return 1 ;; esac
      approved_subjects="${approved_subjects}${subject}|"
      [[ "$subject" != "governance-revision" ]] || approved_governance_id=$id
      [[ "$subject" != "reading-scope" ]] || approved_scope_refs=$refs
    fi
  done < "$rows_file"
  while IFS=$'\t' read -r id subject status replaces refs; do
    [[ -z "$id" ]] && continue
    if [[ "$replaces" != "-" ]]; then
      [[ "$replaces" != "$id" ]] || { rm -f "$rows_file"; governed_die "creation decision replaces itself: $id"; return 1; }
      target_subject=''
      target_status=''
      while IFS=$'\t' read -r candidate candidate_subject candidate_status candidate_replaces candidate_refs; do
        if [[ "$candidate" == "$replaces" ]]; then
          target_subject=$candidate_subject
          target_status=$candidate_status
          break
        fi
      done < "$rows_file"
      [[ -n "$target_subject" ]] || { rm -f "$rows_file"; governed_die "creation decision $id references missing decision $replaces"; return 1; }
      [[ "$target_subject" == "$subject" ]] || { rm -f "$rows_file"; governed_die "creation decision $id replaces a different subject"; return 1; }
      [[ "$target_status" == "superseded" ]] || { rm -f "$rows_file"; governed_die "replaced decision $replaces must be superseded"; return 1; }
    fi
    if [[ -n "$refs" ]]; then
      local reference_ids=()
      IFS=',' read -r -a reference_ids <<< "$refs"
      for reference in "${reference_ids[@]}"; do
        case "$seen_ids" in *"|$reference|"*) ;; *) rm -f "$rows_file"; governed_die "creation decision $id has dangling input decision $reference"; return 1 ;; esac
        [[ "$reference" != "$id" ]] || { rm -f "$rows_file"; governed_die "creation decision $id cites itself as an input"; return 1; }
      done
    fi
    current="$id"
    chain="|$id|"
    hops=0
    while :; do
      target='-'
      while IFS=$'\t' read -r candidate candidate_subject candidate_status candidate_replaces candidate_refs; do
        [[ "$candidate" == "$current" ]] || continue
        target="$candidate_replaces"
        break
      done < "$rows_file"
      [[ "$target" != "-" ]] || break
      next="$target"
      case "$chain" in *"|$next|"*) governed_die "creation decision replacement cycle includes: $next"; rm -f "$rows_file"; return 1 ;; esac
      chain="${chain}${next}|"
      current="$next"
      hops=$((hops + 1))
      [[ "$hops" -le 1000 ]] || { governed_die "creation decision replacement chain is too long"; rm -f "$rows_file"; return 1; }
    done
  done < "$rows_file"
  rm -f "$rows_file"
  for required_subject in governance-revision reading-scope discovery-type discovery-framing product-access discovery-charter comparison; do
    case "$approved_subjects" in *"|$required_subject|"*) ;; *) governed_die "missing approved creation decision subject: $required_subject"; return 1 ;; esac
  done
  case ",$approved_scope_refs," in *",$approved_governance_id,"*) ;; *) governed_die "reading-scope approval must cite the applicable Governance approval"; return 1 ;; esac

  bindings_file="${GOVERNED_REPO_ROOT:-.}/.governed-decision-bindings.$$"
  yq eval -r '[((.creation_decisions[] | select(.subject == "reading-scope" and .status == "approved") | .approved_value) == .governance.reading_scope), ((.creation_decisions[] | select(.subject == "discovery-type" and .status == "approved") | .approved_value) == .discovery_repo.type), ((.creation_decisions[] | select(.subject == "discovery-framing" and .status == "approved") | .approved_value.mode) == .discovery_repo.framing.mode), ((.creation_decisions[] | select(.subject == "discovery-framing" and .status == "approved") | .approved_value.objective) == .discovery_repo.framing.objective), ((.creation_decisions[] | select(.subject == "product-access" and .status == "approved") | .approved_value) == .discovery_repo.product_access), ((.creation_decisions[] | select(.subject == "discovery-charter" and .status == "approved") | .approved_value.objective) == .discovery_repo.objective), ((.creation_decisions[] | select(.subject == "discovery-charter" and .status == "approved") | .approved_value.question) == .discovery_repo.question), ((.creation_decisions[] | select(.subject == "discovery-charter" and .status == "approved") | .approved_value.success_criteria | @json) == (.discovery_repo.success_criteria | @json)), ((.creation_decisions[] | select(.subject == "discovery-charter" and .status == "approved") | .approved_value.non_goals | @json) == (.discovery_repo.non_goals | @json)), ((.creation_decisions[] | select(.subject == "comparison" and .status == "approved") | .approved_value | @json) == ((.discovery_repo.comparison // "none") | @json)), ((.creation_decisions[] | select(.subject == "reading-scope" and .status == "approved") | .inputs.values.reading_scope_record) == .governance.reading_scope_record)] | @tsv' "$(governed_wrapper_path "$instance")" > "$bindings_file"
  query_status=$?
  [[ "$query_status" -eq 0 ]] || { rm -f "$bindings_file"; governed_die "cannot bind creation decisions to manifest values"; return 1; }
  binding_names=(reading-scope discovery-type framing-mode framing-objective product-access charter-objective charter-question charter-success-criteria charter-non-goals comparison reading-scope-record)
  binding_results=()
  IFS=$'\t' read -r -a binding_results < "$bindings_file"
  rm -f "$bindings_file"
  [[ "${#binding_results[@]}" -eq "${#binding_names[@]}" ]] || { governed_die "incomplete creation decision binding results"; return 1; }
  for ((index=0; index<${#binding_names[@]}; index++)); do
    [[ "${binding_results[$index]}" == true ]] || { governed_die "approved creation decision does not match manifest: ${binding_names[$index]}"; return 1; }
  done
}

governed_validate_context() {
  local manifest="$1" results_file status index
  local names=(scope-mode governance-commit governance-source scope-source governance-revision-input scope-revision-input portable-inputs)
  local results=()
  results_file="${GOVERNED_REPO_ROOT:-.}/.governed-context-bindings.$$"
  yq eval -r '[ (.governance.reading_scope == load("./scope.yaml").mode), ((.creation_decisions[] | select(.subject == "governance-revision" and .status == "approved") | .approved_value) == load("./governance.yaml").commit), ((.creation_decisions[] | select(.subject == "governance-revision" and .status == "approved") | .inputs.values.governance_repository) == load("./governance.yaml").repository), ((.creation_decisions[] | select(.subject == "reading-scope" and .status == "approved") | .inputs.values.governance_repository) == load("./governance.yaml").repository), ([.creation_decisions[] | select(.subject == "governance-revision" and .status == "approved") | .inputs.revisions[] | select(. == load("./governance.yaml").commit)] | length > 0), ([.creation_decisions[] | select(.subject == "reading-scope" and .status == "approved") | .inputs.revisions[] | select(. == load("./governance.yaml").commit)] | length > 0), ([.creation_decisions[].inputs.values | ... | select(tag == "!!str" and test("^(/|~/|file://)"))] | length == 0) ] | @tsv' "$(governed_wrapper_path "$manifest")" > "$results_file"
  status=$?
  [[ "$status" -eq 0 ]] || { rm -f "$results_file"; governed_die "cannot bind creation decisions to Governance context"; return 1; }
  IFS=$'\t' read -r -a results < "$results_file"
  rm -f "$results_file"
  [[ "${#results[@]}" -eq "${#names[@]}" ]] || { governed_die "incomplete Governance context binding results"; return 1; }
  for ((index=0; index<${#names[@]}; index++)); do
    [[ "${results[$index]}" == true ]] || { governed_die "creation context mismatch: ${names[$index]}"; return 1; }
  done
}
