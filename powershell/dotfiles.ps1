<#
.SYNOPSIS
    A central control script for managing dotfiles operations in PowerShell.

.DESCRIPTION
    This script acts as a dispatcher for various dotfiles-related PowerShell scripts.
    It allows you to run specific operations (like 'install proxy') by calling this central script.
    It also provides a --help option to list available commands.

.USAGE
    To use this script as a global command, add its directory to your system's PATH environment variable.

    dotfiles.ps1 <command> [arguments]
    dotfiles.ps1 --help

.EXAMPLE
    dotfiles.ps1 install proxy
    dotfiles.ps1 proxy status
#>

# --- Configuration ---
# Define the directory where command scripts are located.
# Assumes command scripts are in the same directory as this controller script.
$CommandDir = $PSScriptRoot

# --- Helper Functions ---

function Show-Help {
    Write-Host -ForegroundColor Cyan "
🚀 Dotfiles Management Script"
    Write-Host -ForegroundColor Cyan "Usage: dotfiles.ps1 <command> [arguments]
"
    Write-Host -ForegroundColor Cyan "Available Commands:
"

    # Discover all .ps1 files in the command directory, excluding this script itself.
    Get-ChildItem -Path $CommandDir -Filter "*.ps1" | ForEach-Object {
        $scriptName = $_.BaseName
        # Try to read the .SYNOPSIS from the script for a brief description
        $synopsis = (Get-Content -Path $_.FullName | Select-String -Pattern '^.SYNOPSIS\s+(.*)' | ForEach-Object {$_.Matches.Groups[1].Value}) -join ' '
        
        # Exclude the controller script itself and the installer script from the main command list
        if ($scriptName -ne "dotfiles" -and $scriptName -ne "install_proxy") {
            Write-Host -ForegroundColor Green "  $scriptName" -NoNewline
            if (-not [string]::IsNullOrEmpty($synopsis)) {
                Write-Host -ForegroundColor DarkGray " - $synopsis"
            } else {
                Write-Host -ForegroundColor DarkGray " - No synopsis available."
            }
        }
    }
    
    Write-Host -ForegroundColor Green "  install proxy" -NoNewline
    Write-Host -ForegroundColor DarkGray " - Installs the proxy script for persistent use."

    Write-Host -ForegroundColor Cyan "
For more details on a specific command, refer to its script file."
}

# --- Main Logic ---

# Check for --help argument
if ($args.Length -eq 0 -or $args[0] -eq "--help" -or $args[0] -eq "-h") {
    Show-Help
    exit 0
}

# Get the command from the first argument
$command = $args[0]

# Handle special commands like 'install proxy'
if ($command -eq "install" -and $args.Length -gt 1 -and $args[1] -eq "proxy") {
    $scriptToExecute = Join-Path $CommandDir "install_proxy.ps1"
    # Pass remaining arguments (if any, though install_proxy doesn't expect them)
    $scriptArgs = $args | Select-Object -Skip 2
} else {
    # Construct the path to the command script
    $scriptToExecute = Join-Path $CommandDir "$command.ps1"
    # Pass all arguments except the command itself to the target script
    $scriptArgs = $args | Select-Object -Skip 1
}

# Check if the script exists
if (-not (Test-Path -Path $scriptToExecute)) {
    Write-Host -ForegroundColor Red "❌ Error: Command '$command' not found or corresponding script '$scriptToExecute' does not exist."
    Show-Help
    exit 1
}

# Execute the script
Write-Host -ForegroundColor Cyan "🚀 Executing '$scriptToExecute'..."

# Use dot-sourcing to run the script in the current scope, so its functions are available.
# This is important for scripts like proxy.ps1 which define functions.
# For installer scripts, it's also fine.
. $scriptToExecute @scriptArgs

Write-Host -ForegroundColor Green "✅ Command '$command' executed successfully."
