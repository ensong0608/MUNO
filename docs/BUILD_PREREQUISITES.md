# Build Prerequisites

This document tracks what MUNO needs to build the generated Blender-based `source/` tree.

Status: initial notes only. These prerequisites have not yet been fully validated on this machine.

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

## First Build Commands To Validate

From `H:\TOOLS\Muno\source`:

```bat
make.bat update
make.bat
```

Expected behavior:

- `make.bat update` fetches required Blender libraries and updates source dependencies.
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
- `cmake` is not currently on PATH.
- `svn` is not currently on PATH.
- `python` is not currently on PATH, though `py` exists.
- `cl` is not currently on PATH from a plain shell.
- Visual Studio Build Tools 2022 is installed at `C:\BuildTools`.
- Blender cannot detect the compiler because the required C++ workload component is missing.

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

The next required machine-level action is to modify `C:\BuildTools` with that config, or manually install the same Visual Studio Build Tools C++ workload through Visual Studio Installer.
