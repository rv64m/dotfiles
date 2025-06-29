<#
.SYNOPSIS
    A PowerShell script to easily switch between proxy configurations.

.DESCRIPTION
    This script provides simple functions (`proxy`, `unproxy`) to set and unset proxy environment variables for the current PowerShell session.
    It is designed to be the PowerShell equivalent of the provided zsh proxy script.

.USAGE
    To make the functions available in your shell, you need to "dot source" the script:
    . .\proxy.ps1

    To make them available automatically in every new shell, add the above line to your PowerShell profile:
    Add-Content -Path $PROFILE -Value ". '$PSCommandPath'"

.EXAMPLES
    # Enable the 'v2ray' proxy configuration
    proxy v2ray

    # Enable the 'clash' proxy configuration
    proxy clash

    # Disable the currently active proxy
    unproxy

    # Check the current proxy status
    proxy status
#>

# --- Configuration ---
# Define your proxy settings here
$V2RAY_HTTP_PORT = "20171"
$V2RAY_SOCKS_PORT = "20170"
$CLASH_MIXED_PORT = "7897"
$PROXY_HOST = "127.0.0.1"

# --- Emojis (for modern terminals) ---
$EMOJI_ROCKET = "🚀"
$EMOJI_PLUG = "🔌"
$EMOJI_SLEEP = "💤"
$EMOJI_WARN = "⚠️"

# --- Core Functions ---

function proxy {
    param (
        [Parameter(Mandatory=$true)]
        [ValidateSet('v2ray', 'clash', 'status')]
        [string]$Mode
    )

    # Helper to set environment variables for the current session
    function _Set-ProxyVariables($httpUrl, $socksUrl) {
        $env:http_proxy = $httpUrl
        $env:https_proxy = $httpUrl
        $env:all_proxy = $socksUrl
        # Set uppercase versions for maximum compatibility
        $env:HTTP_PROXY = $httpUrl
        $env:HTTPS_PROXY = $httpUrl
        $env:ALL_PROXY = $socksUrl
    }

    switch ($Mode) {
        'v2ray' {
            $httpAddress = "http://${PROXY_HOST}:${V2RAY_HTTP_PORT}"
            $socksAddress = "socks5://${PROXY_HOST}:${V2RAY_SOCKS_PORT}"
            _Set-ProxyVariables $httpAddress $socksAddress
            Write-Host -ForegroundColor Green "$EMOJI_ROCKET Proxy enabled!" -NoNewline
            Write-Host -ForegroundColor Cyan " Now using [v2ray] configuration." 
            proxy status
            break
        }
        'clash' {
            $httpAddress = "http://${PROXY_HOST}:${CLASH_MIXED_PORT}"
            $socksAddress = "socks5://${PROXY_HOST}:${CLASH_MIXED_PORT}" # Clash mixed port supports SOCKS5
            _Set-ProxyVariables $httpAddress $socksAddress
            Write-Host -ForegroundColor Green "$EMOJI_ROCKET Proxy enabled!" -NoNewline
            Write-Host -ForegroundColor Cyan " Now using [Clash] configuration." 
            proxy status
            break
        }
        'status' {
            Write-Host -ForegroundColor Yellow "\n---------- Proxy Status ----------"
            if (-not [string]::IsNullOrEmpty($env:http_proxy)) {
                Write-Host -ForegroundColor Green "$EMOJI_PLUG Proxy is ON"
                Write-Host -ForegroundColor Cyan "  HTTP Proxy:  " -NoNewline
                Write-Host $env:http_proxy
                Write-Host -ForegroundColor Cyan "  SOCKS Proxy: " -NoNewline
                Write-Host $env:all_proxy
            } else {
                Write-Host -ForegroundColor Red "$EMOJI_SLEEP Proxy is OFF"
            }
            Write-Host -ForegroundColor Yellow "----------------------------------\n"
            break
        }
        default {
            # This case is technically not reachable due to ValidateSet, but good practice.
            Write-Host -ForegroundColor Yellow "$EMOJI_WARN Usage:"
            Write-Host -ForegroundColor Cyan "  proxy [v2ray|clash]" -NoNewline; Write-Host " - To enable a specific proxy"
            Write-Host -ForegroundColor Cyan "  proxy status         " -NoNewline; Write-Host " - To check the current proxy status"
            Write-Host -ForegroundColor Cyan "  unproxy              " -NoNewline; Write-Host " - To disable any active proxy"
        }
    }
}

function unproxy {
    # Remove all proxy-related environment variables
    $proxyVars = @('http_proxy', 'https_proxy', 'all_proxy', 'HTTP_PROXY', 'HTTPS_PROXY', 'ALL_PROXY')
    foreach ($var in $proxyVars) {
        if (Test-Path "env:$var") {
            Remove-Item "env:$var"
        }
    }
    Write-Host -ForegroundColor Yellow "$EMOJI_SLEEP All proxies have been disabled."
}

# --- Export functions as aliases for convenience ---
# This makes them feel like standalone commands.
Set-Alias -Name unproxy -Value unproxy -Option AllScope -Description "Disables the proxy."
Set-Alias -Name proxy -Value proxy -Option AllScope -Description "Sets or checks the proxy."

Write-Host -ForegroundColor Cyan "Proxy functions loaded. Use 'proxy [v2ray|clash|status]' and 'unproxy'."