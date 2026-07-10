#!/bin/bash
# SPDX-FileCopyrightText: 2026 Adeveda Enterprises Private Limited
#
# SPDX-License-Identifier: GPL-2.0-or-later

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"
cd "$ROOT_DIR"

# Initialize submodule to the exact commit specified by parent repo
echo "Initializing Blender submodule..."
GIT_LFS_SKIP_SMUDGE=1 git submodule update --init --recursive --force --progress

if [[ ! -f "$ROOT_DIR/upstream/Makefile" ]]; then
    echo "Error: upstream/Makefile was not found after submodule initialization." >&2
    echo "Check that the upstream submodule is pinned in this repository." >&2
    exit 1
fi

cd "$ROOT_DIR/upstream"
# Download LFS files using make update
if ! make update; then
    echo "Error: make update failed." >&2
    echo "Try running 'make update' manually in the upstream directory." >&2
    exit 1
fi
if ! git lfs pull; then
    echo "Error: git lfs pull failed." >&2
    exit 1
fi
cd "$ROOT_DIR"
echo "Initialization complete!"
