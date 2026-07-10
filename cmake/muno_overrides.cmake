# SPDX-FileCopyrightText: 2026 Adeveda Enterprises Private Limited
#
# SPDX-License-Identifier: GPL-3.0-or-later

# This file is loaded *before* any project() call
# You can override ANY cache variable in Blender.

# Only set CMP0167 policy if it's available (CMake 3.30+)
if(POLICY CMP0167)
  cmake_policy(SET CMP0167 OLD)
endif()

# Windows/MSVC: Base compiler flags.
if(CMAKE_HOST_WIN32)
  set(CMAKE_CXX_FLAGS "/DWIN32 /D_WINDOWS /W3 /GR /EHsc" CACHE STRING "C++ compiler flags" FORCE)
  set(CMAKE_C_FLAGS "/DWIN32 /D_WINDOWS /W3" CACHE STRING "C compiler flags" FORCE)
endif()

# NVIDIA SDKs are optional. Keep the clean-clone baseline portable and let
# builders opt in explicitly with -DMUNO_ENABLE_CUDA=ON and/or
# -DMUNO_ENABLE_OPTIX=ON. Command-line -D values override these initial-cache
# defaults because this file is loaded with cmake -C.
set(MUNO_ENABLE_CUDA OFF CACHE BOOL "Build Cycles CUDA support")
set(MUNO_ENABLE_OPTIX OFF CACHE BOOL "Build Cycles OptiX support")

set(WITH_CYCLES_DEVICE_CUDA "${MUNO_ENABLE_CUDA}" CACHE BOOL
    "Enable Cycles NVIDIA CUDA compute support" FORCE)
set(WITH_CYCLES_CUDA_BINARIES "${MUNO_ENABLE_CUDA}" CACHE BOOL
    "Build Cycles NVIDIA CUDA binaries" FORCE)
set(WITH_CUDA_DYNLOAD "${MUNO_ENABLE_CUDA}" CACHE BOOL
    "Dynamically load CUDA libraries at runtime" FORCE)
set(WITH_CYCLES_DEVICE_OPTIX "${MUNO_ENABLE_OPTIX}" CACHE BOOL
    "Enable Cycles NVIDIA OptiX support" FORCE)

# sccache compiler launcher - auto-enabled when sccache is on PATH.
# On Windows, Blender's platform_win32.cmake handles /Z7 and compiler launcher
# when WITH_WINDOWS_SCCACHE is ON. On other platforms, we set the launcher directly.
find_program(SCCACHE_PROGRAM sccache)
if(SCCACHE_PROGRAM)
  message(STATUS "sccache found: ${SCCACHE_PROGRAM}")
  if(CMAKE_HOST_WIN32)
    # Use Blender's native sccache support (handles /Z7, compiler launcher, PDB)
    set(WITH_WINDOWS_SCCACHE ON CACHE BOOL "" FORCE)
  else()
    set(CMAKE_C_COMPILER_LAUNCHER   "${SCCACHE_PROGRAM}" CACHE STRING "" FORCE)
    set(CMAKE_CXX_COMPILER_LAUNCHER "${SCCACHE_PROGRAM}" CACHE STRING "" FORCE)
  endif()
else()
  message(STATUS "sccache not found - building without compiler cache")
endif()
