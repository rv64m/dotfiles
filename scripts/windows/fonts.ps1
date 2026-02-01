$ErrorActionPreference = "Stop"

if ($env:DOTFILES_QUIET -eq "1") {
  $ProgressPreference = "SilentlyContinue"
}

$BaseDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$RepoRoot = Split-Path -Parent $BaseDir
$Source = Join-Path $RepoRoot "fronts"
$Dest = Join-Path $env:LOCALAPPDATA "Microsoft\Windows\Fonts"

New-Item -ItemType Directory -Force -Path $Dest | Out-Null

$ttfs = Get-ChildItem -Path $Source -Recurse -Filter "*.ttf"
foreach ($ttf in $ttfs) {
  $target = Join-Path $Dest $ttf.Name
  Copy-Item $ttf.FullName $target -Force

  $regPath = "HKCU:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts"
  $fontName = $ttf.BaseName
  try {
    New-ItemProperty -Path $regPath -Name $fontName -Value $ttf.Name -PropertyType String -Force | Out-Null
  } catch {
  }
}
