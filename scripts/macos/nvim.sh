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

if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew not found. Installing..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  if [ -f /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
fi

run brew install ninja cmake gettext libtool automake pkg-config

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
