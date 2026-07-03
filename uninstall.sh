#!/usr/bin/env bash
set -euo pipefail

# ==============================================================================
# CONFIG
# ==============================================================================

readonly INSTALL_BIN="${HOME}/.local/bin/tlauncher-nvidia"
readonly INSTALL_DESKTOP="${HOME}/.local/share/applications/tlauncher-nvidia.desktop"

# ==============================================================================
# UNINSTALL
# ==============================================================================

main() {
  local removed=0

  if [[ -f "$INSTALL_BIN" ]]; then
    rm -f "$INSTALL_BIN"
    printf 'Removed: %s\n' "$INSTALL_BIN"
    removed=1
  fi

  if [[ -f "$INSTALL_DESKTOP" ]]; then
    rm -f "$INSTALL_DESKTOP"
    printf 'Removed: %s\n' "$INSTALL_DESKTOP"
    removed=1
    update-desktop-database "${HOME}/.local/share/applications" 2>/dev/null || true
  fi

  if [[ "$removed" -eq 0 ]]; then
    printf 'Nothing to uninstall (files not found).\n'
  fi
}

main "$@"
