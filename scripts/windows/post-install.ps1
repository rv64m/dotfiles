$ErrorActionPreference = "Continue"

$zsh = Get-Command zsh -ErrorAction SilentlyContinue
if ($zsh) {
  zsh
} else {
  Write-Host "zsh not found. If you use PowerShell, reopen the terminal or run: exec zsh (in zsh)."
}
