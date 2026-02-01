#!/usr/bin/env bash
set -e

run() {
  if [ "${DOTFILES_QUIET:-0}" = "1" ]; then
    "$@" >/dev/null 2>&1
  else
    "$@"
  fi
}

NVM_DIR="${NVM_DIR:-$HOME/.nvm}"
if [ -s "$NVM_DIR/nvm.sh" ]; then
  echo "nvm already installed."
  exit 0
fi

if [ "${DOTFILES_QUIET:-0}" = "1" ]; then
  curl -sS https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash >/dev/null 2>&1
else
  curl -sS https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
fi

# shellcheck disable=SC1090
. "$NVM_DIR/nvm.sh"

run nvm install --lts
run nvm alias default 'lts/*'
