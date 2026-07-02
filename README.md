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

## Verify

After starting Minecraft:

```bash
nvidia-smi
```

You should see a `java` process using GPU memory. In `latest.log`, OpenGL should report `NVIDIA`, not `Intel`.

## Notes

- Safe: only sets env vars for the TLauncher process tree.
- Default TLauncher paths: `/usr/games/tlauncher/...`
- Override with `TL_JAVA`, `TL_JAR`, or `TL_NVIDIA_PROVIDER` if needed.
- Check provider name: `xrandr --listproviders` (often `NVIDIA-G0`).
