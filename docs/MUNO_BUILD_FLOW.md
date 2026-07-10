# MUNO Build Flow

This document tracks how MUNO is being built and how closely it follows Mixar.

## Intent

MUNO is intentionally following Mixar's Blender fork structure, then replacing visible identity and backend configuration with MUNO-specific values.

The owner currently wants MUNO for personal use, not commercial distribution. We still keep license notices and remove Mixar trademarks from runtime identity.

## Current Architecture

```text
<repository root>
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

## Native Build Validation

The baseline Windows Ninja build was historically validated from:

```text
C:\DIG REPO\tools\Muno
```

Validated output:

- `C:\DIG REPO\tools\Muno\build\Prod\bin\muno.exe`
- `C:\DIG REPO\tools\Muno\build\Prod\bin\5.3\config\muno.json`
- embedded Python package installation under `bin\5.3\python\lib\site-packages`

Recommended local settings for this machine:

```bat
set BUILD_CORES=6
set ROBOCOPY_THREADS=8
scripts\windows\build_ninja.bat
```

Those outputs belong to the historical `C:\DIG REPO\tools\Muno` workspace. The current Desktop clone has no generated source or build output. The earlier `muno.exe` was only a copied Blender 5.3-alpha baseline executable; it did not contain MUNO UI or AI features.

## Next Steps

1. Pin and validate the agreed Blender 5.0 base in this clone.
2. Import the usable public Mixar overlay in reviewable slices.
3. Rebrand runtime identity and reconstruct missing native UI pieces.
4. Replace Mixie/backend coupling with local Codex app-server.
5. Re-run incremental build validation after every import slice.
