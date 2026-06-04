-- ~/.config/nvim/lua/config/keymaps.lua

vim.g.mapleader = " " -- space as leader key

local map = vim.keymap.set

-- Window navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-l>", "<C-w>l")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")

-- Buffer navigation
map("n", "<Tab>", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "<S-Tab>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })

-- Git
map("n", "<leader>gd", ":DiffviewOpen main<CR>", { desc = "Diff vs main" })
map("n", "<leader>ge", ":DiffviewToggleFiles<CR>", { desc = "Toggle diffview file list" })
map("n", "<leader>gh", ":DiffviewFileHistory %<CR>", { desc = "File history" })
map("n", "<leader>gc", ":DiffviewClose<CR>", { desc = "Close diffview" })
map("n", "<leader>go", ":Octo pr list<CR>", { desc = "PR list (Octo)" })

-- Telescope
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Buffers" })
map("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>", { desc = "Recent files" })

-- Oil
map("n", "<leader>e", "<cmd>Oil<CR>", { desc = "File explorer" })

-- Sean's Specials
map("n", "<leader>sc", function()
    vim.cmd("edit " .. vim.fn.expand("~/notes/the.md"))
    -- "## " heading on line 1, two blank lines below it
    vim.api.nvim_buf_set_lines(0, 0, 0, false, { "## ", "", "" })
    vim.api.nvim_win_set_cursor(0, { 1, 0 })
    vim.cmd("startinsert!") -- append at end of the "## " line
end, { desc = "Open scratch note, new entry" })

-- LSP (set in lsp on_attach, but useful to see together)
-- gd = go to definition
-- K  = hover docs
-- gr = references
-- <leader>rn = rename
-- <leader>ca = code action
