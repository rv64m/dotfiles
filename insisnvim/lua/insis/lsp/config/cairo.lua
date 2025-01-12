local common = require("insis.lsp.common-config")
local lspconfig = require("lspconfig")
local opts = {
    capabilities = common.capabilities,
    flags = common.flags,
    on_attach = function(_, bufnr)
        common.keyAttach(bufnr)
    end,

    cmd = { "cairo-language-server", "/C", "--node-ipc" },
    filetypes = { "cairo" },
    -- init_options = {
    --     hostInfo = "neovim"
    -- },
    root_dir = lspconfig.util.root_pattern("Scarb.toml", "cairo_project.toml", ".git"),
}
return {
    on_setup = function(server)
        server.setup(opts)
    end,
}
