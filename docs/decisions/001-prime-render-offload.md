# ADR-001: NVIDIA PRIME render offload via environment variables

## Status
Accepted

## Date
2026-07-04

## Context
Hybrid-GPU Linux laptops (Intel + NVIDIA Optimus) often run TLauncher and Minecraft on the integrated GPU, causing poor performance. System-wide GLX vendor switching affects all applications and can break the desktop session.

Requirements:
- Force TLauncher (and its child JVMs) onto the discrete NVIDIA GPU
- Avoid changing global driver or GLX settings
- Work with common Debian/Ubuntu TLauncher installs under `/usr/games/tlauncher`

## Decision
Set NVIDIA PRIME offload environment variables only for the TLauncher process tree:

- `__NV_PRIME_RENDER_OFFLOAD=1`
- `__NV_PRIME_RENDER_OFFLOAD_PROVIDER` (auto-detected from `xrandr`, overridable via `TL_NVIDIA_PROVIDER`)
- `__GLX_VENDOR_LIBRARY_NAME=nvidia`
- `__VK_LAYER_NV_optimus=NVIDIA_only`

Ship a small bash wrapper (`tlauncher-nvidia`) installed to `~/.local/bin` with a desktop entry.

## Alternatives Considered

### `prime-run` / `nvidia-offload`
- Pros: Distro-provided, familiar to users
- Cons: Not available on all systems; naming varies; wrapper keeps behavior explicit and documented

### Global `nvidia-xconfig` / GLX vendor override
- Pros: Applies everywhere without a wrapper
- Cons: Breaks other apps; risky on hybrid laptops; rejected

### `DRI_PRIME=1` (AMD-style)
- Pros: Simple env var
- Cons: Wrong mechanism for NVIDIA Optimus on Linux; rejected

## Consequences
- Safe, scoped GPU selection for TLauncher only
- Users may need to set `TL_NVIDIA_PROVIDER` if auto-detection picks the wrong XRandR provider
- Child Minecraft JVM processes inherit env vars when spawned by TLauncher (see README troubleshooting if not)
