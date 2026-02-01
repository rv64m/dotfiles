# Dotbot cross-platform dotfiles (Ubuntu + macOS + Windows 11)

Features:
- Zsh + Oh My Zsh + common plugins (Linux/macOS)
- tmux config
- LazyVim (Neovim)
- Proxy helpers (zsh + PowerShell)
- Node.js LTS via nvm
- Windows bootstrap via winget + scoop

## Install (Linux/macOS)
```bash
./install
```

## Install (Windows 11)
```powershell
.\install.ps1
```

Notes:
- Ubuntu uses apt-get; macOS uses Homebrew.
- Windows uses winget to install Git + Neovim and sets up Scoop.
- tmux + zsh are not configured on Windows directly (use WSL for full parity).
