#!/bin/bash

if ! which nvim >/dev/null 2>&1; then
    echo "Installing neovim..."
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        sudo apt install -y ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        brew install ninja gettext libtool automake cmake pkg-config unzip
    else
        echo "Unsupported operating system"
        exit 1
    fi
    git clone https://github.com/neovim/neovim.git
    cd neovim
    git checkout stable
    make CMAKE_BUILD_TYPE=RelWithDebInfo
    sudo make install
    cd ..
    rm -rf neovim
    
fi

if ! [ -d ~/.config/nvim ]; then
    echo "Installing neovim ide..."
    rm -rf ~/.config/nvim
    rm -rf ~/.local/share/nvim
    rm -rf ~/.local/state/nvim
    rm -rf  ~/.cache/nvim
    cp -r nvim ~/.config/nvim
fi