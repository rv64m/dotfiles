#!/bin/bash

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


# --- Configuration variables ---
NVIM_CONFIG_DIR="$HOME/.config/nvim"
NVIM_SHARE_DIR="$HOME/.local/share/nvim"
NVIM_STATE_DIR="$HOME/.local/state/nvim"
NVIM_CACHE_DIR="$HOME/.cache/nvim"
SOURCE_CONFIG_DIR="$SCRIPT_DIR/../nvim"


# --- Function definitions ---

# Clean up old Neovim directories
cleanup_old_config() {
    log_step "Cleaning up old Neovim configuration and data"
    rm -rf "$NVIM_CONFIG_DIR"
    rm -rf "$NVIM_SHARE_DIR"
    rm -rf "$NVIM_STATE_DIR"
    rm -rf "$NVIM_CACHE_DIR"
    log_success "Old directories cleaned up."
}

# Install Neovim by compiling from source
install_neovim() {
    if command -v nvim &>/dev/null; then
        log_info "Neovim is already installed, skipping installation."
        return
    fi

    log_step "Compiling and installing Neovim from source"
    
    log_info "Installing dependencies required for compilation..."
sudo apt-get update
sudo apt-get install -y ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl
    log_success "Dependencies installed."

    log_info "Cloning Neovim repository from GitHub..."
    git clone https://github.com/neovim/neovim.git /tmp/neovim
    
    cd /tmp/neovim
    
    log_info "Switching to 'stable' branch and starting compilation..."
    git checkout stable
    make CMAKE_BUILD_TYPE=RelWithDebInfo
    log_success "Compilation complete."
    
    log_info "Installing Neovim to the system..."
    sudo make install
    
    log_info "Cleaning up compiled source code..."
    cd -
    rm -rf /tmp/neovim
    
    if command -v nvim &>/dev/null; then
        log_success "Neovim compiled and installed successfully!"
    else
        log_error "Neovim installation failed, please check the error messages during compilation."
        exit 1
    fi
}

# Copy new configuration from the parent directory
setup_new_config() {
    log_step "Configuring Neovim"
    
    if [ ! -d "$SOURCE_CONFIG_DIR" ]; then
        log_warn "Warning: Source configuration folder '$SOURCE_CONFIG_DIR' not found."
        log_info "A Neovim with no configuration will be launched. Please configure it manually later."
        return
    }

    log_info "Source configuration found: $SOURCE_CONFIG_DIR"
    log_info "Copying configuration to: $NVIM_CONFIG_DIR"
    
    mkdir -p "$(dirname "$NVIM_CONFIG_DIR")"
    cp -r "$SOURCE_CONFIG_DIR" "$NVIM_CONFIG_DIR"
    
    log_success "Neovim configuration copied successfully!"
}


# --- Main function ---
main() {
    log_info "${EMOJI_ROCKET} Starting Neovim environment configuration script..."
    
    cleanup_old_config
    install_neovim
    setup_new_config
    
    log_info "\n${EMOJI_PARTY} Neovim environment configuration complete!"
}

# --- Execute script ---
main