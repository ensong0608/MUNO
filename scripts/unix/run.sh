#!/usr/bin/env bash
# SPDX-FileCopyrightText: 2026 Adeveda Enterprises Private Limited
#
# SPDX-License-Identifier: GPL-2.0-or-later

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"

# First argument selects the build environment folder (defaults to Dev).
BUILD_ENV="${1:-Dev}"

BINARY="$ROOT_DIR/build/$BUILD_ENV/bin/MUNO.app/Contents/MacOS/MUNO"

if [[ ! -x "$BINARY" ]]; then
	echo "Error: MUNO binary not found at:" >&2
	echo "  $BINARY" >&2
	echo "Make sure ./build/$BUILD_ENV exists and is built." >&2
	exit 1
fi

echo "Launching MUNO from build/$BUILD_ENV..."
exec "$BINARY"
