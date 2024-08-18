#! /bin/bash

# Add raw.githubusercontent.com to /etc/hosts
echo "Checking if raw.githubusercontent.com is already in /etc/hosts..."
if ! grep -q "raw.githubusercontent.com" /etc/hosts; then
    echo "Adding raw.githubusercontent.com to /etc/hosts..."
    sudo tee -a /etc/hosts > /dev/null << EOT
185.199.108.133 raw.githubusercontent.com
185.199.109.133 raw.githubusercontent.com
185.199.110.133 raw.githubusercontent.com 
185.199.111.133 raw.githubusercontent.com
EOT
    echo "raw.githubusercontent.com added to /etc/hosts"
else
    echo "raw.githubusercontent.com is already in /etc/hosts. Skipping..."
fi


# Install Homebrew
if ! command -v brew &> /dev/null
then
    echo "Homebrew not found. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # Add brew into profile
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zshrc
else
    echo "Homebrew is already installed. Skipping..."
fi

# Install basic tools
brew install fzf jq protobuf cmake llvm python3 pipenv jupyterlab nvm pnpm eza ripgrep fish unzip


# Install gitui
if ! command -v gitui &> /dev/null
then
    echo "Installing gitui..."
    curl -L https://github.com/extrawurst/gitui/releases/download/v0.26.3/gitui-mac.tar.gz -o gitui.tar.gz
    tar -xzf gitui.tar.gz
    chmod +x gitui
    sudo mv gitui /home/brew/bin
    rm gitui.tar.gz
    echo "gitui installed successfully."
else
    echo "gitui is already installed. Skipping..."
fi

# Install rust
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

# Install node
export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

if ! nvm list | grep -q "v16.20.2"; then
    nvm install v16.20.2
else
    echo "Node.js v16.20.2 is already installed. Skipping..."
fi

if ! nvm list | grep -q "v18.20.4"; then
    nvm install v18.20.4
else
    echo "Node.js v18.20.4 is already installed. Skipping..."
fi

if ! nvm list | grep -q "v20.16.0"; then
    nvm install v20.16.0
else
    echo "Node.js v20.16.0 is already installed. Skipping..."
fi

if [ ! -f ~/.nvmrc ]; then
    cp .nvmrc ~/.nvmrc
    echo "Created .nvmrc file with Node.js version v20.16.0"
    nvm use
else
    echo ".nvmrc file already exists. Skipping creation..."
fi

# Install nerdfonts
brew install font-hack-nerd-font