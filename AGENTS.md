# Agent context: tlauncher-nvidia

## What this project does
Bash wrapper that launches TLauncher with NVIDIA PRIME render offload on Linux hybrid-GPU laptops. No system-wide driver changes.

## Tech stack
- Bash (`tlauncher-nvidia`, `install.sh`, `uninstall.sh`)
- Freedesktop `.desktop` entry
- GitHub Actions + ShellCheck for CI

## Commands
| Command | Description |
|---------|-------------|
| `./install.sh` | Install to `~/.local/bin` and app menu |
| `./uninstall.sh` | Remove installed files |
| `~/.local/bin/tlauncher-nvidia --check` | Validate prerequisites |
| `shellcheck *.sh tlauncher-nvidia` | Lint bash scripts |

## Conventions
- Bash style matches `~/dev/personal/dot-files/scripts/`: section headers, `readonly` config, `_prefix_*` helpers, `main "$@"`
- Keep scripts minimal; prefer guard clauses over deep nesting
- User-facing errors via `printf '[script] ...\n'` to stderr; `--check` status via `ok` / `fail` / `warn` lines
- Override paths via `TL_JAVA`, `TL_JAR`, `TL_NVIDIA_PROVIDER`
- Default TLauncher install: `/usr/games/tlauncher/...`

## Boundaries
- Do not change system GLX or global NVIDIA settings
- Do not commit secrets or user-specific paths
- Architectural rationale lives in `docs/decisions/`

## Key files
- `tlauncher-nvidia` — main launcher with `--check` and provider auto-detect
- `install.sh` / `uninstall.sh` — user-local install lifecycle
- `tlauncher-nvidia.desktop` — app menu entry (`StartupWMClass=tlauncher`)
