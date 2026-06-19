-- ~/.config/nvim/lua/plugins/editor.lua

return {
    -- File manager (edit filesystem like a buffer)
    {
        "stevearc/oil.nvim",
        config = function()
            local oil = require("oil")

            local function open_preview_with_ratio()
                if oil.get_cursor_entry() then
                    local oil_win = vim.api.nvim_get_current_win()
                    local total_width = vim.o.columns
                    oil.open_preview({ vertical = true, split = "botright" })
                    local target_width = math.max(20, math.floor(total_width * 0.3))
                    vim.api.nvim_win_set_width(oil_win, target_width)
                end
            end

            oil.setup({
                view_options = { show_hidden = true },
                keymaps = {
                    ["<C-p>"] = {
                        callback = open_preview_with_ratio,
                        desc = "Open preview in vertical split (30% selector, 70% preview)",
                    },
                },
            })

            -- Auto-open Yazi-like vertical split preview on entry
            vim.api.nvim_create_autocmd("User", {
                pattern = "OilEnter",
                callback = vim.schedule_wrap(function(args)
                    if vim.api.nvim_get_current_buf() == args.data.buf then
                        open_preview_with_ratio()
                    end
                end),
            })
        end,
    },

    -- Floating terminal
    {
        "akinsho/toggleterm.nvim",
        config = function()
            require("toggleterm").setup({
                open_mapping = [[<C-\>]],
                direction = "float",
                float_opts = { border = "curved" },
            })
        end,
    },

    -- Lualine Status Bar
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("lualine").setup({
                options = {
                    theme = "ayu_dark",
                    component_separators = { left = "", right = "" },
                    section_separators = { left = "", right = "" },
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = { "branch", "diff", "diagnostics" },
                    lualine_c = { "filename" },
                    lualine_x = { "filetype" },
                    lualine_y = { "progress" },
                    lualine_z = { "location" },
                },
            })
        end,
    },

    -- Laravel Blade navigation (gf understands @include, @extends, components)
    {
        "ricardoramirezr/blade-nav.nvim",
        dependencies = "nvim-telescope/telescope.nvim",
        ft = { "blade", "php" },
    },

    -- Nice color theme (optional but pick one)
    {
        "Shatur/neovim-ayu",
        lazy = false,
        priority = 1000,
        config = function()
            require("ayu").setup({
                mirage = false,
            })
            vim.cmd("colorscheme ayu-dark")
        end,
    },

    -- Auto-format Markdown tables as you type
    {
        "dhruvasagar/vim-table-mode",
        -- Load it specifically for Markdown to keep startup times fast
        ft = { "markdown" },
        cmd = { "TableModeToggle", "TableModeEnable" },
        config = function()
            -- Force standard GitHub Flavored Markdown table syntax
            -- (Prevents it from using '+' for corners like +---+---+)
            vim.g.table_mode_corner = "|"
            vim.g.table_mode_corner_corner = "|"
            vim.g.table_mode_header_fillchar = "-"
        end,
        keys = {
            -- A quick mapping to toggle it on or off
            { "<leader>tm", "<cmd>TableModeToggle<CR>", desc = "Toggle Table Mode", ft = "markdown" },
        },
    },
}
