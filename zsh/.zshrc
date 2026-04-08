# Zsh config managed by Dotbot

# Load user env (optional)
if [ -f "$HOME/.config/dotfiles/.env" ]; then
  set -a
  # shellcheck disable=SC1090
  source "$HOME/.config/dotfiles/.env"
  set +a
fi

# Completion
autoload -Uz compinit
compinit

# uv completion
if command -v uv >/dev/null 2>&1; then
  eval "$(uv generate-shell-completion zsh)"
fi

# Starship prompt
if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

# Zsh plugins (manual)
if [ -f "$HOME/.zsh/plugins/z/z.sh" ]; then
  source "$HOME/.zsh/plugins/z/z.sh"
fi
if [ -f "$HOME/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
  source "$HOME/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi
if [ -f "$HOME/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
  source "$HOME/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi
if [ -f "$HOME/.zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh" ]; then
  source "$HOME/.zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh"
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
  bindkey '^P' history-substring-search-up
  bindkey '^N' history-substring-search-down
fi

# Proxy helpers
if [ -f "$HOME/.config/proxy/proxy.sh" ]; then
  source "$HOME/.config/proxy/proxy.sh"
fi

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"

# Coding helper alias
if command -v z-ai-coding-helper >/dev/null 2>&1; then
  alias coding-helper='z-ai-coding-helper'
fi

# User bin
export PATH="$HOME/.local/bin:$PATH"
