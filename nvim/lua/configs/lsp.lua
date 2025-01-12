return {
    rust = {
        cmd = { "rust-analyzer" },
        filetypes = { "rust" },
        root_dir = require("lspconfig.util").root_pattern("Cargo.toml", "rust-project.json"),
    },
}