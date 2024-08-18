#===============================================================================
# Install Fisher and plugins
#===============================================================================
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher

fisher install jorgebucaran/nvm.fish
fisher install jethrokuan/z
fisher install PatrickF1/fzf.fish
fisher install jorgebucaran/spark.fish
fisher update franciscolourenco/done
fisher install joseluisq/gitnow@2.12.0
fisher install jorgebucaran/autopair.fish
fisher install nickeb96/puffer-fish
fisher install paldepind/projectdo
fisher install gazorby/fish-abbreviation-tips
fisher install IlanCosman/tide@v6


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
cp -r $PWD/fish/functions $HOME/.config/fish/
cp -r $PWD/fish/conf.d $HOME/.config/fish/

echo "Fish shell configuration completed."
