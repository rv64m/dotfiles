#!/usr/bin/env bash
set -e

run() {
  if [ "${DOTFILES_QUIET:-0}" = "1" ]; then
    "$@" >/dev/null 2>&1
  else
    "$@"
  fi
}

if ! command -v node >/dev/null 2>&1; then
  echo "Node.js not found. Install via nvm first."
  exit 0
fi

if command -v claude >/dev/null 2>&1; then
  echo "Claude Code already installed."
  exit 0
fi

run npm install -g @anthropic-ai/claude-code
