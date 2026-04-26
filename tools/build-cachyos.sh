#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PRESET="${1:-linux-release}"
JOBS="${JOBS:-$(nproc)}"

case "$PRESET" in
  linux-release|linux-debug) ;;
  *)
    echo "Unsupported preset: $PRESET" >&2
    echo "Use linux-release or linux-debug." >&2
    exit 2
    ;;
esac

if ! command -v cmake >/dev/null 2>&1; then
  echo "Missing cmake. On CachyOS/Arch run:" >&2
  echo "  sudo pacman -S --needed base-devel cmake ninja qt6-base qt6-tools" >&2
  exit 1
fi

if ! command -v ninja >/dev/null 2>&1; then
  echo "Missing ninja. On CachyOS/Arch run:" >&2
  echo "  sudo pacman -S --needed ninja" >&2
  exit 1
fi

cmake -S "$ROOT_DIR/src" --preset "$PRESET"
cmake --build "$ROOT_DIR/build/$PRESET" --target speedcrunch --parallel "$JOBS"
cmake --install "$ROOT_DIR/build/$PRESET"

if [ "$PRESET" = "linux-debug" ]; then
  echo "Installed build output to: $ROOT_DIR/dist/linux-debug"
else
  echo "Installed build output to: $ROOT_DIR/dist/linux"
fi
