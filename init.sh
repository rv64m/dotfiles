#!/bin/bash

# =========================
# Install development dependeces
# =========================
sudo apt install -y git clang curl wget libssl-dev \
    llvm libudev-dev make protobuf-compiler build-essential \
    cmake gcc g++

# =========================
# Install rust
# =========================
if ! which rustup >/dev/null 2>&1; then
	curl https://sh.rustup.rs -sSf | sh -s -- -y
    export PATH=$HOME/.cargo/bin:$PATH
	rustup default stable
else
	rustup update
	rustup default stable
fi

# rustup update nightly
# rustup target add wasm32-unknown-unknown --toolchain nightly
rustup target add wasm32-unknown-unknown
rustup component add rust-src


# =========================
# Install fish-shell
# =========================
sudo apt-add-repository ppa:fish-shell/release-3
sudo apt update
sudo apt install -y fish
chsh -s /usr/bin/fish

# =========================
# Configur fish plugins
# See https://github.com/jorgebucaran/awsm.fish
# =========================
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher

## Install nvm: https://github.com/jorgebucaran/nvm.fish
fisher install jorgebucaran/nvm.fish

## Install z: https://github.com/jethrokuan/z
fisher install jethrokuan/z

## Install fzf: https://github.com/franciscolourenco/done
fisher install PatrickF1/fzf.fish

## Install hydro: https://github.com/jorgebucaran/hydro
fisher install jorgebucaran/hydro

## Install spark: https://github.com/jorgebucaran/spark.fish
fisher install jorgebucaran/spark.fish

## Install done: https://github.com/franciscolourenco/done
fisher update franciscolourenco/done

## Install gitnow: https://github.com/joseluisq/gitnow
fisher install joseluisq/gitnow@2.12.0

## Install Sponge: https://github.com/meaningful-ooo/sponge
fisher install meaningful-ooo/sponge

## Install autopair: https://github.com/jorgebucaran/autopair.fish
fisher install jorgebucaran/autopair.fish

## Install Puffer: https://github.com/nickeb96/puffer-fish
fisher install nickeb96/puffer-fish

## Install Projectdo: https://github.com/paldepind/projectdo
fisher install paldepind/projectdo

## Install abbreviation: https://github.com/Gazorby/fish-abbreviation-tips
fisher install gazorby/fish-abbreviation-tips

# =========================
# Initial node related
# =========================
nvm list-remote
nvm install v20.13.1

# =========================
# Initial fish-shell
# =========================
cp $PWD/fish/config.fish $HOME/.config/fish/
cp $PWD/fish/config-linux.fish $HOME/.config/fish/
cp $PWD/fish/config-osx.fish $HOME/.config/fish/
cp $PWD/fish/config-windows.fish $HOME/.config/fish/
cp -r $PWD/fish/functions $HOME/.config/fish/functions
cp -r $PWD/fish/conf.d $HOME/.config/fish/conf.d

echo "初始化完成！请重新启动终端以使更改生效。"
