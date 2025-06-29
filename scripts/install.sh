#!/bin/bash

# =================================================================
# Dotfiles One-Click Installation and Configuration Script
#
# Usage:
#   ./install.sh [module]
#
# Module List:
#   dev   - Install basic development environment (Rust, Go, Node.js, etc.)
#   zsh   - Install Zsh and Oh My Zsh, and set as default shell
#   nvim  - Compile and install Neovim from source, and configure it
#   all   - Install all of the above modules (default behavior)
#
# Examples:
#   ./install.sh dev        # Install only the development environment
#   ./install.sh zsh nvim   # Install Zsh and Neovim
#   ./install.sh all        # Install all
#   ./install.sh            # Equivalent to ./install.sh all
# =================================================================

# Exit immediately if any command fails
set -e

# --- Load common function library ---
# Get the absolute path of the script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
UTILS_PATH="$SCRIPT_DIR/../lib/utils.sh"

if [ ! -f "$UTILS_PATH" ]; then
    echo "[ERROR] Common function library 'utils.sh' not found!"
    exit 1
fi
# shellcheck source=../lib/utils.sh
source "$UTILS_PATH"

# --- Script path definitions ---
DEV_SCRIPT="$SCRIPT_DIR/dev_linux.sh"
ZSH_SCRIPT="$SCRIPT_DIR/zsh.sh"
NVIM_SCRIPT="$SCRIPT_DIR/nvim.sh"


# --- Core functions ---

# Show help message
show_help() {
    log_info "Usage: $0 [dev|zsh|nvim|all]"
    log_info "  dev:  Install development environment"
    log_info "  zsh:  Install Zsh and Oh My Zsh"
    log_info "  nvim: Install Neovim"
    log_info "  all:  Install all modules (default)"
    exit 0
}

# Execute the specified installation script
run_script() {
    local script_path="$1"
    local script_name
    script_name=$(basename "$script_path")

    if [ -f "$script_path" ]; then
        log_step "${EMOJI_ROCKET} Starting to execute script: ${script_name}"
        # Grant execution permission and run
        chmod +x "$script_path"
        if bash "$script_path"; then
            log_success "${EMOJI_CHECK} Script ${script_name} executed successfully."
        else
            log_error "${EMOJI_ERROR} Script ${script_name} failed to execute."
            # Decide whether to exit the main script here if needed
            # exit 1 
        fi
    else
        log_warn "${EMOJI_WARN} Script ${script_name} not found, skipping."
    fi
}


# --- Main function ---
main() {
    log_info "${EMOJI_ROCKET} Dotfiles installer started..."

    # If no arguments are provided, default to 'all'
    if [ $# -eq 0 ]; then
        set -- "all"
    fi

    local install_dev=false
    local install_zsh=false
    local install_nvim=false

    # Parse user input
    for arg in "$@"; do
        case "$arg" in
            dev)  install_dev=true ;;
            zsh)  install_zsh=true ;;
            nvim) install_nvim=true ;;
            all)
                install_dev=true
                install_zsh=true
                install_nvim=true
                ;;
            -h|--help) show_help ;;
            *)
                log_error "Invalid module: $arg"
                show_help
                ;;
        esac
    done

    # Execute the corresponding scripts based on the flags
    if [ "$install_dev" = true ]; then
        run_script "$DEV_SCRIPT"
    fi

    if [ "$install_zsh" = true ]; then
        run_script "$ZSH_SCRIPT"
    fi

    if [ "$install_nvim" = true ]; then
        run_script "$NVIM_SCRIPT"
    fi

    log_info "
${EMOJI_PARTY}${EMOJI_PARTY}${EMOJI_PARTY} All selected installation tasks are complete! ${EMOJI_PARTY}${EMOJI_PARTY}${EMOJI_PARTY}"
    log_warn "${EMOJI_POINT} Please remember to restart your terminal or log in again for all changes to take full effect."
}

# --- Script execution entry point ---
main "$@"