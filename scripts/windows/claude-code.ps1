$ErrorActionPreference = "Stop"

if ($env:DOTFILES_QUIET -eq "1") {
  $ProgressPreference = "SilentlyContinue"
}

if (-not (Get-Command node -ErrorAction SilentlyContinue)) {
  Write-Host "Node.js not found. Install Node.js first (nvm or winget)."
  exit 0
}

if (Get-Command claude -ErrorAction SilentlyContinue) {
  Write-Host "Claude Code already installed."
  exit 0
}

if ($env:DOTFILES_QUIET -eq "1") {
  npm install -g @anthropic-ai/claude-code | Out-Null
} else {
  npm install -g @anthropic-ai/claude-code
}
