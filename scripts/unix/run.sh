#!/usr/bin/env bash
# SPDX-FileCopyrightText: 2026 Adeveda Enterprises Private Limited
#
# SPDX-License-Identifier: GPL-2.0-or-later

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/settings.sh"

# First argument selects the build environment folder (defaults to Dev).
BUILD_ENV="${1:-Dev}"

BUILD_BIN="$ROOT_DIR/build/$BUILD_ENV/bin"
BINARY=""

if [[ "$PLATFORM" == "macOS" ]]; then
    candidates=(
        "$BUILD_BIN/MUNO.app/Contents/MacOS/MUNO"
        "$BUILD_BIN/Blender.app/Contents/MacOS/Blender"
    )
elif [[ "$PLATFORM" == "Linux" ]]; then
    candidates=(
        "$BUILD_BIN/muno"
        "$BUILD_BIN/blender"
    )
else
    echo "Error: unsupported platform: $PLATFORM" >&2
    exit 1
fi

for candidate in "${candidates[@]}"; do
    if [[ -x "$candidate" ]]; then
        BINARY="$candidate"
        break
    fi
done

if [[ -z "$BINARY" ]]; then
    echo "Error: no runnable MUNO/Blender binary found under:" >&2
    echo "  $BUILD_BIN" >&2
    echo "Make sure build/$BUILD_ENV exists and is built." >&2
    exit 1
fi

echo "Launching MUNO from build/$BUILD_ENV..."
exec "$BINARY"
