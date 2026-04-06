-- ~/.config/nvim/lua/config/keymaps.lua

vim.g.mapleader = " " -- space as leader key

local map = vim.keymap.set

-- Window navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-l>", "<C-w>l")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")

-- Git
map("n", "<leader>gd", ":DiffviewOpen main<CR>", { desc = "Diff vs main" })
map("n", "<leader>gh", ":DiffviewFileHistory %<CR>", { desc = "File history" })
map("n", "<leader>gc", ":DiffviewClose<CR>", { desc = "Close diffview" })

-- Telescope
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Buffers" })
map("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>", { desc = "Recent files" })

-- Oil
map("n", "<leader>e", "<cmd>Oil<CR>", { desc = "File explorer" })

-- Sean's Specials
map("n", "<leader>sc", ":e ~/localdev/wofstack/._scratch/scratch.md<CR>Go", { desc = "Open scratch" })

-- LSP (set in lsp on_attach, but useful to see together)
-- gd = go to definition
-- K  = hover docs
-- gr = references
-- <leader>rn = rename
-- <leader>ca = code action
