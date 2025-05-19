return {
  -- 如果你明确知道 rustaceanvim 是这样被引入的
  -- 或者如果你是手动添加 rustaceanvim
  {
    'mrcjkb/rustaceanvim',
    -- 可选：指定版本或分支
    -- version = "^4", -- 例如，或者具体的 commit hash
    ft = { 'rust' },
    opts = {
      -- 这是传递给 rustaceanvim.setup() 的选项
      server = {
        -- 这些设置会传递给 rust-analyzer
        settings = {
          ['rust-analyzer'] = {
            -- 禁用保存时检查
            checkOnSave = {
              command = 'clippy', -- 通常默认是 clippy，也可以是 "check"
              enable = false,
            },
            -- 你可能还想检查其他可能触发保存时检查的设置，例如 lens
            lens = {
              enable = true, -- 保持 lens 本身启用 (可选)
              commands = {
                -- 如果 lens 中也有 checkOnSave 的选项，确保它也被禁用或不启用
                -- checkOnSave = { enable = false } -- 根据 rustaceanvim 的具体实现
              },
            },
            -- 其他你想要的 rust-analyzer 设置
            -- например:
            -- cargo = {
            --   features = "all",
            -- },
            -- procMacro = {
            --   enable = true,
            -- },
          },
        },
        -- 你可以在这里覆盖 rustaceanvim 为 rust-analyzer 设置的 on_attach 函数
        -- on_attach = function(client, bufnr)
        --   -- 默认的 on_attach 通常由 rustaceanvim 处理
        --   -- 你可以在这里添加或覆盖键位绑定等
        --   print("Rust-analyzer attached to buffer: " .. bufnr)
        -- end,
      },
      -- 其他 rustaceanvim 特有的设置可以在这里配置
      -- tools = {
      --   hover_actions = {
      --     auto_focus = true,
      --   },
      -- },
    },
    config = function(_, opts)
      -- 如果 opts 需要更复杂的处理或你想在 setup 前后做些事情，可以在这里写
      -- 通常对于 rustaceanvim，直接使用 opts 就足够了
      require('rustaceanvim').setup(opts)
    end,
  },

  -- 备选方案: 如果 LazyVim 通过其 "extras" 管理 Rust (例如 lazyvim.plugins.extras.lang.rust)
  -- 你可能需要像这样覆盖默认配置：
  -- {
  --   "lazyvim.plugins.extras.lang.rust", -- 或者实际的插件名称
  --   opts = function(_, opts) -- 使用函数形式来合并或修改默认 opts
  --     -- 确保 rust-analyzer 的配置被正确修改
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
  --       -- 另一种可能的结构，具体取决于 LazyVim extra 的实现
  --       opts.server.settings["rust-analyzer"].checkOnSave = {
  --         enable = false,
  --         command = "clippy", -- 保持 command 或移除，因为 enable 是 false
  --       }
  --     else
  --       -- 如果结构更复杂，你可能需要打印 opts 来查看其结构
  --       -- print(vim.inspect(opts))
  --       -- 然后相应地修改
  --       -- 作为一种更通用的方式，如果 rustaceanvim 被配置为 lspconfig 的一部分
  --       if opts.servers and opts.servers.rust_analyzer then -- 注意这里可能是 rust_analyzer (下划线)
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
