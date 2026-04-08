#!/usr/bin/env bash
set -e

run() {
  if [ "${DOTFILES_QUIET:-0}" = "1" ]; then
    "$@" >/dev/null 2>&1
  else
    printf '==> %s\n' "$*"
    "$@"
  fi
}

if ! command -v brew >/dev/null 2>&1; then
  if [ -f /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [ -f /usr/local/bin/brew ]; then
    eval "$(/usr/local/bin/brew shellenv)"
  else
    echo "Homebrew is required to install Starship on macOS. Run scripts/macos/packages.sh first."
    exit 1
  fi
fi

run brew install starship
run brew upgrade starship
