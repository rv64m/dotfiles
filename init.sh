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


# rustup update nightly
# rustup target add wasm32-unknown-unknown --toolchain nightly


# =========================
# Initial node related
# =========================
nvm list-remote
nvm install v20.13.1


echo "初始化完成！请重新启动终端以使更改生效。"
