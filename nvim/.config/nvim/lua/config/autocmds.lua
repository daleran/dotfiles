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

-- Scratch note (~/notes/the.md): fold by markdown heading level
function _G.scratch_foldexpr()
    local hashes = vim.fn.getline(vim.v.lnum):match("^(#+)%s")
    if hashes then return ">" .. #hashes end
    return "="
end

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = vim.fn.expand("~/notes/the.md"),
    callback = function()
        vim.opt_local.foldmethod = "expr"
        vim.opt_local.foldexpr = "v:lua.scratch_foldexpr()"
        vim.opt_local.foldlevel = 99 -- start fully open, nothing hidden
    end,
})

-- Auto-reload buffers when files change on disk (e.g. edited by Claude Code).
-- autoread handles the actual reload; we just have to trigger :checktime.

-- Trigger on the usual interaction events (cheap, complements the timer below).
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold" }, {
    pattern = "*",
    command = "checktime",
})

-- Background poll so an idle/unfocused pane still picks up external changes.
-- Terminal focus events are unreliable under zellij, so we don't rely on them.
local reload_timer = vim.uv.new_timer()
reload_timer:start(1000, 1000, vim.schedule_wrap(function()
    -- Skip while typing a command; checktime mid command-line is disruptive.
    if vim.fn.mode() ~= "c" then
        vim.cmd("silent! checktime")
    end
end))

-- Brief notice when a buffer is actually reloaded from disk.
vim.api.nvim_create_autocmd("FileChangedShellPost", {
    pattern = "*",
    callback = function()
        vim.notify("Buffer reloaded (changed on disk)", vim.log.levels.INFO)
    end,
})
