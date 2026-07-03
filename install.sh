#!/usr/bin/env bash
set -euo pipefail

# ==============================================================================
# CONFIG
# ==============================================================================

readonly SCRIPT_NAME="${0##*/}"
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly REPO_ROOT
readonly INSTALL_BIN="${HOME}/.local/bin"
readonly INSTALL_APPS="${HOME}/.local/share/applications"

# ==============================================================================
# LOGGING
# ==============================================================================

_install_error() {
  printf '[%s] %s\n' "$SCRIPT_NAME" "$*" >&2
}

# ==============================================================================
# INSTALL
# ==============================================================================

_install_launcher() {
  mkdir -p "$INSTALL_BIN" "$INSTALL_APPS"
  install -m 755 "$REPO_ROOT/tlauncher-nvidia" "$INSTALL_BIN/tlauncher-nvidia"
  sed "s|@BIN@|$INSTALL_BIN|g" "$REPO_ROOT/tlauncher-nvidia.desktop" \
    >"$INSTALL_APPS/tlauncher-nvidia.desktop"
  update-desktop-database "$INSTALL_APPS" 2>/dev/null || true
}

# ==============================================================================
# MAIN
# ==============================================================================

main() {
  if [[ ! -f "$REPO_ROOT/tlauncher-nvidia" ]]; then
    _install_error "launcher not found: $REPO_ROOT/tlauncher-nvidia"
    return 1
  fi

  if [[ ! -f "$REPO_ROOT/tlauncher-nvidia.desktop" ]]; then
    _install_error "desktop entry not found: $REPO_ROOT/tlauncher-nvidia.desktop"
    return 1
  fi

  _install_launcher
  printf 'Installed: %s/tlauncher-nvidia\n' "$INSTALL_BIN"
  printf 'Desktop entry: %s/tlauncher-nvidia.desktop\n' "$INSTALL_APPS"
}

main "$@"
