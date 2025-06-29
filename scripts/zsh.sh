!/bin/bash

# =================================================================
# Zsh & Oh My Zsh Automated Installation Script (v3)
#
# Features:
# 1. Automatically detect and install Zsh and Git.
# 2. Install Oh My Zsh.
# 3. Set Zsh as the default Shell.
# 4. Set the Oh My Zsh theme to 'cloud'.
# 5. Install common plugins (zsh-z, zsh-autosuggestions, zsh-syntax-highlighting).
# 6. Automatically configure .zshrc to enable plugins.
# 7. Compatible with Linux (Debian/Ubuntu/CentOS/Fedora/Arch) and macOS.
# =================================================================

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


# --- Core functions ---

# 1. Check and install packages
install_packages() {
    local pkg_manager=""
    local packages=("$@")

    # Detect package manager
    if command -v apt-get &>/dev/null; then
        pkg_manager="apt-get"
    elif command -v dnf &>/dev/null; then
        pkg_manager="dnf"
    elif command -v yum &>/dev/null; then
        pkg_manager="yum"
    elif command -v pacman &>/dev/null; then
        pkg_manager="pacman"
    elif command -v brew &>/dev/null; then
        pkg_manager="brew"
    else
        log_error "Unsupported package manager detected (apt, dnf, yum, pacman, brew). Please install Zsh and Git manually first."
        exit 1
    fi

    log_info "Using package manager: $pkg_manager"

    for pkg in "${packages[@]}"; do
        if command -v "$pkg" &>/dev/null; then
            log_success "$pkg is already installed."
        else
            log_info "Installing $pkg..."
            case "$pkg_manager" in
                "apt-get")
                    sudo apt-get install -y "$pkg"
                    ;;
                "dnf" | "yum")
                    sudo "$pkg_manager" install -y "$pkg"
                    ;;
                "pacman")
                    sudo pacman -S --noconfirm "$pkg"
                    ;;
                "brew")
                    brew install "$pkg"
                    ;;
            esac

            if [ $? -ne 0 ]; then
                log_error "$pkg installation failed. Please check your package manager settings."
                exit 1
            fi
            log_success "$pkg installed successfully."
        fi
    done
}

# 2. Install Oh My Zsh
install_oh_my_zsh() {
    if [ -d "$HOME/.oh-my-zsh" ]; then
        log_success "Oh My Zsh is already installed in $HOME/.oh-my-zsh"
    else
        log_step "Installing Oh My Zsh"
        # Use the --unattended flag for non-interactive installation
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
        if [ $? -eq 0 ]; then
            log_success "Oh My Zsh installed successfully."
        else
            log_error "Oh My Zsh installation failed."
            exit 1
        fi
    fi
}

# 3. Install plugins
install_plugins() {
    local custom_plugins_dir="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins"

    declare -A plugins
    plugins=(
        ["zsh-z"]="https://github.com/agkozak/zsh-z.git"
        ["zsh-autosuggestions"]="https://github.com/zsh-users/zsh-autosuggestions.git"
        ["zsh-syntax-highlighting"]="https://github.com/zsh-users/zsh-syntax-highlighting.git"
    )

    log_step "Installing Zsh plugins"
    mkdir -p "$custom_plugins_dir"

    for plugin_name in "${!plugins[@]}"; do
        local plugin_dir="$custom_plugins_dir/$plugin_name"
        if [ -d "$plugin_dir" ]; then
            log_success "Plugin '$plugin_name' already exists."
        else
            log_info "Installing plugin '$plugin_name'..."
            git clone "${plugins[$plugin_name]}" "$plugin_dir"
            if [ $? -eq 0 ]; then
                log_success "Plugin '$plugin_name' installed successfully."
            else
                log_error "Plugin '$plugin_name' installation failed."
            fi
        fi
    done
}

# 4. Configure .zshrc
configure_zshrc() {
    local zshrc_file="$HOME/.zshrc"
    local theme_name="cloud"
    local plugins_line="plugins=(git zsh-z zsh-autosuggestions zsh-syntax-highlighting)"

    log_step "Configuring .zshrc"
    
    if [ ! -f "${zshrc_file}.bak" ]; then
        cp "$zshrc_file" "${zshrc_file}.bak"
        log_info "Original .zshrc has been backed up to .zshrc.bak"
    fi

    log_info "Setting theme to '$theme_name'..."
    sed -i.tmp "s/^ZSH_THEME=\".*\"/ZSH_THEME=\"${theme_name}\"/" "$zshrc_file"
    log_success "Theme has been set to '$theme_name'."

    if ! grep -q "^plugins=(.*)" "$zshrc_file"; then
        log_warn "'plugins=(...)' line not found in $zshrc_file. Adding default configuration."
        echo "$plugins_line" >> "$zshrc_file"
    else
        log_info "Updating plugin list..."
        sed -i.tmp "s/^plugins=(.*)/${plugins_line}/" "$zshrc_file"
        log_success "Plugin list has been updated."
    fi
    
    rm -f "${zshrc_file}.tmp"
}

# 5. Change default shell
change_default_shell() {
    local zsh_path
    zsh_path=$(which zsh)

    if [ -z "$zsh_path" ]; then
        log_error "Could not find Zsh installation path."
        return 1
    fi

    if [ "$SHELL" = "$zsh_path" ]; then
        log_success "Default shell is already Zsh."
    else
        log_step "Changing default shell to Zsh"
        chsh -s "$zsh_path"
        if [ $? -eq 0 ]; then
            log_success "Default shell has been successfully changed to Zsh."
            log_warn "You need to log out and log back in or restart your system for the changes to take full effect."
        else
            log_error "Failed to change default shell."
            log_info "Please try running 'chsh -s $(which zsh)' manually."
        fi
    fi
}

# --- Main function ---
main() {
    log_info "${EMOJI_ROCKET} Zsh environment automated deployment starts..."

    install_packages "zsh" "git"
    install_oh_my_zsh
    install_plugins
    configure_zshrc
    change_default_shell

    log_info "\n${EMOJI_PARTY} Zsh configuration complete!"
    log_warn "${EMOJI_POINT} Please restart your terminal to load the new Zsh environment!"
}

# Execute main function
main