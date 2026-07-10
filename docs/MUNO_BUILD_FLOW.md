# MUNO Build Flow

This document tracks how MUNO is being built and how closely it follows Mixar.

## Intent

MUNO is intentionally following Mixar's Blender fork structure, then replacing visible identity and backend configuration with MUNO-specific values.

The owner currently wants MUNO for personal use, not commercial distribution. We still keep license notices and remove Mixar trademarks from runtime identity.

## Current Architecture

```text
C:\DIG REPO\tools\Muno
  upstream/   Blender source submodule
  src/        MUNO overlay files
  source/     generated working tree: upstream copied first, src overlaid second
  build/      generated build output
  cmake/      MUNO CMake override files
  scripts/    MUNO build/init/overlay/install helpers
```

This mirrors Mixar's architecture:

```text
mixar-app
  upstream/   Blender source submodule
  src/        Mixar overlay files
  source/     generated Blender + Mixar working tree
  build/      generated build output
```

## Scripts Added From Mixar Pattern

Windows scripts:

```text
scripts/windows/settings.bat
scripts/windows/init.bat
scripts/windows/overlay.bat
scripts/windows/build.bat
scripts/windows/build_clean.bat
scripts/windows/build_ms.bat
scripts/windows/build_ninja.bat
scripts/windows/install.bat
scripts/windows/check_overlay_conflicts.bat
```

Unix scripts:

```text
scripts/unix/settings.sh
scripts/unix/init.sh
scripts/unix/overlay.sh
scripts/unix/build.sh
scripts/unix/build_clean.sh
scripts/unix/install.sh
scripts/unix/run.sh
scripts/unix/check_overlay_conflicts.sh
```

Shared build/config files:

```text
.env.example
VERSION
Makefile
cmake/muno_overrides.cmake
scripts/generate_config.py
scripts/python_requirements.txt
```

## Rebrand Changes In Scripts

The adapted scripts use:

```text
MUNO_ENV
MUNO_BACKEND_URL
MUNO_FRONTEND_URL
MUNO_APP_NAME
MUNO_EXECUTABLE_NAME
MUNO_VENDOR
MUNO_BUNDLE_IDENTIFIER
MUNO_BUNDLE_COPYRIGHT
muno.exe
muno.json
muno_env_config.h
```

Default personal/local URLs are:

```text
MUNO_BACKEND_URL=http://127.0.0.1:8765
MUNO_FRONTEND_URL=http://127.0.0.1:3000
```

MUNO does not point at Mixar's hosted backend.

## Validation Completed

Completed lightweight validation:

1. `scripts/generate_config.py` runs with the Python launcher and generates `tmp/muno.test.json`.
2. `scripts/windows/settings.bat` loads expected MUNO variables.
3. `scripts/windows/overlay.bat` runs successfully against the generated `source/` tree.

Overlay validation result:

- incremental upstream copy completed;
- MUNO overlay copy completed;
- no stderr output;
- `source/` remains ignored by Git.

## Not Validated Yet

The full build is not validated yet.

Known blockers:

- Visual Studio Build Tools exists at `C:\BuildTools`, but the required C++ workload is missing.
- `cmake` is not currently on PATH.
- Mixar's full `src/` overlay has not yet been imported/adapted into MUNO.

Until those are handled, `scripts/windows/build.bat` defines the intended MUNO build flow but should not be expected to produce a working `muno.exe`.

## Next Steps

1. Import/adapt Mixar's `src/` overlay into MUNO's `src/`.
2. Rebrand runtime identity and assets inside the overlay.
3. Stub or redirect Mixar backend clients.
4. Install missing Visual Studio Build Tools C++ workload when approved.
5. Re-run Blender/MUNO build validation.
