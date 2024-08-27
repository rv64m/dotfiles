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
fisher install ilancosman/tide@v6


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
