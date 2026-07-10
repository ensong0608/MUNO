# Source Generation Workflow

MUNO uses an overlay workflow so the repository stays small while still producing a complete Blender-based source tree locally. Run all commands from the repository root.

## Directories

```text
upstream/  Blender submodule checkout
src/       MUNO overlay files
source/    generated local source tree, ignored by Git
build/     generated build output, ignored by Git
```

## Windows

Generate `source/` from `upstream/` and `src/`:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\windows\generate-source.ps1
```

Regenerate from scratch:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\windows\generate-source.ps1 -Clean
```

The script uses `robocopy`. Exit codes `0` through `7` are treated as success, following normal `robocopy` behavior.

## Unix-like Systems

Generate `source/`:

```bash
./scripts/unix/generate-source.sh
```

Regenerate from scratch:

```bash
./scripts/unix/generate-source.sh --clean
```

The script uses `rsync` when available and falls back to `tar`.

## Safety Rules

- `source/` is generated and should not be committed.
- `build/` is generated and should not be committed.
- MUNO changes should be made in `src/`, then regenerated into `source/`.
- Do not edit `upstream/` directly unless we are intentionally updating or testing Blender itself.
- Do not rely on Mixar backend services; MUNO must own or configure its own backend.

## Current State

In the current Desktop clone, `src/` contains only `.gitkeep`, `upstream/` is not initialized, and `source/` does not exist. Initialize and pin the agreed Blender 5.0 base before using the generator. Historical Blender 5.3-alpha generation in another checkout does not establish the current target.
