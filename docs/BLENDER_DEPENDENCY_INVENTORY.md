# Blender Dependency Inventory

Last updated: 2026-07-09

This document records the Windows dependency bundle downloaded by Blender's official update process in the historical 2026-07-09 workspace. It is not an inventory of the current Desktop clone or the Blender 5.0 target.

## Historical Local Bundle

Historical path:

```text
C:\DIG REPO\tools\Muno\upstream\lib\windows_x64
```

Measured size:

```text
19,078 files
about 6.51 GB
```

The generated MUNO `source/` copy also contains this bundle after overlay:

```text
C:\DIG REPO\tools\Muno\source\lib\windows_x64
about 6.51 GB
```

These files are local build dependencies. They should not be committed to the MUNO Git repo.

## Largest Downloaded Components

| Component | Approx. Size | Purpose |
| --- | ---: | --- |
| `llvm` | 4150.1 MB | Compiler/runtime infrastructure used by Blender dependencies, GPU/shader/tooling pieces. |
| `dpcpp` | 405.7 MB | Intel oneAPI/DPC++ support used by Blender's rendering/compute stack. |
| `usd` | 282.0 MB | Universal Scene Description import/export and scene interchange. |
| `python` | 264.1 MB | Embedded Python runtime used by Blender itself and add-ons. |
| `osl` | 248.4 MB | Open Shading Language, used by Cycles/material rendering workflows. |
| `eigen` | 185.6 MB | Math library used by geometry and numerical code. |
| `MaterialX` | 183.8 MB | Material/shader interchange. |
| `manifold` | 121.9 MB | Geometry/mesh boolean and manifold operations. |
| `alembic` | 87.1 MB | Alembic import/export cache format. |
| `abseil` | 73.7 MB | C++ support library used by other dependencies. |
| `harfbuzz` | 65.2 MB | Text shaping. |
| `embree` | 65.1 MB | Intel ray tracing kernels used by rendering. |
| `openimagedenoise` | 63.7 MB | Intel image denoising. |
| `draco` | 47.7 MB | Mesh compression. |
| `ffmpeg` | 45.0 MB | Video/audio import/export. |
| `openpgl` | 41.2 MB | Path guiding library for rendering. |
| `OpenImageIO` | 41.1 MB | Image file I/O. |
| `vulkan` | 41.0 MB | Vulkan graphics/compute support. |
| `openvdb` | 38.5 MB | Volumetric data. |
| `ceres` | 32.1 MB | Solver library used by reconstruction/optimization dependencies. |
| `opencolorio` | 30.0 MB | Color management. |

## Other Downloaded Components

The remaining downloaded folders are:

```text
aom
brotli
epoxy
fftw3
fmt
freetype
Fribidi
gmp
haru
hiprt
imath
jpeg
level-zero
meshoptimizer
openal
openexr
openjpeg
openjph
opensubdiv
png
potrace
pthreads
pugixml
pystring
rubberband
sdl
shaderc
sndfile
tbb
thorvg
tracy
webp
xml2
xr_openxr_sdk
zlib
zstd
```

## Required Windows Toolchain Components

Blender's checked-out Visual Studio config lists these Build Tools components:

```text
Microsoft.VisualStudio.Component.Roslyn.Compiler
Microsoft.Component.MSBuild
Microsoft.VisualStudio.Component.CoreBuildTools
Microsoft.VisualStudio.Workload.MSBuildTools
Microsoft.VisualStudio.Component.Windows11SDK.22621
Microsoft.VisualStudio.Component.VC.CoreBuildTools
Microsoft.VisualStudio.Component.VC.Tools.x86.x64
Microsoft.VisualStudio.Component.VC.Redist.14.Latest
Microsoft.VisualStudio.Component.Windows10SDK.19041
Microsoft.VisualStudio.Component.VC.CMake.Project
Microsoft.VisualStudio.Component.TestTools.BuildTools
Microsoft.VisualStudio.Component.VC.ATL
Microsoft.VisualStudio.Component.VC.ASAN
Microsoft.VisualStudio.Component.TextTemplating
Microsoft.VisualStudio.Component.VC.CoreIde
Microsoft.VisualStudio.ComponentGroup.NativeDesktop.Core
Microsoft.VisualStudio.Workload.VCTools
```

Local validation found these available through `C:\BuildTools`:

- MSVC C/C++ compiler.
- MSBuild.
- CMake from Visual Studio.
- Ninja from Visual Studio.

## Strategy Note

Mixar's public repo does not include this dependency bundle. It only includes their overlay files and a Blender submodule reference. A developer building Mixar locally would still need Blender's source checkout and Windows platform libraries.

For MUNO, the strategic choice is not whether Blender needs these dependencies for a native fork build. It does. The real choice is when we pay this cost:

- Full Blender fork path: keep these dependencies and validate native builds.
- Faster prototype path: build MUNO as an add-on or external controller first, then return to the fork build later.
- Hybrid path: analyze and adapt Mixar's overlay now, but delay further native compile work until MUNO's AI workflow is clearer.
