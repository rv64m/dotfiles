#!/bin/bash

# =========================
# Install neovim from github
# =========================
if ! which nvim >/dev/null 2>&1; then
    echo "Installing neovim..."
    sudo apt install -y ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip
    git clone https://github.com/neovim/neovim.git
    cd neovim
    git checkout stable
    make CMAKE_BUILD_TYPE=RelWithDebInfo
    sudo make install
    cd ..
    rm -rf neovim
    
fi

# =========================
# Install astronvim
# =========================
if ! [ -d ~/.config/nvim ]; then
    echo "Installing astronvim..."
    mv ~/.local/share/nvim ~/.local/share/nvim.bak
    mv ~/.local/state/nvim ~/.local/state/nvim.bak
    mv ~/.cache/nvim ~/.cache/nvim.bak
    git clone --depth 1 https://github.com/AstroNvim/template ~/.config/nvim
    rm -rf ~/.config/nvim/.git
fi

# =========================
# Install neovim plugins
# =========================
if ! [ -d ~/.config/nvim/myself ]; then
    echo "Installing neovim plugins..."
    cp -r astronvim ~/.config/nvim/myself
fi