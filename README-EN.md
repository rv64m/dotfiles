# InsisVim

An out-of-the-box Neovim IDE layer that setup development environment in an incredibly simple way.

```lua
require("insis").setup({
  -- enable features here
  golang = {
    enable = true,
    lsp = "gopls",
    linter = "golangci-lint",
    formatter = "gofmt",
    format_on_save = true,
  },
})
```

## Preview

https://github.com/nshen/InsisVim/assets/181506/ca0fe9a0-122f-471a-bbe0-7656e0304309

## 🛠 Installation

`npx zx https://insisvim.github.io/install.mjs`

> Note: If any of `git`, `wget`, `curl`, `ripgrep`, `node.js v16+`, `nvim v0.9.x` are missing, the installation will exit and prompt you.

On Mac you can `brew install` anything above.

On Ubuntu you can check [Ubuntu installation guide](https://github.com/nshen/InsisVim/issues/5).

Then try again.


## Setup and Configuration

Edit `~/.config/nvim/init.lua`

```lua
require("insis").setup({
    -- Set parameters as needed
})
```

Most built-in modules are enabled by default, but programming environment-related modules are disabled by default. Enabling them is also very simple. For example, to enable Golang development, just:

```lua
require("insis").setup({
  golang = {
    enable = true,
    format_on_save = true,
  },
})
```

Keep the network environment smooth, `:wq` save and restart will automatically install the Golang Language Server, syntax highlighting, golangci-lint.

The configuration of other languages is similar. The complete parameter list is in this [config.lua](https://github.com/nshen/InsisVim/blob/main/lua/insis/config.lua). The documentation is not yet complete. Please try it yourself.

Currently, only front-end development configuration is more complex, because it requires the installation of multiple LSPs, syntax highlighting for various file types, etc.

### Frontend development

```lua
require("insis").setup({
  frontend = {
    enable = true,
    prisma = true,
    vue = false,
    format_on_save = true,
    code_actions = "eslint_d",
    ---@type "eslint_d" | "prettier"
    formatter = "prettier",
    cspell = false,
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

The configuration I am currently using is as follows, for reference only. Please turn on the language environment-related modules one by one, otherwise after restarting, many services will be installed at once and it will take a long time to wait.

```lua
require("insis").setup({
  clangd = {
    enable = true,
  },
  git = {
    current_line_blame = true,
  },
  lock_plugin_commit = false,
  enable_imselect = true,
  enable_very_magic_search = true,
  lua = {
    enable = true,
  },
  markdown = {
    enable = true,
    -- formatter = false,
    format_on_save = true,
  },
  golang = {
    enable = true,
    format_on_save = true,
  },
  json = {
    enable = true,
    format_on_save = false,
  },
  yaml = {
    enable = true,
  },
  docker = {
    enable = true,
  },
  frontend = {
    enable = true,
    prisma = true,
    vue = false,
    format_on_save = true,
    code_actions = "eslint_d",
    ---@type "eslint_d" | "prettier"
    formatter = "prettier",
    cspell = false,
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
  -- yaml = {
  --   enable = true,
  --   format_on_save = true,
  -- },
  --
  -- clangd = {
  --   enable = true,
  --   format_on_save = true,
  -- },
  --
  -- rust = {
  --   enable = true,
  --   format_on_save = true,
  -- },
  --
  -- bash = {
  --   enable = true,
  --   format_on_save = true,
  -- },
  --
  -- python = {
  --   enable = true,
  --   format_on_save = true,
  -- },
  -- ruby = {
  --   enable = true,
  -- },
})

```

## Requirements

- Neovim v0.9.x.
- Node.js v16+.
- Nerd Fonts.

## License

MIT

WIP 🟡, PR is welcome.