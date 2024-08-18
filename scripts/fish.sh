#! /bin/bash


#===============================================================================
# Install Fish
#===============================================================================
if ! command -v fish &> /dev/null
then
    echo "Fish shell not found. Installing Fish..."
    
    # Check the operating system
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        brew install fish
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        # Linux
        if command -v apt-get &> /dev/null; then
            # Debian/Ubuntu
            sudo apt-add-repository ppa:fish-shell/release-3
            sudo apt-get update
            sudo apt-get install -y fish
        elif command -v dnf &> /dev/null; then
            # Fedora
            sudo dnf install -y fish
        elif command -v pacman &> /dev/null; then
            # Arch Linux
            sudo pacman -S fish
        else
            echo "Unsupported Linux distribution. Please install Fish manually."
            exit 1
        fi
    else
        echo "Unsupported operating system. Please install Fish manually."
        exit 1
    fi
    
    echo "Fish shell installed successfully."
else
    echo "Fish shell is already installed. Skipping installation."
fi

# Set fish as the default shell
if [[ "$SHELL" != *"fish"* ]]; then
    echo "Setting fish as the default shell..."
    chsh -s $(which fish)
    echo "Fish set as the default shell. Please log out and log back in for changes to take effect."
else
    echo "Fish is already the default shell."
fi

#===============================================================================
# Install Fisher and plugins
#===============================================================================
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher

## Install nvm: https://github.com/jorgebucaran/nvm.fish
fisher install jorgebucaran/nvm.fish

## Install z: https://github.com/jethrokuan/z
fisher install jethrokuan/z

## Install fzf: https://github.com/franciscolourenco/done
fisher install PatrickF1/fzf.fish

## Install spark: https://github.com/jorgebucaran/spark.fish
fisher install jorgebucaran/spark.fish

## Install done: https://github.com/franciscolourenco/done
fisher update franciscolourenco/done

## Install gitnow: https://github.com/joseluisq/gitnow
fisher install joseluisq/gitnow@2.12.0

## Install autopair: https://github.com/jorgebucaran/autopair.fish
fisher install jorgebucaran/autopair.fish

## Install Puffer: https://github.com/nickeb96/puffer-fish
fisher install nickeb96/puffer-fish

## Install Projectdo: https://github.com/paldepind/projectdo
fisher install paldepind/projectdo

## Install abbreviation: https://github.com/Gazorby/fish-abbreviation-tips
fisher install gazorby/fish-abbreviation-tips

## Install tide@5 https://github.com/IlanCosman/tide
fisher install ilancosman/tide@5


# =========================
# Configure fish shell
# =========================
echo "Configuring fish shell..."

# Create fish config directory if it doesn't exist
mkdir -p $HOME/.config/fish

# Copy fish configuration files
cp $PWD/fish/config.fish $HOME/.config/fish/
cp $PWD/fish/config-linux.fish $HOME/.config/fish/
cp $PWD/fish/config-osx.fish $HOME/.config/fish/
cp $PWD/fish/config-windows.fish $HOME/.config/fish/

# Copy fish functions and conf.d directories
cp -r $PWD/fish/functions $HOME/.config/fish/
cp -r $PWD/fish/conf.d $HOME/.config/fish/

echo "Fish shell configuration completed."
