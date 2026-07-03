# tlauncher-nvidia

Run TLauncher and Minecraft on the discrete NVIDIA GPU on Linux laptops with hybrid graphics (Intel + NVIDIA Optimus). The launcher sets NVIDIA PRIME offload environment variables only for the TLauncher process tree — it does not change system drivers or global GLX settings.

## Quick start

```bash
git clone https://github.com/mamahoos/tlauncher-nvidia.git
cd tlauncher-nvidia
./install.sh
```

Launch **TLauncher (NVIDIA)** from your app menu, or run:

```bash
~/.local/bin/tlauncher-nvidia
```

## Commands

| Command | Description |
|---------|-------------|
| `./install.sh` | Install launcher to `~/.local/bin` and register a desktop entry |
| `./uninstall.sh` | Remove installed launcher and desktop entry |
| `tlauncher-nvidia` | Start TLauncher with NVIDIA PRIME offload |
| `tlauncher-nvidia --check` | Validate Java, JAR, provider, and driver tooling |
| `tlauncher-nvidia --help` | Show usage and environment variables |
| `./tests/smoke.sh` | Run smoke tests (no TLauncher install required) |

## Verify GPU usage

After Minecraft is running:

```bash
nvidia-smi
```

You should see a `java` process using GPU memory. In `latest.log`, the OpenGL renderer should report `NVIDIA`, not `Intel`.

## Configuration

| Variable | Default | Purpose |
|----------|---------|---------|
| `TL_JAVA` | `/usr/games/tlauncher/lib/jvm/jre/bin/java` | TLauncher Java binary |
| `TL_JAR` | `/usr/games/tlauncher/starter-core.jar` | TLauncher starter JAR |
| `TL_NVIDIA_PROVIDER` | auto-detected | XRandR provider name |

When `TL_NVIDIA_PROVIDER` is unset, the launcher picks the first `NVIDIA` entry from `xrandr --listproviders`, falling back to `NVIDIA-G0`.

## Architecture

```
install.sh ──► ~/.local/bin/tlauncher-nvidia
                    │
                    ├── --check  → validate prerequisites
                    └── launch   → PRIME env vars → java -jar starter-core.jar
```

- **Scope:** process-local env vars only (`__NV_PRIME_RENDER_OFFLOAD`, `__GLX_VENDOR_LIBRARY_NAME`, etc.)
- **Install target:** user-local (`~/.local/bin`, `~/.local/share/applications`)
- **Design rationale:** [docs/decisions/001-prime-render-offload.md](docs/decisions/001-prime-render-offload.md)
- **Agent context:** [AGENTS.md](AGENTS.md)

## Troubleshooting

### `--check` reports missing Java or JAR

TLauncher may be installed in a non-default location:

```bash
export TL_JAVA=/path/to/java
export TL_JAR=/path/to/starter-core.jar
~/.local/bin/tlauncher-nvidia --check
```

### Provider warning or wrong GPU

```bash
xrandr --listproviders
export TL_NVIDIA_PROVIDER=NVIDIA-G0   # or NVIDIA-0, etc.
~/.local/bin/tlauncher-nvidia
```

### `nvidia-smi` shows launcher Java but not the game

TLauncher starts a separate JVM for Minecraft. Environment variables usually inherit. If the game still uses Intel:

1. Run `tlauncher-nvidia --check`
2. Inspect `latest.log` for the OpenGL renderer string
3. Launch via **TLauncher (NVIDIA)**, not the default TLauncher shortcut

### Wayland vs X11

PRIME offload targets GLX/X11 paths. On Wayland, try an X11 session or run the game through XWayland.

## Releases

| Tag | Description |
|-----|-------------|
| [v1.0.0](https://github.com/mamahoos/tlauncher-nvidia/releases/tag/v1.0.0) | Minimal PRIME offload wrapper |
| [v1.1.0](https://github.com/mamahoos/tlauncher-nvidia/releases/tag/v1.1.0) | Checks, `--check`, uninstall, CI, and docs |

## About

This project was developed with [Cursor](https://cursor.com) (AI-assisted coding).
