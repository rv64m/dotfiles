#!/bin/bash

#===============================================================#
# Install some dependencies
#===============================================================#
sudo apt install -y libssl-dev

#===============================================================#
# Install zsh
#===============================================================#
print_separator "Installing zsh"
if ! which zsh >/dev/null 2>&1; then
    echo "Installing zsh..."
    sudo apt install -y zsh
else
    echo "zsh is already installed. Skipping..."
fi

#===============================================================#
# Install oh-my-zsh
#===============================================================#
print_separator "Installing oh-my-zsh"

if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing oh-my-zsh..."
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    sed -i 's/^ZSH_THEME=.*/ZSH_THEME="cloud"/g' ~/.zshrc
    sed -i 's/^plugins=(.*)/plugins=(git $1)/g' ~/.zshrc

else
    echo "oh-my-zsh is already installed. Skipping..."
fi

# config oh-my-zsh
echo "Configuring oh-my-zsh..."
if grep -q "source ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" ~/.zshrc; then
    echo "zsh-autosuggestions is already installed. Skipping..."
else
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    echo "source ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshrc
fi

if grep -q "source ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ~/.zshrc; then
    echo "zsh-syntax-highlighting is already installed. Skipping..."
else
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    echo "source ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc
fi

if [ -d "$ZSH_CUSTOM/plugins/zsh-completions" ]; then
    echo "zsh-completions is already installed. Skipping..."
else
    git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions
    echo "source ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions/zsh-completions.plugin.zsh" >> ~/.zshrc
fi

if grep -q "source ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh" ~/.zshrc; then
    echo "zsh-history-substring-search is already installed. Skipping..."
else
    git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
    echo "source ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh" >> ~/.zshrc
fi

if grep -q "source ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/z/z.sh" ~/.zshrc; then
    echo "z is already installed. Skipping..."
else
    git clone https://github.com/rupa/z.git ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/z
    echo "source ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/z/z.sh" >> ~/.zshrc
fi

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

