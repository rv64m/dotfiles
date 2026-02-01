$ErrorActionPreference = "Stop"

if ($env:DOTFILES_QUIET -eq "1") {
  $ProgressPreference = "SilentlyContinue"
}

function Install-Winget($id) {
  if ($env:DOTFILES_QUIET -eq "1") {
    winget install -e --id $id | Out-Null
  } else {
    Write-Host "Installing $id..."
    winget install -e --id $id
  }
}

Install-Winget "Git.Git"
Install-Winget "Neovim.Neovim"

if (-not (Get-Command scoop -ErrorAction SilentlyContinue)) {
  Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
  Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
}

try { scoop install fzf ripgrep } catch { }
