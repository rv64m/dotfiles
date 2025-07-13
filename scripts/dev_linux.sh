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


# --- Global settings ---
# Automatically detect the user's default Shell and determine the corresponding configuration file
SHELL_RC_FILE=""
detect_shell_config() {
    if [[ "$SHELL" == */zsh ]]; then
        SHELL_RC_FILE="$HOME/.zshrc"
        touch "$SHELL_RC_FILE"
        log_info "${EMOJI_CHECK} Zsh Shell detected, will automatically configure ~/.zshrc file."
    elif [[ "$SHELL" == */bash ]]; then
        SHELL_RC_FILE="$HOME/.bashrc"
        touch "$SHELL_RC_FILE"
        log_info "${EMOJI_CHECK} Bash Shell detected, will automatically configure ~/.bashrc file."
    else
        SHELL_RC_FILE="$HOME/.profile"
        touch "$SHELL_RC_FILE"
        log_warn "Zsh or Bash not detected, will write configuration to the generic ~/.profile file."
    fi
}


# --- Function definitions ---

# 1. Install basic development tools
install_base_tools() {
    log_step "Installing basic development tools"
    sudo apt-get update
    sudo apt-get install -y build-essential gcc g++ clang llvm cmake make pkg-config curl wget git unzip
    log_success "Basic development tools installed."
}

# 2. Install Rust
install_rust() {
    if command -v rustc &>/dev/null; then
        log_info "Rust is already installed, skipping this step."
        return
    fi
    log_step "Installing Rust"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    log_success "Rust installed successfully!"
}



# 4. Install the latest version of Go
install_golang() {
    if command -v go &>/dev/null; then
        log_info "Go is already installed ($(go version)), skipping this step."
        return
    fi
    log_step "Installing the latest version of Go"
    
    LATEST_GO_INFO=$(curl -s "https://go.dev/dl/?mode=json" | grep -E 'linux-amd64.tar.gz' | head -n 1)
    GO_FILENAME=$(echo "$LATEST_GO_INFO" | grep -oP '"filename":\s*"\K[^"]+')
    
    if [ -z "$GO_FILENAME" ]; then
        log_error "Could not get the latest Go version" && exit 1
    fi
    
    GO_URL="https://go.dev/dl/${GO_FILENAME}"
    log_info "Found latest Go version: ${GO_FILENAME}"
    
    wget -q --show-progress -O "/tmp/${GO_FILENAME}" "${GO_URL}"
    
    log_info "Installing Go to /usr/local/go..."
    [ -d "/usr/local/go" ] && sudo rm -rf /usr/local/go
    sudo tar -C /usr/local -xzf "/tmp/${GO_FILENAME}"
    rm "/tmp/${GO_FILENAME}"
    
    log_success "Go installed successfully!"
}

# 5. Unified configuration of Shell environment
setup_shell_environment() {
    log_step "Writing environment variables to $SHELL_RC_FILE"

    local marker="# <<< Env setup by dev_linux.sh >>>"
    if grep -qF -- "$marker" "$SHELL_RC_FILE"; then
        log_info "Environment variables already exist, no need to write them again."
        return
    fi # <-- CORRECTED: Replaced '}' with 'fi'

    cat <<'EOF' >> "$SHELL_RC_FILE"

# <<< Env setup by dev_linux.sh >>>
# =================================================================

# NVM (Node.js)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Rust (via rustup)
source "$HOME/.cargo/env"

# Go (Golang)
export GOPATH="$HOME/go"
export PATH="/usr/local/go/bin:$GOPATH/bin:$PATH"

# =================================================================
# >>> Env setup by dev_linux.sh >>>

EOF
    log_success "Environment variables have been successfully written to $SHELL_RC_FILE"
}


# --- Main function ---
main() {
    log_info "${EMOJI_ROCKET} Starting development environment configuration script..."
    
    detect_shell_config
    install_base_tools
    install_rust
    install_golang
    setup_shell_environment
    
    log_info "\n${EMOJI_PARTY} Development environment configuration complete!"
    log_warn "${EMOJI_POINT} Please restart your terminal or run 'source $SHELL_RC_FILE' for the changes to take effect."
}

# --- Execute script ---
main
