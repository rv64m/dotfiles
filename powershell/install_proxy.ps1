<#
.SYNOPSIS
    Installs the proxy-switcher script for persistent use in PowerShell.

.DESCRIPTION
    This script automates the installation of 'proxy.ps1'. It performs two main actions:
    1. Copies 'proxy.ps1' to a permanent directory within the user's home folder (%USERPROFILE%\.dotfiles\scripts).
    2. Updates the user's PowerShell profile to automatically load the script on startup, making the 'proxy' and 'unproxy' commands always available.

.USAGE
    Run this script once from the 'powershell' directory to complete the installation:
    .\install_proxy.ps1
#>

# --- Configuration ---
# The source script that needs to be installed. Assumes it's in the same directory as this installer.
$SourceScript = "proxy.ps1"

# The destination directory. We create a '.dotfiles/scripts' folder in the user's home directory for organization.
$DestinationDir = Join-Path $env:USERPROFILE ".dotfiles\scripts"

# The full path for the script at its destination.
$DestinationScriptPath = Join-Path $DestinationDir $SourceScript

# The full path to the current user's PowerShell profile script.
$ProfilePath = $PROFILE

# --- Start of Installation ---

Write-Host -ForegroundColor Cyan "🚀 Starting proxy script installation..."

# --- Step 1: Verify and Copy the Script ---

$SourceScriptPath = Join-Path $PSScriptRoot $SourceScript
if (-not (Test-Path -Path $SourceScriptPath)) {
    Write-Host -ForegroundColor Red "❌ ERROR: Source script '$SourceScript' not found in the current directory."
    return
}

# Create the destination directory if it doesn't exist
if (-not (Test-Path -Path $DestinationDir)) {
    Write-Host "- Creating destination directory at '$DestinationDir'..."
    New-Item -Path $DestinationDir -ItemType Directory -Force | Out-Null
}

# Copy the script to the destination
Write-Host "- Copying '$SourceScript' to '$DestinationScriptPath'..."
Copy-Item -Path $SourceScriptPath -Destination $DestinationScriptPath -Force
Write-Host -ForegroundColor Green "✅ Script copied successfully."


# --- Step 2: Update PowerShell Profile ---

# The line that needs to be added to the profile to load the script.
# Using single quotes around the path handles spaces correctly.
$LineToAdd = ". '$DestinationScriptPath'"

# Ensure the profile file exists before trying to read it.
if (-not (Test-Path -Path $ProfilePath)) {
    Write-Host "- PowerShell profile not found. Creating one at '$ProfilePath'..."
    New-Item -Path $ProfilePath -ItemType File -Force | Out-Null
}

# Check if the profile already contains the line to avoid duplicates.
# [regex]::Escape ensures that we search for the literal string.
if (Select-String -Path $ProfilePath -Pattern ([regex]::Escape($LineToAdd)) -Quiet) {
    Write-Host -ForegroundColor Yellow "ℹ️  PowerShell profile is already configured. No changes needed."
} else {
    Write-Host "- Adding proxy script to PowerShell profile..."
    Add-Content -Path $ProfilePath -Value $LineToAdd
    Write-Host -ForegroundColor Green "✅ PowerShell profile updated successfully."
}

# --- Completion ---

Write-Host -ForegroundColor Cyan "`n🎉 Installation complete!" 
Write-Host "Please restart your PowerShell session or run the command below to start using the 'proxy' and 'unproxy' functions:"
Write-Host -ForegroundColor White "   . `$PROFILE"
