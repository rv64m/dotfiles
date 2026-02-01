#!/usr/bin/env bash
set -e

run() {
  if [ "${DOTFILES_QUIET:-0}" = "1" ]; then
    "$@" >/dev/null 2>&1
  else
    "$@"
  fi
}

PLUGIN_DIR="$HOME/.zsh/plugins"
mkdir -p "$PLUGIN_DIR"

if [ ! -d "$PLUGIN_DIR/zsh-autosuggestions" ]; then
  run git clone https://github.com/zsh-users/zsh-autosuggestions.git "$PLUGIN_DIR/zsh-autosuggestions"
fi

if [ ! -d "$PLUGIN_DIR/zsh-syntax-highlighting" ]; then
  run git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$PLUGIN_DIR/zsh-syntax-highlighting"
fi

if [ ! -d "$PLUGIN_DIR/zsh-history-substring-search" ]; then
  run git clone https://github.com/zsh-users/zsh-history-substring-search.git "$PLUGIN_DIR/zsh-history-substring-search"
fi
