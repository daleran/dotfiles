-- ~/.config/nvim/lua/plugins/treesitter.lua

return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter").setup({
                ensure_installed = {
                    "php", "html", "javascript", "typescript",
                    "css", "sql", "lua", "json", "bash", "vimdoc",
                    "markdown", "markdown_inline"
                },
                highlight = { enable = true },
                indent = { enable = true },
            })
        end,
    },

    {
        "EmranMR/tree-sitter-blade",
        dependencies = "nvim-treesitter/nvim-treesitter",
        ft = "blade",
        config = function()
            local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
            parser_config.blade = {
                install_info = {
                    url = "https://github.com/EmranMR/tree-sitter-blade",
                    files = { "src/parser.c" },
                    branch = "main",
                },
                filetype = "blade",
            }
        end,
    },
}
