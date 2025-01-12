#!/bin/bash

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

echo "Remove nvim folders..."
rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
rm -rf  ~/.cache/nvim
