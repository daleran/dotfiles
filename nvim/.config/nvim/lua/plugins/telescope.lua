-- ~/.config/nvim/lua/plugins/telescope.lua
return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
            },
        },
        config = function()
            local telescope = require("telescope")
            telescope.setup({
                defaults = {
                    layout_strategy = "vertical",
                    layout_config = {
                        vertical = {
                            width = { padding = 0 },
                            height = { padding = 0 },
                            preview_height = 0.5,
                            prompt_position = "bottom",
                        },
                    },
                    sorting_strategy = "descending",
                    file_ignore_patterns = { "^.git/", "node_modules", "vendor", "storage/logs" },
                    vimgrep_arguments = {
                        "rg",
                        "--color=never",
                        "--no-heading",
                        "--with-filename",
                        "--line-number",
                        "--column",
                        "--smart-case",
                        "--hidden",
                        "--no-ignore",
                    },
                },
                pickers = {
                    find_files = {
                        hidden = true,
                        no_ignore = true,
                        find_command = { "fd", "--type", "f", "--hidden", "--no-ignore", "--exclude", ".git" },
                    },
                    live_grep = {
                        additional_args = { "--hidden", "--no-ignore" },
                    },
                },
            })
            telescope.load_extension("fzf")
        end,
    },
}
