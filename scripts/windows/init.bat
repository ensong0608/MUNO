REM SPDX-FileCopyrightText: 2026 Adeveda Enterprises Private Limited
REM
REM SPDX-License-Identifier: GPL-2.0-or-later

@echo off
setlocal

set "SCRIPT_DIR=%~dp0"
for %%i in ("%SCRIPT_DIR%..\..") do set "ROOT_DIR=%%~fi"
cd /d "%ROOT_DIR%" || exit /b 1

REM Initialize submodule to the exact commit specified by parent repo
echo Initializing Blender submodule...
set "GIT_LFS_SKIP_SMUDGE=1"
git submodule update --init --recursive --force --progress
if errorlevel 1 (
    echo Failed to initialize submodule
    exit /b 1
)

if not exist "%ROOT_DIR%\upstream\make.bat" (
    echo Error: upstream\make.bat was not found after submodule initialization.
    echo Check that the upstream submodule is pinned in this repository.
    exit /b 1
)

cd /d "%ROOT_DIR%\upstream" || exit /b 1
REM Download LFS files using make update
echo Running make.bat update...
call make.bat update
if errorlevel 1 (
    echo Error: make.bat update failed.
    echo Try running 'make.bat update' manually in the upstream directory.
    exit /b 1
)

echo Pulling LFS files...
git lfs pull
if errorlevel 1 (
    echo Error: git lfs pull failed.
    exit /b 1
)

cd /d "%ROOT_DIR%" || exit /b 1
echo Initialization complete!
exit /b 0
