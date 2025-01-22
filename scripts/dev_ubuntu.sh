#!/bin/bash

#===============================================================#
# Install some dependencies
#===============================================================#
sudo apt install -y libssl-dev

#===============================================================#
# Install Rust
#===============================================================#
print_separator "Installing Rust Dev"

if ! which rustup >/dev/null 2>&1; then
    echo "Installing rustup..."
    curl https://sh.rustup.rs -sSf | sh -s -- -y
    . $HOME/.cargo/env
	rustup default stable
    rustup target add wasm32-unknown-unknown
    rustup component add rust-src
else
    echo "rustup is already installed. Skipping..."
fi


#===============================================================#
# Install node
#===============================================================#
print_separator "Installing Node Dev"

# Install node
if ! which nvm >/dev/null 2>&1; then
    echo "Installing nvm..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
else
    echo "nvm is already installed. Skipping..."
fi

# Loop through the array and install each version if not already installed
if ! nvm list | grep -q "v18.20.4"; then
    nvm install "v18.20.4"
else
    echo "Node.js v18.20.4 is already installed. Skipping..."
fi

if [ ! -f ~/.nvmrc ]; then
    echo "18.20.4" > ~/.nvmrc
else
    echo ".nvmrc file already exists. Skipping creation..."
fi

npm install -g yarn

#===============================================================#
# Install Golang
#===============================================================#
print_separator "Installing Golang Dev"

if ! which go >/dev/null 2>&1; then
    echo "Installing Golang..."
    GO_VERSION=1.23.4
    GO_TAR=go$GO_VERSION.linux-amd64.tar.gz
    GO_URL=https://golang.org/dl/$GO_TAR
    wget $GO_URL
    sudo tar -C /usr/local -xzf $GO_TAR
    export GOROOT=/usr/local/go
    export GOPATH=$HOME/go
    export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
else
    echo "Golang is already installed. Skipping..."
fi

