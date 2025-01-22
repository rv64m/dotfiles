#! /bin/bash

source "lib/sep.sh"  

print_separator "Installing zsh"
if ! which zsh >/dev/null 2>&1; then
    echo "Installing zsh..."
    sudo apt install -y zsh
else
    echo "zsh is already installed. Skipping..."
fi

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
print_separator "Configuring oh-my-zsh..."
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