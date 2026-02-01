$ErrorActionPreference = "Stop"

if ($env:DOTFILES_QUIET -eq "1") {
  $ProgressPreference = "SilentlyContinue"
}

if (-not (Get-Command node -ErrorAction SilentlyContinue)) {
  Write-Host "Node.js not found. Install Node.js first (nvm or winget)."
  exit 0
}

if (Get-Command z-ai-coding-helper -ErrorAction SilentlyContinue) {
  Write-Host "@z_ai/coding-helper already installed."
  exit 0
}

if ($env:DOTFILES_QUIET -eq "1") {
  npm install -g @z_ai/coding-helper | Out-Null
} else {
  npm install -g @z_ai/coding-helper
}
