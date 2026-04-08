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

load_brew() {
  if [ -f /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
    return 0
  fi

  if [ -f /usr/local/bin/brew ]; then
    eval "$(/usr/local/bin/brew shellenv)"
    return 0
  fi

  return 1
}

if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew not found. Installing..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

load_brew

run brew update
run brew install git zsh tmux fzf ripgrep neovim uv
run brew upgrade git zsh tmux fzf ripgrep neovim uv
