#!/usr/bin/env bash
set -e

run() {
  if [ "${DOTFILES_QUIET:-0}" = "1" ]; then
    "$@" >/dev/null 2>&1
  else
    "$@"
  fi
}

if command -v starship >/dev/null 2>&1; then
  echo "Starship already installed."
  exit 0
fi

if [ "${DOTFILES_QUIET:-0}" = "1" ]; then
  curl -sS https://starship.rs/install.sh | sh -s -- -y >/dev/null 2>&1
else
  curl -sS https://starship.rs/install.sh | sh -s -- -y
fi
