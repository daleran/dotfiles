-- ~/.config/nvim/lua/plugins/lsp.lua

return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },

    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim" },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "intelephense",
                    "ts_ls",
                    "cssls",
                    "html",
                    "jsonls",
                    "tailwindcss",
                    "emmet_ls",
                    "lua_ls",
                    "sqlls",
                    "marksman",
                },
            })
        end,
    },

    -- Keep lspconfig as a dependency for server definitions,
    -- but configure servers with the new native API
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            -- Keymaps on LSP attach
            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local opts = { buffer = args.buf }
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
                    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
                    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
                end,
            })

            -- Server configs using new 0.11 API
            vim.lsp.config("intelephense", {
                capabilities = capabilities,
                settings = {
                    intelephense = {
                        stubs = {
                            "apache", "bcmath", "Core", "curl", "date", "dom",
                            "fileinfo", "filter", "gd", "hash", "iconv", "json",
                            "mbstring", "mysqli", "openssl", "pcre", "PDO",
                            "pdo_mysql", "pdo_pgsql", "pgsql", "Phar", "posix",
                            "random", "readline", "Reflection", "session", "SimpleXML",
                            "sodium", "SPL", "sqlite3", "standard", "tokenizer",
                            "xml", "xmlreader", "xmlwriter", "zip", "zlib", "phpunit",
                        },
                    },
                },
            })

            vim.lsp.config("emmet_ls", {
                capabilities = capabilities,
                filetypes = {
                    "html", "blade", "css", "scss", "javascript",
                    "javascriptreact", "typescriptreact",
                },
            })

            vim.lsp.config("ts_ls", { capabilities = capabilities })
            vim.lsp.config("cssls", { capabilities = capabilities })
            vim.lsp.config("html", { capabilities = capabilities })
            vim.lsp.config("jsonls", { capabilities = capabilities })
            vim.lsp.config("tailwindcss", { capabilities = capabilities })
            vim.lsp.config("lua_ls", { capabilities = capabilities })
            vim.lsp.config("sqlls", { capabilities = capabilities })
            vim.lsp.config("marksman", { capabilities = capabilities })

            -- Enable all configured servers
            vim.lsp.enable({ "intelephense", "ts_ls", "cssls", "html", "jsonls", "tailwindcss", "emmet_ls", "lua_ls",
                "sqlls", "marksman", })
        end,
    },

    -- Autocompletion (unchanged)
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            cmp.setup({
                snippet = {
                    expand = function(args) luasnip.lsp_expand(args.body) end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<CR>"]      = cmp.mapping.confirm({ select = true }),
                    ["<Tab>"]     = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "buffer" },
                    { name = "path" },
                }),
            })
        end,
    },

    -- Formatting (unchanged)
    {
        "stevearc/conform.nvim",
        config = function()
            require("conform").setup({
                formatters_by_ft = {
                    php        = { "pint" },
                    blade      = { "blade-formatter" },
                    javascript = { "prettier" },
                    typescript = { "prettier" },
                    css        = { "prettier" },
                    json       = { "prettier" },
                    markdown   = { "prettier" },
                },
                format_on_save = {
                    timeout_ms = 2000,
                    lsp_fallback = true,
                },
                formatters = {
                    pint = {
                        command = vim.fn.expand("~/.config/composer/vendor/bin/pint"),
                    },
                },
            })
        end,
    },
}
