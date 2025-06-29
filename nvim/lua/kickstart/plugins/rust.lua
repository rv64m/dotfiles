return {
  -- If you explicitly know that rustaceanvim is introduced this way
  -- Or if you are adding rustaceanvim manually
  {
    'mrcjkb/rustaceanvim',
    -- Optional: specify a version or branch
    -- version = "^4", -- for example, or a specific commit hash
    ft = { 'rust' },
    opts = {
      -- These are the options passed to rustaceanvim.setup()
      server = {
        -- These settings are passed to rust-analyzer
        settings = {
          ['rust-analyzer'] = {
            -- Disable check on save
            checkOnSave = {
              command = 'clippy', -- usually clippy by default, can also be "check"
              enable = false,
            },
            -- You may also want to check other settings that might trigger a check on save, such as lens
            lens = {
              enable = true, -- keep lens itself enabled (optional)
              commands = {
                -- If there is also a checkOnSave option in lens, make sure it is also disabled or not enabled
                -- checkOnSave = { enable = false } -- depending on the specific implementation of rustaceanvim
              },
            },
            -- Other rust-analyzer settings you want
            -- for example:
            -- cargo = {
            --   features = "all",
            -- },
            -- procMacro = {
            --   enable = true,
            -- },
          },
        },
        -- You can override the on_attach function that rustaceanvim sets for rust-analyzer here
        -- on_attach = function(client, bufnr)
        --   -- The default on_attach is usually handled by rustaceanvim
        --   -- You can add or override keybindings here
        --   print("Rust-analyzer attached to buffer: " .. bufnr)
        -- end,
      },
      -- Other rustaceanvim-specific settings can be configured here
      -- tools = {
      --   hover_actions = {
      --     auto_focus = true,
      --   },
      -- },
    },
    config = function(_, opts)
      -- If opts requires more complex processing or you want to do something before or after setup, you can write it here
      -- Usually for rustaceanvim, using opts directly is sufficient
      require('rustaceanvim').setup(opts)
    end,
  },

  -- Alternative: If LazyVim manages Rust through its "extras" (e.g. lazyvim.plugins.extras.lang.rust)
  -- You may need to override the default configuration like this:
  -- {
  --   "lazyvim.plugins.extras.lang.rust", -- or the actual plugin name
  --   opts = function(_, opts) -- use a function to merge or modify the default opts
  --     -- Make sure the rust-analyzer configuration is modified correctly
  --     if opts.servers and opts.servers["rust-analyzer"] then
  --       opts.servers["rust-analyzer"].settings = opts.servers["rust-analyzer"].settings or {}
  --       opts.servers["rust-analyzer"].settings["rust-analyzer"] =
  --         vim.tbl_deep_extend(
  --         "force",
  --         opts.servers["rust-analyzer"].settings["rust-analyzer"] or {},
  --         {
  --           checkOnSave = {
  --             enable = false,
  --           },
  --         }
  --       )
  --     elseif opts.server and opts.server.settings and opts.server.settings["rust-analyzer"] then
  --       -- Another possible structure, depending on the implementation of the LazyVim extra
  --       opts.server.settings["rust-analyzer"].checkOnSave = {
  --         enable = false,
  --         command = "clippy", -- keep the command or remove it, since enable is false
  --       }
  --     else
  --       -- If the structure is more complex, you may need to print opts to see its structure
  --       -- print(vim.inspect(opts))
  --       -- and then modify it accordingly
  --       -- As a more general way, if rustaceanvim is configured as part of lspconfig
  --       if opts.servers and opts.servers.rust_analyzer then -- note that it may be rust_analyzer (with an underscore) here
  --            opts.servers.rust_analyzer.settings = opts.servers.rust_analyzer.settings or {}
  --            opts.servers.rust_analyzer.settings["rust-analyzer"] = vim.tbl_deep_extend("force",
  --                opts.servers.rust_analyzer.settings["rust-analyzer"] or {},
  --                {
  --                    checkOnSave = { enable = false }
  --                }
  --            )
  --       end
  --     end
  --     return opts
  --   end,
  -- },
}