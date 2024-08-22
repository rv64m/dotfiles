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


# Install nerdfonts
brew install font-hack-nerd-font