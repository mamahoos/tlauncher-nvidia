# Agent context: tlauncher-nvidia

## Summary

Bash wrapper that launches TLauncher with NVIDIA PRIME render offload on Linux hybrid-GPU laptops. Changes are scoped to the TLauncher process tree only.

## Commands

| Command | Description |
|---------|-------------|
| `./install.sh` | Install to `~/.local/bin` and app menu |
| `./uninstall.sh` | Remove installed files |
| `tlauncher-nvidia --check` | Validate prerequisites |
| `./tests/smoke.sh` | Smoke tests |
| `shellcheck tlauncher-nvidia install.sh uninstall.sh tests/smoke.sh` | Lint |

## Conventions

- Bash style matches `~/dev/personal/dot-files/scripts/`: section headers, `readonly` config, `_prefix_*` helpers, `main "$@"`
- Errors: `printf '[script] ...\n'` to stderr; `--check` uses `ok` / `fail` / `warn` lines
- Overrides: `TL_JAVA`, `TL_JAR`, `TL_NVIDIA_PROVIDER`
- Default TLauncher paths: `/usr/games/tlauncher/...`

## Boundaries

- Do not change system GLX or global NVIDIA settings
- Do not commit secrets or user-specific paths
- Architectural decisions: `docs/decisions/`

## Key files

| File | Role |
|------|------|
| `tlauncher-nvidia` | Launcher, `--check`, provider auto-detect |
| `install.sh` / `uninstall.sh` | User-local install lifecycle |
| `tlauncher-nvidia.desktop` | App menu entry |
| `docs/decisions/001-prime-render-offload.md` | PRIME offload ADR |

## About

Developed with [Cursor](https://cursor.com).
