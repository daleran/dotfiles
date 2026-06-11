-- Pretty in-buffer Markdown rendering (headings, lists, code, tables)
return {
    {
        "MeanderingProgrammer/render-markdown.nvim",
        -- Load only for Markdown to keep startup fast
        ft = { "markdown" },
        cmd = { "RenderMarkdown" },
        dependencies = {
            "nvim-treesitter/nvim-treesitter", -- already installed; markdown parsers present
            "nvim-tree/nvim-web-devicons",     -- icons (already pulled in by lualine/bufferline)
        },
        opts = {
            -- Start with raw text + syntax highlighting; toggle render on with <leader>mr
            enabled = false,
            -- Sensible table rendering: full box with rounded corners + padded cells
            pipe_table = {
                preset = "round",  -- ╭─╮ rounded corners
                cell = "padded",   -- pad cells so columns align
            },
        },
        keys = {
            { "<leader>mr", "<cmd>RenderMarkdown toggle<CR>", desc = "Toggle Markdown render", ft = "markdown" },
        },
    },
}
