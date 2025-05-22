return {
    'stevearc/aerial.nvim',
    opts = {},
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons"
    },
    config = function()
        require("aerial").setup({
            on_attach = function(bufnr)
                -- Jump forwards/backwards with '{' and '}'
                vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>",
                    { buffer = bufnr, desc = '[O]utline Jump to previous symbol' })
                vim.keymap.set("n", "}", "<cmd>AerialNext<CR>",
                    { buffer = bufnr, desc = '[O]utline Jump to next symbol' })
                vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle float<CR>",
                    { buffer = bufnr, desc = '[O]utline Toggle' })
            end,
        })
    end
}
