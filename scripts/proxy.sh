#!/bin/zsh

# Proxy-Switcher v1.0
#
# A simple Zsh script to easily switch between proxy configurations.

# --- Configuration ---
# Define your proxy settings here
V2RAY_HTTP_PORT="20171"
V2RAY_SOCKS_PORT="20170"
CLASH_MIXED_PORT="7897"
PROXY_HOST="127.0.0.1"

# --- Colors and Emojis ---
C_RESET='\033[0m'
C_RED='\033[0;31m'
C_GREEN='\033[0;32m'
C_YELLOW='\033[0;33m'
C_CYAN='\033[0;36m'

E_ROCKET="🚀"
E_PLUG="🔌"
E_SLEEP="💤"
E_INFO="ℹ️"
E_WARN="⚠️"

# --- Core Functions ---

# Function to set proxy environment variables
_set_proxy() {
    export http_proxy="$1"
    export https_proxy="$1"
    # SOCKS5 proxy is passed as the second argument, if available
    if [ -n "$2" ]; then
        export all_proxy="$2"
    else
        # Fallback to use http proxy for all_proxy if socks is not specified
        export all_proxy="$1"
    fi

    # Set uppercase versions for maximum compatibility
    export HTTP_PROXY="${http_proxy}"
    export HTTPS_PROXY="${https_proxy}"
    export ALL_PROXY="${all_proxy}"
}

# Function to unset all proxy environment variables
_unset_proxy() {
    unset http_proxy https_proxy all_proxy HTTP_PROXY HTTPS_PROXY ALL_PROXY
}

# Main 'proxy' command function
proxy() {
    case "$1" in
        v2ray)
            local http_addr="http://${PROXY_HOST}:${V2RAY_HTTP_PORT}"
            local socks_addr="socks5://${PROXY_HOST}:${V2RAY_SOCKS_PORT}"
            _set_proxy "$http_addr" "$socks_addr"
            echo -e "${C_GREEN}${E_ROCKET} Proxy enabled! ${C_CYAN}Now using [v2ray] configuration.${C_RESET}"
            proxy status
            ;;
        clash)
            local http_addr="http://${PROXY_HOST}:${CLASH_MIXED_PORT}"
            local socks_addr="socks5://${PROXY_HOST}:${CLASH_MIXED_PORT}" # Clash mixed port supports socks5
            _set_proxy "$http_addr" "$socks_addr"
            echo -e "${C_GREEN}${E_ROCKET} Proxy enabled! ${C_CYAN}Now using [Clash] configuration.${C_RESET}"
            proxy status
            ;;
        status)
            echo -e "\n${C_YELLOW}---------- Proxy Status ----------${C_RESET}"
            if [ -n "$http_proxy" ]; then
                echo -e "${E_PLUG} ${C_GREEN}Proxy is ON${C_RESET}"
                echo -e "  ${C_CYAN}HTTP Proxy:  ${C_RESET}${http_proxy}"
                echo -e "  ${C_CYAN}SOCKS Proxy: ${C_RESET}${all_proxy}"
            else
                echo -e "${E_SLEEP} ${C_RED}Proxy is OFF${C_RESET}"
            fi
            echo -e "${C_YELLOW}----------------------------------${C_RESET}\n"
            ;;
        *)
            echo -e "${E_WARN} ${C_YELLOW}Usage:${C_RESET}"
            echo -e "  ${C_CYAN}proxy [v2ray|clash]${C_RESET}  - To enable a specific proxy"
            echo -e "  ${C_CYAN}proxy status${C_RESET}           - To check the current proxy status"
            echo -e "  ${C_CYAN}unproxy${C_RESET}                - To disable any active proxy"
            ;;
    esac
}

# Main 'unproxy' command function
unproxy() {
    # The user's original request was `unproxy v2ray`, but a single `unproxy`
    # is more intuitive and robust. It turns off any active proxy.
    _unset_proxy
    echo -e "${E_SLEEP} ${C_YELLOW}All proxies have been disabled.${C_RESET}"
}
