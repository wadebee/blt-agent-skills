#!/usr/bin/env bash

# Shared structured-data helpers. Keep this file Bash 3.2 compatible.

set -u

governed_die() {
  printf 'governed-development: %s\n' "$*" >&2
  return 1
}

governed_require_tool() {
  local tool="$1"
  local resolved
  resolved=$(command -v "$tool" 2>/dev/null) || {
    governed_die "$tool is required; use an existing native tool or activated Shimmy shim"
    return 1
  }
  printf '%s\n' "$resolved"
}

governed_require_tools() {
  governed_require_tool yq >/dev/null || return 1
  governed_require_tool jv >/dev/null || return 1
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
  local wrapper_instance documents anchors tags merge_keys non_string_keys before after
  local result_prefix documents_file anchors_file tags_file merge_file keys_file status
  [[ -f "$instance" ]] || governed_die "metadata file not found: $instance" || return 1
  wrapper_instance=$(governed_wrapper_path "$instance")
  result_prefix="${GOVERNED_REPO_ROOT:-.}/.governed-data.$$"
  documents_file="${result_prefix}.documents"
  anchors_file="${result_prefix}.anchors"
  tags_file="${result_prefix}.tags"
  merge_file="${result_prefix}.merge"
  keys_file="${result_prefix}.keys"

  yq eval-all '[.] | length' "$wrapper_instance" > "$documents_file" 2>/dev/null
  status=$?
  [[ "$status" -eq 0 ]] || { rm -f "$documents_file" "$anchors_file" "$tags_file" "$merge_file" "$keys_file"; governed_die "cannot parse YAML: $instance"; return 1; }
  IFS= read -r documents < "$documents_file"
  rm -f "$documents_file"
  documents=${documents//$'\n'/}
  documents=${documents//$'\r'/}
  [[ "$documents" == "1" ]] || governed_die "$instance must contain exactly one YAML document" || return 1

  before="${TMPDIR:-/tmp}/governed-before.$$"
  after="${TMPDIR:-/tmp}/governed-after.$$"
  yq eval '.' "$wrapper_instance" > "$before" 2>/dev/null || { rm -f "$before" "$after"; governed_die "cannot inspect YAML anchors: $instance"; return 1; }
  yq eval 'explode(.)' "$wrapper_instance" > "$after" 2>/dev/null || { rm -f "$before" "$after"; governed_die "cannot inspect YAML anchors: $instance"; return 1; }
  if ! cmp -s "$before" "$after"; then
    rm -f "$before" "$after"
    governed_die "$instance uses anchors or aliases; they are not permitted"
    return 1
  fi
  rm -f "$before" "$after"

  yq eval '[(.. | select(tag != "!!map" and tag != "!!seq" and tag != "!!str" and tag != "!!int" and tag != "!!float" and tag != "!!bool" and tag != "!!null"))] | length > 0' "$wrapper_instance" > "$tags_file" 2>/dev/null
  status=$?
  [[ "$status" -eq 0 ]] || { rm -f "$tags_file"; governed_die "cannot inspect YAML tags: $instance"; return 1; }
  IFS= read -r tags < "$tags_file"
  rm -f "$tags_file"
  [[ "$tags" == "false" ]] || governed_die "$instance uses a timestamp, binary, or custom YAML tag" || return 1

  yq eval '[(.. | select(tag == "!!map") | to_entries[] | select(.key == "<<"))] | length > 0' "$wrapper_instance" > "$merge_file" 2>/dev/null
  status=$?
  [[ "$status" -eq 0 ]] || { rm -f "$merge_file"; governed_die "cannot inspect YAML merge keys: $instance"; return 1; }
  IFS= read -r merge_keys < "$merge_file"
  rm -f "$merge_file"
  [[ "$merge_keys" == "false" ]] || governed_die "$instance uses a YAML merge key" || return 1

  yq eval '[(.. | select(tag == "!!map") | to_entries[] | select(.key | tag != "!!str"))] | length > 0' "$wrapper_instance" > "$keys_file" 2>/dev/null
  status=$?
  [[ "$status" -eq 0 ]] || { rm -f "$keys_file"; governed_die "cannot inspect YAML mapping keys: $instance"; return 1; }
  IFS= read -r non_string_keys < "$keys_file"
  rm -f "$keys_file"
  [[ "$non_string_keys" == "false" ]] || governed_die "$instance uses a non-string mapping key" || return 1
}

governed_schema_refs() {
  local schema="$1"
  local refs ref wrapper_schema refs_file status
  wrapper_schema=$(governed_wrapper_path "$schema")
  refs_file="${GOVERNED_REPO_ROOT:-.}/.governed-schema-refs.$$"
  yq eval -r '(([.. | select(tag == "!!map" and has("$ref")) | .["$ref"]]) + ["__NO_SCHEMA_REFS__"])[]' "$wrapper_schema" > "$refs_file" 2>/dev/null
  status=$?
  [[ "$status" -eq 0 ]] || { rm -f "$refs_file"; governed_die "cannot inspect schema references: $schema"; return 1; }
  while IFS= read -r ref; do
    [[ -z "$ref" || "$ref" == "__NO_SCHEMA_REFS__" || "$ref" == "#"* ]] || governed_die "external schema reference is not allowed: $ref" || return 1
  done < "$refs_file"
  rm -f "$refs_file"
}

governed_validate_instance() {
  local schema="$1"
  local instance="$2"
  local wrapper_schema wrapper_instance
  governed_require_tools || return 1
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
  governed_require_tools || return 1
  [[ -f "$schema" ]] || governed_die "schema not found: $schema" || return 1
  wrapper_schema=$(governed_wrapper_path "$schema")
  governed_schema_refs "$schema" || return 1
  governed_yaml_profile "$schema" || return 1
  output_file="${GOVERNED_REPO_ROOT:-.}/.governed-schema-check.$$"
  jv -f "$wrapper_schema" "$wrapper_schema" > "$output_file" 2>&1
  status=$?
  schema_ok=0
  while IFS= read -r line; do
    case "$line" in
      "schema "*": ok") schema_ok=1 ;;
    esac
  done < "$output_file"
  if [[ "$schema_ok" -eq 1 ]]; then
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

  governed_require_tools || return 1
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
  yq eval '[(.. | select(tag == "!!str" and test("\\{\\{[^}]+\\}\\}")))] | length > 0' "$temporary" > "$unresolved_file" 2>/dev/null
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
  local id subject status replaces seen_ids approved_subjects required_subject
  local target target_subject rows_file target_file query_status current next chain hops
  local candidate candidate_subject candidate_status candidate_replaces
  rows_file="${GOVERNED_REPO_ROOT:-.}/.governed-decision-rows.$$"
  yq eval -r '.creation_decisions[] | [.decision_id, .subject, .status, (.replaces // "")] | @tsv' "$(governed_wrapper_path "$instance")" > "$rows_file" 2>/dev/null
  query_status=$?
  [[ "$query_status" -eq 0 ]] || { rm -f "$rows_file"; return 0; }
  seen_ids='|'
  approved_subjects='|'
  while IFS=$'\t' read -r id subject status replaces; do
    [[ -z "$id" ]] && continue
    case "$seen_ids" in *"|$id|"*) governed_die "duplicate creation decision ID: $id"; return 1 ;; esac
    seen_ids="${seen_ids}${id}|"
    if [[ -n "$replaces" ]]; then
      [[ "$replaces" != "$id" ]] || { governed_die "creation decision replaces itself: $id"; return 1; }
      target_file="${GOVERNED_REPO_ROOT:-.}/.governed-decision-target.$$"
      yq eval -r ".creation_decisions[] | select(.decision_id == \"$replaces\") | .subject" "$(governed_wrapper_path "$instance")" > "$target_file" 2>/dev/null
      target_subject=''
      IFS= read -r target_subject < "$target_file"
      rm -f "$target_file"
      [[ -n "$target_subject" && "$target_subject" != "null" ]] || { governed_die "creation decision $id references missing decision $replaces"; return 1; }
      [[ "$target_subject" == "$subject" ]] || { governed_die "creation decision $id replaces a different subject"; return 1; }
    fi
    if [[ "$status" == "approved" ]]; then
      case "$approved_subjects" in *"|$subject|"*) governed_die "competing approved creation decisions for subject: $subject"; return 1 ;; esac
      approved_subjects="${approved_subjects}${subject}|"
    fi
  done < "$rows_file"
  while IFS=$'\t' read -r id subject status replaces; do
    [[ -z "$id" ]] && continue
    current="$id"
    chain="|$id|"
    hops=0
    while :; do
      next=''
      target=''
      while IFS=$'\t' read -r candidate candidate_subject candidate_status candidate_replaces; do
        [[ "$candidate" == "$current" ]] || continue
        target="$candidate_replaces"
        break
      done < "$rows_file"
      [[ -n "$target" ]] || break
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
}
