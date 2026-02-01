$ErrorActionPreference = "Stop"

$BaseDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$DotbotDir = Join-Path $BaseDir "vendor\dotbot"

function Ensure-Command($name) {
  return [bool](Get-Command $name -ErrorAction SilentlyContinue)
}

if (-not (Ensure-Command git)) {
  Write-Host "Installing Git via winget..."
  winget install -e --id Git.Git
}

if (-not (Test-Path $DotbotDir)) {
  git clone https://github.com/anishathalye/dotbot.git $DotbotDir
  Push-Location $DotbotDir
  git submodule update --init --recursive
  Pop-Location
}

if (-not (Ensure-Command python) -and -not (Ensure-Command py)) {
  Write-Host "Installing Python via winget..."
  winget install -e --id Python.Python.3.12
}

$pythonCmd = "python"
if (-not (Ensure-Command python)) { $pythonCmd = "py" }

$common = Join-Path $BaseDir "install.conf.common.yaml"
$win = Join-Path $BaseDir "install.conf.windows.yaml"

$dotbotArgs = @()
$env:DOTFILES_VERBOSE = "0"
$env:DOTFILES_QUIET = "0"
foreach ($arg in $args) {
  switch ($arg) {
    "-v" { $dotbotArgs += "-v"; $env:DOTFILES_VERBOSE = "1" }
    "--verbose" { $dotbotArgs += "-v"; $env:DOTFILES_VERBOSE = "1" }
    "-q" { $dotbotArgs += "-q"; $env:DOTFILES_QUIET = "1" }
    "--quiet" { $dotbotArgs += "-q"; $env:DOTFILES_QUIET = "1" }
    default { $dotbotArgs += $arg }
  }
}

& $pythonCmd (Join-Path $DotbotDir "bin\dotbot") -d $BaseDir -c $common -c $win @dotbotArgs
