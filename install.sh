#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BIN="${HOME}/.local/bin"
APPS="${HOME}/.local/share/applications"

mkdir -p "$BIN" "$APPS"
install -m 755 "$ROOT/tlauncher-nvidia" "$BIN/tlauncher-nvidia"

sed "s|@BIN@|$BIN|g" "$ROOT/tlauncher-nvidia.desktop" > "$APPS/tlauncher-nvidia.desktop"
update-desktop-database "$APPS" 2>/dev/null || true

echo "Installed: $BIN/tlauncher-nvidia"
echo "Desktop entry: $APPS/tlauncher-nvidia.desktop"
