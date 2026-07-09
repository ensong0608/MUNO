#!/usr/bin/env bash
set -euo pipefail

clean=0
if [[ "${1:-}" == "--clean" ]]; then
  clean=1
elif [[ $# -gt 0 ]]; then
  echo "Usage: $0 [--clean]" >&2
  exit 2
fi

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_root="$(cd "$script_dir/../.." && pwd)"
upstream_dir="$repo_root/upstream"
overlay_dir="$repo_root/src"
source_dir="$repo_root/source"

case "$source_dir" in
  "$repo_root"/*) ;;
  *) echo "source path is outside repository: $source_dir" >&2; exit 1 ;;
esac

if [[ ! -d "$upstream_dir" || ! -f "$upstream_dir/CMakeLists.txt" ]]; then
  echo "Missing or invalid upstream checkout. Run: git submodule update --init --recursive" >&2
  exit 1
fi

if [[ -e "$source_dir" ]]; then
  if [[ "$clean" != "1" ]]; then
    echo "source already exists. Re-run with --clean to regenerate it." >&2
    exit 1
  fi
  rm -rf "$source_dir"
fi

mkdir -p "$source_dir"

echo "Copying Blender upstream into source..."
if command -v rsync >/dev/null 2>&1; then
  rsync -a --delete --exclude='.git' "$upstream_dir/" "$source_dir/"
else
  (cd "$upstream_dir" && tar --exclude='.git' -cf - .) | (cd "$source_dir" && tar -xf -)
fi

if [[ -d "$overlay_dir" ]] && find "$overlay_dir" -mindepth 1 ! -name '.gitkeep' | read -r _; then
  echo "Applying MUNO overlay from src..."
  if command -v rsync >/dev/null 2>&1; then
    rsync -a --exclude='.gitkeep' --exclude='.git' "$overlay_dir/" "$source_dir/"
  else
    (cd "$overlay_dir" && tar --exclude='.gitkeep' --exclude='.git' -cf - .) | (cd "$source_dir" && tar -xf -)
  fi
else
  echo "No overlay files found in src; source is a clean Blender copy."
fi

echo "Source generation complete: $source_dir"