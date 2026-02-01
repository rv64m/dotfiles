#!/usr/bin/env bash
set -e

# Ensure config dirs exist
mkdir -p "$HOME/.config" "$HOME/.config/proxy" "$HOME/.config/dotfiles"

# Backup existing zshrc if it's not a symlink
if [ -e "$HOME/.zshrc" ] && [ ! -L "$HOME/.zshrc" ]; then
  cp "$HOME/.zshrc" "$HOME/.zshrc.bak"
  rm -f "$HOME/.zshrc"
fi
