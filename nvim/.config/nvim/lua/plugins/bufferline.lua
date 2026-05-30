-- ~/.config/nvim/lua/plugins/bufferline.lua

return {
    {
        "akinsho/bufferline.nvim",
        version = "*",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        event = "VeryLazy",
        config = function()
            require("bufferline").setup({
                options = {
                    mode = "buffers",
                    style_preset = require("bufferline").style_preset.default,
                    themable = true,
                    numbers = "none",
                    close_command = "bdelete! %d",
                    right_mouse_command = "bdelete! %d",
                    left_mouse_command = "buffer %d",
                    indicator = {
                        style = "icon",
                        icon = "▎",
                    },
                    buffer_close_icon = "󰅖",
                    modified_icon = "●",
                    close_icon = "",
                    left_truncated_indicator = "󰅁",
                    right_truncated_indicator = "󰅂",
                    max_name_length = 18,
                    max_prefix_length = 15,
                    truncate_name = true,
                    tab_size = 18,
                    diagnostics = "nvim_lsp",
                    diagnostics_update_in_insert = false,
                    color_icons = true,
                    show_buffer_icons = true,
                    show_buffer_close_icons = true,
                    show_close_icon = true,
                    show_tab_indicators = true,
                    show_duplicate_prefix = true,
                    persist_buffer_sort = true,
                    move_wraps_at_ends = false,
                    separator_style = "thin",
                    always_show_bufferline = true,
                    hover = {
                        enabled = true,
                        delay = 200,
                        reveal = { "close" },
                    },
                },
            })

            -- BufferLine keymaps
            local map = vim.keymap.set
            map("n", "<leader>bp", "<cmd>BufferLinePick<CR>", { desc = "Buffer pick" })
            map("n", "<leader>bc", "<cmd>BufferLinePickClose<CR>", { desc = "Buffer pick close" })
            map("n", "<leader>bo", "<cmd>BufferLineCloseOthers<CR>", { desc = "Close all other buffers" })
            map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Close current buffer" })
        end,
    },
}
