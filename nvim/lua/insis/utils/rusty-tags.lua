-- vim.api.nvim_create_user_command('GenRustTags', function()
--     pcall(function()
--         vim.fn.Preserve("")
--         print "Generated rust ctags"
--     end)
-- end, {})

function GenRustTags()
    vim.cmd("!export RUST_SRC_PATH=$(rustc --print sysroot)/lib/rustlib/src/rust/library/")
    vim.cmd("!rusty-tags vi")
end

vim.api.nvim_create_user_command("GenRustTags", GenRustTags, {})
