# My Neovim Configuration

This is a personalized Neovim configuration based on the excellent `kickstart.nvim` starter template. It's designed to be a lightweight yet powerful IDE-like experience, tailored for web and systems development.

## Features

This configuration comes with a curated set of plugins to enhance the Neovim experience:

-   **Plugin Manager**: [lazy.nvim](https://github.com/folke/lazy.nvim) - A modern and fast plugin manager for Neovim.
-   **Fuzzy Finder**: [Telescope](https://github.com/nvim-telescope/telescope.nvim) - For finding files, buffers, LSP definitions, and more.
-   **Language Server Protocol (LSP)**: [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) - The core of the IDE experience, providing code intelligence features.
-   **Autocompletion**: [blink.cmp](https://github.com/saghen/blink.cmp) - A fast and extensible autocompletion engine.
-   **Syntax Highlighting**: [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) - For rich and accurate syntax highlighting.
-   **Code Folding**: [nvim-ufo](https://github.com/kevinhwang91/nvim-ufo) - A modern and fast code folding plugin.
-   **Git Integration**: [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) - To show git changes in the sign column.
-   **File Explorer**: [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim) - A modern file explorer for Neovim.
-   **Terminal**: [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim) - For managing terminal windows within Neovim.
-   **And more...** including auto-pairing, code outlining, and various UI enhancements.

## Installation

> **Note**: This configuration is based on `kickstart.nvim`. For detailed installation instructions, please refer to the [original `kickstart.nvim` README](https://github.com/nvim-lua/kickstart.nvim/blob/master/README.md).

1.  **Clone the repository**: `git clone <your-repo-url> ~/.config/nvim`
2.  **Start Neovim**: `nvim`

Upon starting Neovim for the first time, `lazy.nvim` will automatically install all the plugins.

## Keybindings

### General

| Keybinding | Description |
|---|---|
| `<Esc>` | Clear search highlights |
| `<leader>q` | Open diagnostic quickfix list |
| `<leader>e` | Show diagnostic error messages |
| `[d` | Go to previous diagnostic message |
| `]d` | Go to next diagnostic message |
| `<Esc><Esc>` | Exit terminal mode |
| `<C-h>` | Move focus to the left window |
| `<C-l>` | Move focus to the right window |
| `<C-j>` | Move focus to the lower window |
| `<C-k>` | Move focus to the upper window |

### Telescope

| Keybinding | Description |
|---|---|
| `<leader>sh` | Search help tags |
| `<leader>sk` | Search keymaps |
| `<leader>ss` | Search select telescope |
| `<leader>sd` | Search diagnostics |
| `<leader>sr` | Search resume |
| `<leader>ff` | Search files |
| `<leader>fw` | Search current word |
| `<leader>fg` | Search by grep |
| `<leader>fo` | Search recent files |
| `<leader><leader>` | Find existing buffers |
| `<leader>/` | Fuzzily search in current buffer |
| `<leader>s/` | Search in open files |
| `<leader>sn` | Search Neovim files |

### LSP

| Keybinding | Description |
|---|---|
| `grn` | Rename |
| `ga` | Goto code action |
| `gr` | Goto references |
| `gi` | Goto implementation |
| `gd` | Goto definition |
| `gD` | Goto declaration |
| `gs` | Open document symbols |
| `gS` | Open workspace symbols |
| `grt` | Goto type definition |
| `<leader>th` | Toggle inlay hints |

### Debugging

| Keybinding | Description |
|---|---|
| `<F5>` | Debug: Start/Continue |
| `<F1>` | Debug: Step Into |
| `<F2>` | Debug: Step Over |
| `<F3>` | Debug: Step Out |
| `<leader>b` | Debug: Toggle Breakpoint |
| `<leader>B` | Debug: Set Breakpoint |
| `<F7>` | Debug: See last session result |

### Git

| Keybinding | Description |
|---|---|
| `]c` | Jump to next git change |
| `[c` | Jump to previous git change |
| `<leader>hs` | Git stage hunk |
| `<leader>hr` | Git reset hunk |
| `<leader>hS` | Git stage buffer |
| `<leader>hu` | Git undo stage hunk |
| `<leader>hR` | Git reset buffer |
| `<leader>hp` | Git preview hunk |
| `<leader>hb` | Git blame line |
| `<leader>hd` | Git diff against index |
| `<leader>hD` | Git diff against last commit |
| `<leader>tb` | Toggle git show blame line |
| `<leader>tD` | Toggle git show deleted |

### Neo-tree

| Keybinding | Description |
|---|---|
| `\` | NeoTree reveal |
| `P` | Toggle preview |

### Outline

| Keybinding | Description |
|---|---|
| `{` | Outline jump to previous symbol |
| `}` | Outline jump to next symbol |
| `<leader>a` | Outline toggle |

### Terminal

| Keybinding | Description |
|---|---|
| `<leader>tf` | Terminal float |
| `<leader>th` | Terminal horizontal (bottom) |
| `<leader>tv` | Terminal vertical (left) |
| `<leader>tr` | Terminal right |
| `<leader>tg` | Terminal lazygit |

### Folding

| Keybinding | Description |
|---|---|
| `zR` | Open all folds |
| `zM` | Close all folds |
