return {
  "simrat39/rust-tools.nvim", -- add lsp plugin
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = { "rust_analyzer" },
    },
  },

  {
    "wakatime/vim-wakatime",
    lazy = false,
  },
  {
    'Mofiqul/vscode.nvim',
    lazy = false,
  },
  {
    "tjdevries/colorbuddy.nvim",
    lazy = false,
    config = function()
      require('colorbuddy').setup()
    end,
  },
  {
    "svrana/neosolarized.nvim",
    lazy = false,
    config = function()
      require('neosolarized').setup({
        comment_italics = true,
        background_set = false,
    })
    end,
  },
  {
    "jose-elias-alvarez/typescript.nvim", -- add lsp plugin
    {
      "williamboman/mason-lspconfig.nvim",
      opts = {
        ensure_installed = { "tsserver" }, -- automatically install lsp
      },
    },
  },

  { "bluz71/vim-nightfly-colors", name = "nightfly", lazy = false, priority = 1000 },
  {
  "folke/flash.nvim",
  event = "VeryLazy",
  ---@type Flash.Config
  opts = {},
  -- stylua: ignore
  keys = {
    { "s", mode = { "n", "o", "x" }, function() require("flash").jump() end, desc = "Flash" },
    { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  },
},
  {
    "github/copilot.vim",
    lazy = false,
  },
  {
    "nvim-telescope/telescope-live-grep-args.nvim",
    lazy = false,
    config = function()
      require("telescope").load_extension("live_grep_args")
    end
  } 
  -- You can also add new plugins here as well:
  -- Add plugins, the lazy syntax
  -- "andweeb/presence.nvim",
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "BufRead",
  --   config = function()
  --     require("lsp_signature").setup()
  --   end,
  -- },
}
