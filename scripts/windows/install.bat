REM SPDX-FileCopyrightText: 2026 Adeveda Enterprises Private Limited
REM
REM SPDX-License-Identifier: GPL-2.0-or-later

@echo off
setlocal enabledelayedexpansion

REM MUNO Install Script for Windows
REM Installs scripts using CMake

REM Load all settings from settings.bat
set "SCRIPT_DIR=%~dp0"
call "%SCRIPT_DIR%settings.bat"

REM Use MUNO_ENV directly from settings.bat (loaded from muno.json)
REM Define build directory for this environment
if "%MUNO_ENV%"=="" (
    echo Warning: MUNO_ENV is empty, using fallback Prod
    set "MUNO_ENV=Prod"
)
set "BUILD_ENV_DIR=%BUILD_DIR%\%MUNO_ENV%"
set "BLENDER_BUILD_ENV=Release"

echo Clearing previous source directory...
cd /d "%ROOT_DIR%"
if exist "%SOURCE_DIR%\scripts" rmdir /s /q "%SOURCE_DIR%\scripts"
mkdir "%SOURCE_DIR%\scripts"

robocopy "%UPSTREAM_DIR%\scripts" "%SOURCE_DIR%\scripts" /E /COPY:DAT
if !ERRORLEVEL! GEQ 8 (
    echo Error: Failed to copy upstream scripts
    exit /b 1
)

echo Overlaying MUNO scripts onto source...
robocopy "%SRC_DIR%\scripts" "%SOURCE_DIR%\scripts" /E /COPY:DAT
if !ERRORLEVEL! GEQ 8 (
    echo Error: Failed to overlay MUNO scripts
    exit /b 1
)

REM Reset ERRORLEVEL before cmake
cmd /c "exit /b 0"

echo Installing scripts using CMake...
if defined BUILD_WITH_NINJA (
    cmake --build "%BUILD_ENV_DIR%" --target install
) else (
    cmake --build "%BUILD_ENV_DIR%" --target install --config "%BLENDER_BUILD_ENV%"
)

if !ERRORLEVEL! neq 0 (
    echo Error: Scripts install failed
    exit /b 1
)

echo Scripts installation complete.
echo Run MUNO using: %BUILD_ENV_DIR%\bin\%BLENDER_BUILD_ENV%\muno.exe
exit /b 0
