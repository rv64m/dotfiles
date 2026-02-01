# PowerShell profile managed by Dotbot

$proxyConfig = Join-Path $HOME "Documents\PowerShell\proxy.config.ps1"
if (Test-Path $proxyConfig) {
  . $proxyConfig
}

$proxyScript = Join-Path $HOME "Documents\PowerShell\proxy.ps1"
if (Test-Path $proxyScript) {
  . $proxyScript
}

# Basic UX
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -EditMode Windows
