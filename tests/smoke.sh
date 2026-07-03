#!/usr/bin/env bash
set -euo pipefail

# ==============================================================================
# CONFIG
# ==============================================================================

readonly SCRIPT_NAME="${0##*/}"
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
readonly REPO_ROOT
readonly LAUNCHER="$REPO_ROOT/tlauncher-nvidia"

# ==============================================================================
# LOGGING
# ==============================================================================

_smoke_error() {
  printf '[%s] FAIL: %s\n' "$SCRIPT_NAME" "$*" >&2
  exit 1
}

_smoke_pass() {
  printf '[%s] PASS: %s\n' "$SCRIPT_NAME" "$*"
}

# ==============================================================================
# TESTS
# ==============================================================================

_test_help() {
  "$LAUNCHER" --help >/dev/null || _smoke_error '--help should exit 0'
  _smoke_pass '--help'
}

_test_check_exit_status() {
  if TL_JAVA=/nonexistent/java TL_JAR=/nonexistent.jar "$LAUNCHER" --check 2>/dev/null; then
    _smoke_error '--check should fail when Java/JAR missing'
  fi
  _smoke_pass '--check fails on missing prerequisites'
}

_test_check_messages() {
  local output=''

  output="$(TL_JAVA=/nonexistent/java TL_JAR=/nonexistent.jar "$LAUNCHER" --check 2>&1)" || true

  [[ "$output" == *'Java not found or not executable'* ]] \
    || _smoke_error '--check should mention missing Java'
  _smoke_pass '--check reports missing Java'

  [[ "$output" == *'JAR not found'* ]] \
    || _smoke_error '--check should mention missing JAR'
  _smoke_pass '--check reports missing JAR'
}

# ==============================================================================
# MAIN
# ==============================================================================

main() {
  _test_help
  _test_check_exit_status
  _test_check_messages
  printf '[%s] All smoke tests passed.\n' "$SCRIPT_NAME"
}

main "$@"
