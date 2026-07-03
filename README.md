# tlauncher-nvidia

Run TLauncher (Minecraft) on the discrete NVIDIA GPU on Linux hybrid-GPU laptops (Optimus).

## Install

```bash
./install.sh
```

Then launch **TLauncher (NVIDIA)** from your app menu, or run:

```bash
~/.local/bin/tlauncher-nvidia
```

## Uninstall

```bash
./uninstall.sh
```

## Check prerequisites

Validate Java, JAR, provider, and driver tooling without starting the game:

```bash
~/.local/bin/tlauncher-nvidia --check
```

## Verify

After starting Minecraft:

```bash
nvidia-smi
```

You should see a `java` process using GPU memory. In `latest.log`, OpenGL should report `NVIDIA`, not `Intel`.

## Configuration

| Variable | Default | Purpose |
|----------|---------|---------|
| `TL_JAVA` | `/usr/games/tlauncher/lib/jvm/jre/bin/java` | TLauncher Java binary |
| `TL_JAR` | `/usr/games/tlauncher/starter-core.jar` | TLauncher starter JAR |
| `TL_NVIDIA_PROVIDER` | auto-detected | XRandR provider name |

Provider auto-detection uses the first `NVIDIA` entry from `xrandr --listproviders`, falling back to `NVIDIA-G0`.

## Troubleshooting

### `--check` reports missing Java or JAR

TLauncher may be installed elsewhere. Set overrides:

```bash
export TL_JAVA=/path/to/java
export TL_JAR=/path/to/starter-core.jar
~/.local/bin/tlauncher-nvidia --check
```

### Provider warning or wrong GPU still used

List providers and set explicitly:

```bash
xrandr --listproviders
export TL_NVIDIA_PROVIDER=NVIDIA-G0   # or NVIDIA-0, etc.
~/.local/bin/tlauncher-nvidia
```

### `nvidia-smi` shows launcher Java but not the game

TLauncher spawns a separate JVM for Minecraft. Env vars normally inherit; if the game still uses Intel:

1. Confirm offload with `tlauncher-nvidia --check`
2. Check `latest.log` for the OpenGL renderer string
3. Ensure you launched via **TLauncher (NVIDIA)**, not the default TLauncher shortcut

### Wayland vs X11

PRIME offload targets GLX/X11 paths. If rendering fails on Wayland, try an X11 session or ensure the game runs through XWayland.

## Notes

- Safe: only sets env vars for the TLauncher process tree.
- Design rationale: [docs/decisions/001-prime-render-offload.md](docs/decisions/001-prime-render-offload.md)
