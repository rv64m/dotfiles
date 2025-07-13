# InsisVim

An out-of-the-box Neovim IDE layer that configures the development environment in an incredibly simple way, for example, to configure `golang`, you only need:

```lua
require("insis").setup({
  golang = {
    enable = true,
    lsp = "gopls",
    linter = "golangci-lint",
    formatter = "gofmt",
    format_on_save = true,
  },
})
```

After saving with `:wq` and restarting, it will automatically install syntax highlighting, Golang Language Server, Linter, Formatter, etc.

## 🛠 Installation

https://github.com/nshen/InsisVim/assets/181506/ad36e1b1-05f6-47e9-bf2e-6738f539ccce

### Prerequisites

- If the following common command-line tools are missing, `git`, `wget`, `curl`, `ripgrep`, `nvim v0.9.x`, the installation may fail.

  - On Mac, you can use `brew install` to install the above tools.
  - On Ubuntu, you can check the [Ubuntu Installation Guide](https://github.com/nshen/InsisVim/issues/5).

- If you have installed other configurations before, it is recommended to delete or back up the following directories first

  - `~/.local/share/nvim`
  - `~/.cache/nvim`
  - `~/.config/nvim`

* A stable internet connection is required. It is recommended to use a VPN or proxy if you are in a region with network restrictions. If you encounter [network problems, you can discuss them here](https://github.com/nshen/learn-neovim-lua/discussions/categories/q-a?discussions_q=is%3Aopen+category%3AQ%26A+label%3A%E6%8F%92%E4%BB%B6%E5%AE%89%E8%A3%85%E9%97%AE%E9%A2%98)

### Installation Steps

1. Clone this project to the Neovim configuration directory

```lua
git clone https://github.com/nshen/InsisVim.git ~/.config/nvim
```

2. Run `nvim` and wait for all plugins to be installed

3. Restart

## Custom Configuration

Customizing the configuration is very simple, just like configuring a plugin, you just need to modify `~/.config/nvim/init.lua` and then save and restart.

```lua
require("insis").setup({
    -- Set parameters as needed
})
```

There are many parameters supported here, but they are basically divided into **common configurations** and **programming environment configurations**.

### Common Configurations

For example, for common configurations like setting the theme with `colorscheme`, you can just modify it, save with `:wq`, and restart for it to take effect.

```lua
require("insis").setup({
    colorscheme = "tokyonight"
})
```

> InsisVim uses the `tokyonight` theme by default, and also has built-in themes like `nord`, `onedark`, `gruvbox`, `nightfox`, `nordfox`, `duskfox`, and `dracula`.
> You can preview the built-in themes with the `:InsisColorPreview` command.

https://github.com/nshen/InsisVim/assets/181506/15517b20-acdf-45eb-9db6-9a0d0806cb4a

#### AI Completion

<details>
<summary>Copilot Configuration</summary>
  
```lua
require("insis").setup({
  cmp = {
    -- Enable copilot
    copilot = true,
  },
})
```

InsisVim has the following built-in plugins, which will be enabled after you enable them.

- [copilot.lua](https://github.com/zbirenbaum/copilot.lua)
- [copilot-cmp](https://github.com/zbirenbaum/copilot-cmp)

Because copilot is a paid service, you need to run `:Copilot auth` for authentication before you can use it for the first time. However, if you are a student, teacher, or contributor to an open source project, you can [apply for free use](https://docs.github.com/en/copilot/quickstart).

> GitHub Copilot is free to use for verified students, teachers, and maintainers of popular open source projects.

</details>


<details>
<summary>Codeium Configuration</summary>
  
```lua
require("insis").setup({
  cmp = {
    -- Enable codeium 
    codeium = true,
  },
})
```

InsisVim has [Codeium.nvim](https://github.com/Exafunction/codeium.nvim) built-in, which will be enabled after you enable it.

You need to run `:Codeium Auth` for authentication the first time you use it.

</details>

#### Buffers

In the Vim world, a Buffer represents a file that has been loaded into memory. It\'s very similar to a Tab in VSCode. When you see a tab in VSCode, it means that a file has been loaded into memory.

InsisVim uses the [bufferline.nvim](https://github.com/akinsho/bufferline.nvim) plugin to simulate this behavior, and it simplifies the configuration, making it very easy to customize keybindings.

https://github.com/nshen/InsisVim/assets/181506/a639f05b-adab-4279-8482-e3088d2fae8f

<details>
<summary>Bufferline Configuration</summary>
  
```lua
require("insis").setup({
  bufferLine = {
    enable = true,
    keys = {
      -- left / right cycle
      prev = "<C-h>",
      next = "<C-l>",
      -- close current buffer
      close = "<C-w>",
      -- close = "<leader>bc",
      -- close all left / right tabs
      close_left = "<leader>bh",
      close_right = "<leader>bl",
      -- close all other tabs
      close_others = "<leader>bo",
      close_pick = "<leader>bp",
    },
  },
})
```

</details>

#### Super Windows

Unlike VSCode, a Window in Vim is just a window for displaying a Buffer. It allows multiple windows to display or even modify a Buffer at the same time. In InsisVim, you can very easily define a series of window-related shortcuts, including horizontal and vertical splitting, fast window switching, closing, etc., which are called Super windows.

<details>
<summary>Super Windows Configuration</summary>
  
```lua
require("insis").setup({
  s_windows = {
    enable = true,
    keys = {
      split_vertically = "sv",
      split_horizontally = "sh",
      -- close current
      close = "sc",
      -- close others
      close_others = "so",
      -- jump between windows
      jump_left = { "<A-h>", "<leader>h" },
      jump_right = { "<A-l>", "<leader>l" },
      jump_up = { "<A-k>", "<leader>k" },
      jump_down = { "<A-j>", "<leader>j" },
      -- control windows size
      width_decrease = "s,",
      width_increase = "s.",
      height_decrease = "sj",
      height_increase = "sk",
      size_equal = "s=",
    },
  },
})
```

</details>

#### Super Tab

A Tab in Vim is used to save one or more window combinations, so you can switch to different Tabs to do different things without changing the window layout.

In InsisVim, you can also quickly define a set of tab-related shortcuts, called Super Tab.

<details>
<summary>Super Tab Configuration</summary>

Note that super tab is not commonly used, so it is disabled by default and needs to be enabled manually.

```lua
require("insis").setup({
  s_tab = {
    enable = true, -- disabled by default
    keys = {
      split = "ts",
      prev = "th",
      next = "tl",
      first = "tj",
      last = "tk",
      close = "tc",
    },
  },
})
```

</details>

---

To put it simply, the relationship between Buffers, Windows, and Tabs is as follows:

- A buffer is a file loaded into memory. We use the bufferline plugin to simulate the behavior of tabs in VSCode.
- A window is responsible for displaying the buffer. Familiarizing yourself with the shortcuts for quickly splitting windows and switching between them is the key to improving development efficiency.
- A tab is responsible for organizing the window layout. It is not commonly used, so it is disabled by default.

<img width="762" alt="image" src="https://github.com/nshen/InsisVim/assets/181506/fb10bd17-895a-4f67-9718-87e11eb538b3">

---

### Programming Environment Configuration

For example, for the `Golang` environment, after setting enable to true, saving with `:wq` and restarting will automatically call Mason to install the corresponding syntax highlighting, Language Server, Linter, Formatter, etc. After the installation is complete, restart and open the corresponding Golang project for it to take effect.

```lua
require("insis").setup({
  colorscheme = "tokyonight"
  golang = {
    enable = true,
  },
})
```

Enabling other language-related modules is similar. Just modify `~/.config/nvim/init.lua`, save, and restart to complete the installation automatically.

Since enabling the programming environment requires additional installation of LSP, Linter, Formatter, syntax highlighting, etc., the **programming environment configurations** are disabled by default. You need to enable them manually. Only `Lua` is enabled by default, because you will often use the `Lua` language to modify the configuration. And most of the **common configurations** are enabled by default.

> The complete list of default parameters is here [config.lua](https://github.com/nshen/InsisVim/blob/main/lua/insis/config.lua)

## Common Programming Environment Configurations

Please enable the language environment related modules one by one, otherwise many services will be installed at once after restarting, which will take a long time.

<details>
<summary>JSON Editing</summary>
  
```lua
require("insis").setup({
  json = {
    enable = true,
    -- The following are the default values and can be omitted
    lsp = "jsonls",
    ---@type "jsonls" | "prettier"
    formatter = "jsonls",
    format_on_save = false,
   }
})
```

After enabling the `json` function and restarting:

- It will automatically install Treesitter\'s JSON syntax highlighting.
- It will automatically install and configure the [jsonls](https://github.com/microsoft/vscode-json-languageservice) Language Server.

</details>

<details>
<summary>Markdown Editing</summary>
  
```lua
require("insis").setup({
  markdown = {
    enable = true,
    -- The following are the default values and can be omitted
    mkdnflow = {
      next_link = "gn",
      prev_link = "gp",
      next_heading = "gj",
      prev_heading = "gk",
      -- follow link
      follow_link = "gd",
      -- go back from link
      go_back = "<C-o>",
      toggle_item = "tt",
    },
    formatter = "prettier",
    -- format on save is false by default
    format_on_save = false,
    -- text will wrap automatically by default when it reaches the edge
    wrap = true,
    ---:MarkdownPreview command opens the article preview with the dark skin by default
    ---@type "dark" | "light"
    theme = "dark",
  },
})
```

After enabling the markdown function and restarting, it will automatically install Treesitter\'s markdown syntax highlighting and prettier for formatting.

It adds the `:MarkdownPreview` command to preview markdown files in real time.

It adds `mkdnflow.nvim` related shortcuts.

It adds markdown related shortcuts, for example `5x5table`.

</details>

<details>
<summary>Frontend Development</summary>
  
Frontend development configuration is relatively complex because it requires installing multiple LSPs, syntax highlighting for multiple file types, etc. It will take a long time to wait after restarting.

```lua
require("insis").setup({
  frontend = {
    enable = true,
    ---@type "eslint" | false
    linter = "eslint", -- :EslintFixAll command added
    ---@type false | "prettier" | "tsserver"
    formatter = "tsserver",
    format_on_save = false,
    cspell = false,
    tailwindcss = true,
    prisma = false,
    -- vue will take over typescript lsp
    vue = false,
    -- extra lsp command provided by typescript.nvim
    typescript = {
      keys = {
        ts_organize = "gs",
        ts_rename_file = "gR",
        ts_add_missing_import = "ga",
        ts_remove_unused = "gu",
        ts_fix_all = "gf",
        ts_goto_source = "gD",
      },
    },
  },
})
```

</details>

<details>
<summary>Solidity Development</summary>
  
```lua
require("insis").setup({
  solidity = {
    enable = true,
    --linter can be sohint or false
    linter = "solhint",
    format_on_save = true,
  },
})
```
When `enable` is set to `true` and you restart, it will install:

- TreeSitter syntax highlighting: `solidity`
- Language Server: [nomicfoundation-solidity-language-server](https://github.com/NomicFoundation/hardhat-vscode/tree/development/server)
- Code snippets: [solidity snippets](https://github.com/rafamadriz/friendly-snippets/blob/main/snippets/solidity.json)
- If a linter is set, it will automatically download and start [sohint](https://github.com/protofire/solhint).

</details>

<details>
<summary>Golang Development</summary>
  
```lua
require("insis").setup({
  golang = {
    enable = true,
    -- The following are the default values and can be omitted
    lsp = "gopls",
    linter = "golangci-lint",
    formatter = "gofmt",
    format_on_save = false,
  },
})
```
</details>

<details>
<summary>clangd Development</summary>
  
```lua
require("insis").setup({
  clangd = {
    enable = true,
    lsp = "clangd",
    -- linter = "clangd-tidy",
    formatter = "clang-format",
    format_on_save = false,
  },
})
```
</details>

<details>
<summary>Bash Development</summary>
  
```lua
require("insis").setup({
  bash = {
    enable = true,
    lsp = "bashls",
    --  brew install shfmt
    formatter = "shfmt",
    format_on_save = false,
  },
})
```
</details>

<details>
<summary>Python Development</summary>
  
```lua
require("insis").setup({
  python = {
    enable = true,
    -- can be pylsp or pyright
    lsp = "pylsp",
    -- pip install black
    -- asdf reshim python
    formatter = "black",
    format_on_save = false,
  },
})
```
</details>

<details>
<summary>Ruby Development</summary>
  
```lua
require("insis").setup({
  ruby = {
    enable = true,
    lsp = "ruby_ls",
    -- gem install rubocop
    formatter = "rubocop",
    format_on_save = false,
  },
})
```
</details>

<details>
<summary>Docker Development</summary>
  
```lua
require("insis").setup({
  docker = {
    enable = true,
    lsp = "dockerls",
  },
})
```
</details>

## Daily Use

### Common Commands

- Update plugins:
  - `:Lazy restore` updates all plugins to the stable version locked in `lazy-lock.json`
  - `:Lazy update` updates all plugins to the latest version, compatibility is not guaranteed
- View error messages:
  - `:Notifications`
  - `:messages`
- View/install LSP:
  - `:LspInfo` to view the running status
  - `:Mason` to install, update, etc.
- Update syntax highlighting:
  - `:TSUpdate` to update all
  - `:TSUpdate <json>` to update individually
- Markdown preview:
  - `:MarkdownPreview`

### Code Folding Shortcuts

| fold shortcuts | description     |
| -------------- | --------------- |
| zc             | close fold      |
| zo             | open fold       |
| za             | toggle fold     |
| zM             | close all folds |
| zR             | open all folds  |

Updating...

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

## WeChat Group

If you have any questions, scan the code to add me, please specify `vim`, and I will invite you to the group. WeChat ID: nshen121

<img src="./wechat.jpg" alt="image" width="300" height="auto">

## Project Structure

How to extend

TODO

## Requirements

- Neovim v0.9.x.
- Nerd Fonts.

## License

MIT

WIP 🟡, PR is welcome.
