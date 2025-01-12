require("insis").setup({
    rust = {
        enable = true,
    },
    golang = {
        enable = true,
        lsp = "gopls",
        linter = "golangci-lint",
        formatter = "gofmt",
        format_on_save = true,
    },
    python = {
        enable = true,
        -- can be pylsp or pyright
        lsp = "pylsp",
        -- pip install black
        -- asdf reshim python
        formatter = "black",
        format_on_save = false,
    },
    -- cairo = {
    --     enable = true,
    --     lsp = "cairo_ls",
    -- },
    -- solidity = {
    --     enable = true,
    --     linter = "solhint",
    --     format_on_save = true,
    -- },
})
