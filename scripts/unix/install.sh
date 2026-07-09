#!/usr/bin/env bash
# SPDX-FileCopyrightText: 2026 Adeveda Enterprises Private Limited
#
# SPDX-License-Identifier: GPL-2.0-or-later

set -euo pipefail

# Load all settings from settings.sh
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/settings.sh"

# Define build directory for this environment
BUILD_ENV_DIR="${BUILD_DIR}/${MUNO_ENV}"
BLENDER_BUILD_ENV="Release"

echo "Clearing previous source directory..."
cd "$ROOT_DIR"
rm -rf "$SOURCE_DIR/scripts"
# rm -rf "$BUILD_ENV_DIR/bin/MUNO.app/Contents/Resources/scripts"
mkdir -p "$SOURCE_DIR/scripts"

rsync -a "$UPSTREAM_DIR/scripts/" "$SOURCE_DIR/scripts/"

echo "Overlaying MUNO scripts onto source..."
rsync -av "$SRC_DIR/scripts/" "$SOURCE_DIR/scripts/"

echo "Installing scripts using CMake..."
cmake --build "$BUILD_ENV_DIR" --target install --config "$BLENDER_BUILD_ENV"

echo "Scripts installation complete."
echo "Run MUNO using: $BUILD_ENV_DIR/bin/MUNO.app/Contents/MacOS/MUNO"