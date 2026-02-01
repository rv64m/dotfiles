local keymap = vim.keymap
keymap.set("n", "<leader>e", ":Neotree toggle<CR>", { silent = true })
keymap.set("n", "<leader>ff", ":Telescope find_files<CR>", { silent = true })
keymap.set("n", "<leader>fg", ":Telescope live_grep<CR>", { silent = true })
