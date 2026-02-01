#!/usr/bin/env bash
set -e

run() {
  if [ "${DOTFILES_QUIET:-0}" = "1" ]; then
    "$@" >/dev/null 2>&1
  else
    "$@"
  fi
}

if ! command -v apt-get >/dev/null 2>&1; then
  echo "This script only supports Ubuntu (apt-get)."
  exit 0
fi

run sudo apt-get update
run sudo apt-get install -y git curl wget zsh tmux fzf ripgrep fontconfig
