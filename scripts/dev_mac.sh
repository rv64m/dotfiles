#!/bin/bash
# Import the separator function
source "$(dirname "$0")/../lib/sep.sh"

# Use the separator to indicate the start of the script


#===============================================================#
# Install node
#===============================================================#
print_separator "Installing Node Dev"

# Install node
if ! command -v nvm &> /dev/null
    brew install nvm
    export NVM_DIR="$HOME/.nvm"
    [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
    [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
fi


# Define an array of Node.js versions to install
node_versions=("16.20.2" "18.20.4" "20.16.0")

# Loop through the array and install each version if not already installed
for version in "${node_versions[@]}"; do
    if ! nvm list | grep -q "v$version"; then
        nvm install "v$version"
    else
        echo "Node.js v$version is already installed. Skipping..."
    fi
done

if [ ! -f ~/.nvmrc ]; then
    echo "18.20.4" > ~/.nvmrc
else
    echo ".nvmrc file already exists. Skipping creation..."
fi

npm install -g yarn

#===============================================================#
# Install Web3
#===============================================================#
print_separator "Installing Web3 Dev"

if ! which remixd >/dev/null 2>&1; then
    npm install -g @remix-project/remixd # remixd
fi

if ! which foundryup >/dev/null 2>&1; then
    brew install libusb
    curl -L https://foundry.paradigm.xyz | bash
    export PATH="$PATH:$HOME/.foundry/bin"
    foundryup
fi



# Install node
if ! command -v nvm &> /dev/null
then
    brew install nvm
    export NVM_DIR="$HOME/.nvm"
        [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
        [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
fi


# Define an array of Node.js versions to install
node_versions=("16.20.2" "18.20.4" "20.16.0")

# Loop through the array and install each version if not already installed
for version in "${node_versions[@]}"; do
    if ! nvm list | grep -q "v$version"; then
        nvm install "v$version"
    else
        echo "Node.js v$version is already installed. Skipping..."
    fi
done

if [ ! -f ~/.nvmrc ]; then
    echo "18.20.4" > ~/.nvmrc
else
    echo ".nvmrc file already exists. Skipping creation..."
fi

npm install -g yarn

#===============================================================#
# Install Rust
#===============================================================#
print_separator "Installing Rust"
if ! which rustup >/dev/null 2>&1; then
	curl https://sh.rustup.rs -sSf | sh -s -- -y
    export PATH=$HOME/.cargo/bin:$PATH
	rustup default stable
    rustup target add wasm32-unknown-unknown
    rustup component add rust-src
else
	rustup update
	rustup default stable
fi

#===============================================================#
# Install Neovim
#===============================================================#
print_separator "Install and setup Neovim"

bash "$(dirname "$0")/nvim.sh"

brew install --cask neovide