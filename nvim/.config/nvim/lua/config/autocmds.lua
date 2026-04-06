-- ~/.config/nvim/lua/config/autocmds.lua

-- Highlight yanked text briefly
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function() vim.highlight.on_yank() end,
})

-- Blade files — tell Neovim to treat them as HTML for fallback
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = "*.blade.php",
    callback = function()
        vim.bo.filetype = "blade"
    end,
})

-- Load database connections from external file (not committed)
local ok, dbs = pcall(require, "config.db_local")
if ok then vim.g.dbs = dbs end

-- Markdown specific settings
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "markdown", "md" },
    callback = function()
        -- Enable soft wrapping (visual only)
        vim.opt_local.wrap = true
        vim.opt_local.linebreak = true -- wrap at words, not middle of words

        -- UNCOMMENT BELOW FOR HARD WRAPPING (auto-inserts newlines)
        -- vim.opt_local.textwidth = 80
        -- vim.opt_local.formatoptions:append("t")
    end,
})
