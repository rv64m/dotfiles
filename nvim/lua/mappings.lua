require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
map("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
map("n", "gp", vim.diagnostic.open_float, { desc = "Open float for diagnostic" })
map("n", "gj", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
map("n", "gk", vim.diagnostic.goto_prev, { desc = "Go to prev diagnostic" })
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
map("n", "<leader>ic", "<CMD>Telescope lsp_incoming_calls<CR>", { desc = "Show incoming calls" })
map("n", "<leader>oc", "<CMD>Telescope lsp_outgoing_calls<CR>", { desc = "Show outgoing calls" })
map("n", "<leader>gg", "<CMD>Telescope diagnostics<CR>", { desc = "List diagnostics" })
map("n", "gr", "<CMD>Telescope lsp_references<CR>", { desc = "Go to references" })
map("n", "gI", "<CMD>Telescope lsp_implementations<CR>", { desc = "Go to implementation" })
map("n", "<leader>ft", "<CMD>Telescope lsp_document_symbols<CR>", { desc = "Document symbols" })
map("n", "<leader>fT", "<CMD>Telescope lsp_workspace_symbols<CR>", { desc = "Workspace symbols" })
