#!/usr/bin/env bash
set -e

run() {
  if [ "${DOTFILES_QUIET:-0}" = "1" ]; then
    "$@" >/dev/null 2>&1
  else
    "$@"
  fi
}

if command -v nvim >/dev/null 2>&1; then
  echo "Neovim already installed."
  exit 0
fi

if ! command -v apt-get >/dev/null 2>&1; then
  echo "This script only supports Ubuntu (apt-get)."
  exit 0
fi

run sudo apt-get update
run sudo apt-get install -y ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl

TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

run git clone https://github.com/neovim/neovim.git "$TMP_DIR/neovim"
cd "$TMP_DIR/neovim"

run git checkout stable
if [ "${DOTFILES_QUIET:-0}" = "1" ]; then
  make CMAKE_BUILD_TYPE=RelWithDebInfo >/dev/null 2>&1
  sudo make install >/dev/null 2>&1
else
  make CMAKE_BUILD_TYPE=RelWithDebInfo
  sudo make install
fi

if command -v nvim >/dev/null 2>&1; then
  echo "Neovim installed."
else
  echo "Neovim install failed."
  exit 1
fi
