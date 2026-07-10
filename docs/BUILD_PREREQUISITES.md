# Build Prerequisites

This document tracks what MUNO needs to build the generated Blender-based `source/` tree.

Status: historical toolchain validation exists, but this clone and the new Blender 5.0 target have not been validated.

## Windows

Blender's checked-out `upstream/make.bat` is the main Windows build entrypoint. It performs an out-of-source CMake build in a sibling build directory and detects Visual Studio automatically.

Local upstream references found in this checkout:

- `upstream/make.bat`
- `upstream/build_files/build_environment/windows/vmprep.cmd.txt`
- `upstream/build_files/build_environment/windows/vsconfig`

Initial Windows requirements from those upstream files:

- Git
- CMake
- Visual Studio 2022 Build Tools with Blender's required workloads
- Blender platform libraries, normally fetched by Blender's update process
- Optional GPU/toolchain dependencies depending on build target, such as CUDA or HIP

The upstream VM prep reference in this checkout mentions:

- Visual Studio 2022 Build Tools 17.14.14
- CMake 3.31.7
- Git 2.38.0
- Meson 1.9.1
- CUDA 12.8.0
- HIP 7.1.51803

Do not treat those exact versions as final MUNO policy until we validate a local build. They are recorded because they are present in the Blender checkout currently pinned by MUNO.

## Dependency Update Commands

Run Blender's dependency update from the real Blender Git checkout:

```bat
cd /d "<MUNO_REPO>\upstream"
make.bat update
```

Do not run `make.bat update` from `source/`. That directory is generated and is not a Git working tree, so Blender's submodule/LFS update commands can fail there.

After dependency updates, regenerate the MUNO source tree:

```bat
cd /d "<MUNO_REPO>"
scripts\windows\overlay.bat
```

## First Build Commands To Validate

From `source/`:

```bat
make.bat
```

Expected behavior:

- `make.bat` configures and builds with CMake using the detected Windows compiler.

## Known Risks

- Build dependencies may be large.
- `make.bat update` may require network access and could take a long time.
- Windows path length can be a problem for Blender builds.
- Building on a network-backed drive may be slower than a local SSD.
- Some optional GPU dependencies may not be needed for the first development build.

## MUNO Policy

- Keep `source/` generated and ignored.
- Keep `build/` generated and ignored.
- Record every failed build prerequisite in `docs/PROJECT_LOG.md`.
- Do not install system-wide dependencies without explicit approval.
## Local Validation Results

Initial validation on this machine found:

- Git is available at `C:\Program Files\Git\cmd\git.exe`.
- Python launcher is available at `C:\Windows\py.exe`.
- `cmake` is not currently on PATH from a plain terminal.
- `svn` is not currently on PATH.
- `python` is not currently on PATH, though `py` exists.
- `cl` is not currently on PATH from a plain shell.
- Visual Studio Build Tools 2022 is installed at `C:\BuildTools`.
- Blender can detect MSVC from the Visual Studio developer environment after the C++ workload installation.

The failing Blender diagnostic was:

```text
make.bat update 2022b verbose
```

Important output:

```text
Visual Studio is detected but no suitable installation was found.
Check the "Desktop development with C++" workload has been installed.
Visual Studio 2022 not found
```

`vswhere` with Blender's required C++ component returned no matching instances:

```text
vswhere -all -products * -requires Microsoft.VisualStudio.Component.VC.Tools.x86.x64
```

The Blender checkout provides the desired Visual Studio component list at:

```text
source\build_files\build_environment\windows\vsconfig
```

The Visual Studio C++ workload blocker has been resolved. The next build validation should use the Visual Studio developer environment so CMake, Ninja, and MSVC are available.

Historical note: the 2026-07-09 checkout at `C:\DIG REPO\tools\Muno` installed as Blender `5.3.0 Alpha` and used embedded Python `3.13.13`:

```text
C:\DIG REPO\tools\Muno\build\Prod\bin\5.3\python\bin\python.exe
```

That historical baseline build used:

```bat
set BUILD_CORES=6
set ROBOCOPY_THREADS=8
scripts\windows\build_ninja.bat
```

Using `BUILD_CORES=10` made the PC freeze during the first compile. Prefer `6` on this machine unless we intentionally retest higher parallelism.

## Local Dependency Bundle Size

Blender's Windows dependency bundle is intentionally large:

- historical `upstream/lib/windows_x64`: about 6.51 GB;
- historical generated `source/lib/windows_x64`: about 6.51 GB after overlay copy.

This bundle is not app code and should not be committed to the MUNO Git repo.
