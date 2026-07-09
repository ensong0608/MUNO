#!/bin/bash
# SPDX-FileCopyrightText: 2026 Adeveda Enterprises Private Limited
#
# SPDX-License-Identifier: GPL-2.0-or-later

# MUNO Application Settings
# Source this file in scripts that need these settings
#
# Configuration priority:
#   1. Environment variables (already set, e.g. from CI or parent shell)
#   2. .env file in repo root (local dev overrides)
#   3. Hardcoded defaults below

# Get the root directory relative to this settings.sh script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"
export ROOT_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"

# Load .env if it exists (local dev overrides)
ENV_FILE="$ROOT_DIR/.env"
if [ -f "$ENV_FILE" ]; then
    set -a
    # shellcheck disable=SC1090
    source "$ENV_FILE"
    set +a
fi

# Version always comes from VERSION file (canonical source)
if [ -z "${MUNO_VERSION:-}" ]; then
    VERSION_FILE="$ROOT_DIR/VERSION"
    if [ -f "$VERSION_FILE" ]; then
        export MUNO_VERSION="$(cat "$VERSION_FILE" | tr -d '[:space:]')"
    else
        export MUNO_VERSION="0.0.0"
    fi
fi

# Core environment settings (env var > .env > default)
export MUNO_ENV="${MUNO_ENV:-Prod}"
export MUNO_BACKEND_URL="${MUNO_BACKEND_URL:-http://127.0.0.1:8765}"
export MUNO_FRONTEND_URL="${MUNO_FRONTEND_URL:-http://127.0.0.1:3000}"

# App info (constants)
export MUNO_VERSION_PATCH="${MUNO_VERSION_PATCH:-0}"
export MUNO_APP_NAME="${MUNO_APP_NAME:-MUNO}"
export MUNO_EXECUTABLE_NAME="${MUNO_EXECUTABLE_NAME:-muno}"
export MUNO_DESCRIPTION="${MUNO_DESCRIPTION:-AI Native 3D Content Creation Software}"
export MUNO_VENDOR="${MUNO_VENDOR:-MUNO}"
export MUNO_WEBSITE="${MUNO_WEBSITE:-http://127.0.0.1:3000}"

# Bundle settings (constants)
export MUNO_BUNDLE_IDENTIFIER="${MUNO_BUNDLE_IDENTIFIER:-com.muno.muno}"
export MUNO_BUNDLE_COPYRIGHT="${MUNO_BUNDLE_COPYRIGHT:-(C) 2026 MUNO}"

# Build settings (constants)
export BLENDER_VERSION="${BLENDER_VERSION:-5.0}"
export PYTHON_VERSION="${PYTHON_VERSION:-3.11}"
export REQUIRED_CMAKE_VERSION="${REQUIRED_CMAKE_VERSION:-3.16}"

# Directory Structure
export BUILD_DIR="${ROOT_DIR}/build"
export SOURCE_DIR="${ROOT_DIR}/source"
export SRC_DIR="${ROOT_DIR}/src"
export CMAKE_DIR="${ROOT_DIR}/cmake"

# Upstream Blender tree (multi-GB, gitignored - populated once per machine).
# Linked git worktrees don't carry ignored files, so a worktree checkout has
# no upstream/ of its own. Resolution order:
#   1. MUNO_UPSTREAM_DIR (env / .env override)
#   2. this checkout's own upstream/ (a real tree, not an empty dir)
#   3. the main checkout's upstream/ (worktrees share it - overlay.sh only
#      ever READS from $UPSTREAM_DIR, so sharing is safe)
if [ -n "${MUNO_UPSTREAM_DIR:-}" ]; then
    export UPSTREAM_DIR="$MUNO_UPSTREAM_DIR"
elif [ -f "${ROOT_DIR}/upstream/CMakeLists.txt" ]; then
    export UPSTREAM_DIR="${ROOT_DIR}/upstream"
else
    _git_common_dir="$(git -C "$ROOT_DIR" rev-parse --path-format=absolute --git-common-dir 2>/dev/null || true)"
    _main_checkout_root="${_git_common_dir%/.git}"
    if [ -n "$_git_common_dir" ] && [ -f "${_main_checkout_root}/upstream/CMakeLists.txt" ]; then
        export UPSTREAM_DIR="${_main_checkout_root}/upstream"
        echo "Worktree checkout: sharing upstream from main checkout: $UPSTREAM_DIR" >&2
        # upstream is a submodule pinned per branch - warn (don't fail) when
        # the shared tree isn't at the commit THIS branch pins, so a silent
        # wrong-revision build can't sneak past.
        _pinned="$(git -C "$ROOT_DIR" rev-parse HEAD:upstream 2>/dev/null || true)"
        _actual="$(git -C "$UPSTREAM_DIR" rev-parse HEAD 2>/dev/null || true)"
        if [ -n "$_pinned" ] && [ -n "$_actual" ] && [ "$_pinned" != "$_actual" ]; then
            echo "WARNING: shared upstream is at ${_actual:0:12} but this branch pins ${_pinned:0:12}." >&2
            echo "         Update it (git -C \"$UPSTREAM_DIR\" checkout $_pinned) or set MUNO_UPSTREAM_DIR." >&2
        fi
        unset _pinned _actual
    else
        # No usable upstream anywhere - keep the default path so the
        # overlay's error message points at the expected location.
        export UPSTREAM_DIR="${ROOT_DIR}/upstream"
    fi
    unset _git_common_dir _main_checkout_root
fi

# Platform-specific settings
if [[ "$OSTYPE" == "darwin"* ]]; then
    export PLATFORM="macOS"
    DEFAULT_CORES=$(sysctl -n hw.ncpu)
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    export PLATFORM="Linux"
    DEFAULT_CORES=$(nproc)
else
    export PLATFORM="Unknown"
    DEFAULT_CORES=4
fi

# Build optimization - define BUILD_CORES before using it
export BUILD_CORES=${BUILD_CORES:-$DEFAULT_CORES}

# Platform-specific build settings (now that BUILD_CORES is defined)
if [[ "$PLATFORM" == "macOS" ]]; then
    # macOS-specific settings
    export CMAKE_GENERATOR_ARGS=""  # Use default (Xcode or Make)
    export BUILD_ARGS="--parallel $BUILD_CORES --config \$CMAKE_BUILD_TYPE"
elif [[ "$PLATFORM" == "Linux" ]]; then
    # Linux-specific settings
    export CMAKE_GENERATOR_ARGS=""  # Use default (Make or Ninja)
    export BUILD_ARGS="--parallel $BUILD_CORES --verbose"
else
    # Generic fallback settings
    export CMAKE_GENERATOR_ARGS=""
    export BUILD_ARGS="--parallel $BUILD_CORES"
fi
