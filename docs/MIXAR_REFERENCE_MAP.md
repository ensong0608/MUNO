# Mixar Reference Map

This document records what we learned from the local Mixar reference clone and how MUNO should copy the approach.

Current local Mixar reference path:

```text
C:\Users\lawre\Desktop\PROJECTS\mixar-app-upstream
```

Reference commit inspected:

```text
47557b7 Merge pull request #914 from Mixar-AI/develop
```

## Completeness Warning

The inspected public repository is a partial reference, not a reproducible copy of the shipped Mixar application. Its declared Blender submodule does not have a committed gitlink in the inspected tree, required native Mixie Chat editor sources are absent, and the hosted Mixie agent/backend is not published.

MUNO can adapt the public overlay and reconstruct missing behavior, but cannot obtain an exact working product through a blind copy.

## What We Are Copying

We are copying Mixar's architecture pattern:

```text
upstream/   Blender source submodule
src/        app-specific overlay files
source/     generated working tree: upstream copied first, src overlaid second
build/      generated build output
scripts/    init, overlay, build, install, run helpers
cmake/      app-specific CMake overrides
.env        local runtime/build environment values
```

Mixar's own README describes the build flow as:

1. clone with Blender submodule;
2. initialize submodules and LFS assets;
3. configure `.env`;
4. run build scripts;
5. build output lands under `build/<env>/bin/`.

## Mixar Files That Prove The Pattern

Key files in the Mixar reference repo:

```text
.gitmodules
README.md
Makefile
.env.example
scripts/windows/settings.bat
scripts/windows/init.bat
scripts/windows/overlay.bat
scripts/windows/build.bat
scripts/unix/settings.sh
scripts/unix/init.sh
scripts/unix/overlay.sh
scripts/unix/build.sh
scripts/generate_config.py
cmake/mixar_overrides.cmake
src/
```

## Build Flow To Mirror

Mixar's Windows flow is roughly:

1. `scripts/windows/init.bat`
   - initializes Blender submodule;
   - runs Blender update/LFS steps.

2. `scripts/windows/settings.bat`
   - loads `.env`;
   - sets app identity, backend URLs, source/build directories, CPU count, CMake generator.

3. `scripts/windows/overlay.bat`
   - copies `upstream/` into `source/`;
   - overlays `src/` on top of `source/`;
   - makes app overlay files win over Blender files.

4. `scripts/windows/build.bat`
   - runs overlay;
   - generates environment config headers;
   - configures CMake;
   - builds;
   - installs artifacts;
   - installs Python packages into Blender's embedded Python.

MUNO should mirror this instead of using ad hoc build steps.

## Important Difference From Our First Script

Our first `scripts/windows/generate-source.ps1` proved the copy step works, but it is more generic than Mixar's actual flow.

Mixar's `overlay.bat` uses incremental `robocopy` behavior:

- upstream copy uses `/E /XO /MT` so unchanged files are skipped;
- overlay copy does not use `/XO` because app overlay files must always win over upstream files;
- Git metadata and source-control noise are excluded.

MUNO should adopt this behavior in its Windows overlay script.

## Rebrand Scope

To make MUNO a personal rebrand of Mixar, we must replace visible identity and avoid using Mixar's trademarks.

Areas to rebrand:

```text
.env.example
README/docs
VERSION or app version metadata
scripts/windows/settings.bat
scripts/unix/settings.sh
scripts/generate_config.py
cmake/mixar_overrides.cmake
src/CMakeLists.txt
src/GNUmakefile
src/scripts/mixar/              # likely rename package later
src/release/datafiles/
src/release/windows/
src/release/darwin/
src/release/freedesktop/
icons, splash images, manifests, installer metadata
```

Names to track:

```text
Mixar
Mixie
mixar
mixar.app
api.mixar.app
www.mixar.app
uat.mixar.app
com.mixar.mixar
```

MUNO replacements will likely be:

```text
MUNO
Muno
muno
local/personal backend URL or disabled backend
com.muno.muno
```

Exact naming convention still needs to be decided before mass renaming.

## Backend Scope

Mixar's README says the hosted AI backend is not included. The local source contains clients and UI that call Mixar services.

Known backend/config references include:

```text
MIXAR_BACKEND_URL
MIXAR_FRONTEND_URL
scripts/generate_config.py
src/scripts/mixar/modules/common/api/
src/scripts/mixar/modules/auth/
src/scripts/mixar/modules/byok/
src/scripts/mixar/modules/common/job_queue/
src/scripts/mixar/modules/common/api/services/scene_gen_service.py
```

For personal MUNO use, we have three options:

1. Stub backend calls so the app launches and non-AI features work.
2. Keep BYOK/OpenAI-style local provider paths where possible.
3. Build a small MUNO backend later for prompt-to-scene.

Recommendation: first make a rebranded build launch without relying on Mixar services. Then implement prompt-to-scene against our own local/backend path.

## Personal Use Note

The owner currently wants MUNO for personal use, not commercial distribution.

That lowers product/release pressure, but it does not eliminate license and trademark hygiene. We should still remove Mixar names/logos from the app before using or sharing binaries, and we should keep upstream license notices intact.

## Current Next Steps

1. Add MUNO scripts that mirror Mixar's `settings.bat`, `overlay.bat`, and `build.bat` structure.
2. Copy/import Mixar's repo-level build files and adapt names to MUNO.
3. Import reviewed slices into a MUNO-owned package structure, using temporary compatibility shims only where needed.
4. Rebrand app metadata and assets.
5. Stub/redirect Mixar backend URLs.
6. Validate each slice against the agreed Blender 5.0 base.
## MUNO Build Scripts Added

MUNO now has adapted versions of Mixar's repo-level build scripts. These preserve the Mixar build pattern but use MUNO names and local backend defaults.

The scripts are not a full working app by themselves. Mixar's public `src/` overlay still needs to be imported/adapted, missing source must be reconstructed, and the current clone still needs an initialized Blender 5.0 source tree.
