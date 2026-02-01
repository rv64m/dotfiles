#!/usr/bin/env bash
set -e

run() {
  if [ "${DOTFILES_QUIET:-0}" = "1" ]; then
    "$@" >/dev/null 2>&1
  else
    "$@"
  fi
}

SRC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)/fronts"
DST_DIR="$HOME/Library/Fonts"

mkdir -p "$DST_DIR"

run find "$SRC_DIR" -type f -name "*.ttf" -exec cp -f {} "$DST_DIR" \;
