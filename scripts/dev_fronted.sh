#! /bin/bash

source "$(dirname "$0")/../lib/sep.sh"

#===============================================================#
# Install fronted development tools
#===============================================================#
print_separator "Installing fronted development tools"

nvm_default_install_dir() {
  [ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm"
}

nvm_install_dir() {
  if [ -n "$NVM_DIR" ]; then
    printf %s "${NVM_DIR}"
  else
    nvm_default_install_dir
  fi
}

INSTALL_DIR="$(nvm_install_dir)"

# Install nvm
if [ ! -d "$INSTALL_DIR" ]; then
    echo "Installing nvm..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash

   export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

    cat << 'EOF' >> ~/.zshrc
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
EOF
    nvm install v18.20.4
    echo "18.20.4" > ~/.nvmrc
    nvm use 18.20.4
else
    echo "nvm already installed"
fi

# Install yarn
if ! which yarn >/dev/null 2>&1; then
    npm install -g yarn
else 
    echo "yarn already installed"
fi

#===============================================================#
# Install Web3 development tools    
#===============================================================#
print_separator "Installing Web3 development tools"

# Install solidity language server
if ! which nomicfoundation-solidity-language-server >/dev/null 2>&1; then
    npm install @nomicfoundation/solidity-language-server -g
else
    echo "solidity-language-server already installed"
fi

# Install remixd
if ! which remixd >/dev/null 2>&1; then
    npm install -g @remix-project/remixd # remixd
else
    echo "remixd already installed"
fi

# Install foundry
if ! which foundryup >/dev/null 2>&1; then
    curl -L https://foundry.paradigm.xyz | bash
else
    echo "foundryup already installed"
fi

#===============================================================#
# Install Rust development tools    
#===============================================================#
print_separator "Installing Rust development tools"

# Install rust
if ! which rustup >/dev/null 2>&1; then
    echo "Installing rustup..."
    curl https://sh.rustup.rs -sSf | sh -s -- -y
    . $HOME/.cargo/env
    echo ". $HOME/.cargo/env" >> ~/.zshrc
	rustup default stable
    rustup target add wasm32-unknown-unknown
    rustup component add rust-src
else
    echo "rustup is already installed. Skipping..."
fi