-- ~/.config/nvim/lua/config/options.lua

local opt = vim.opt

opt.number = true
opt.relativenumber = true       -- relative line numbers, great for jump motions
opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.scrolloff = 8               -- keep cursor away from screen edges
opt.signcolumn = "yes"          -- always show, stops layout shifting on LSP
opt.wrap = false
opt.splitright = true           -- new vertical splits go right
opt.splitbelow = true           -- new horizontal splits go below
opt.undofile = true             -- persistent undo across sessions
opt.ignorecase = true
opt.smartcase = true            -- case-sensitive only when you use uppercase
opt.termguicolors = true
opt.clipboard = "unnamedplus"   -- use system clipboard
