return {
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        dependencies = {
            {
                "williamboman/mason.nvim",
                cmd = "Mason",
                config = function()
                    require("mason").setup()
                end,
            },
            {
                "williamboman/mason-lspconfig.nvim",
                dependencies = { "mason.nvim" },
                config = function()
                    require("mason-lspconfig").setup()
                end,
            },
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            local lspconfig = require("lspconfig")
            lspconfig.ts_ls.setup({
                capabilities = capabilities
            })
            lspconfig.solargraph.setup({
                capabilities = capabilities
            })
            lspconfig.html.setup({
                capabilities = capabilities
            })
            lspconfig.lua_ls.setup({
                capabilities = capabilities
            })

            vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
            vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
            vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
        end,
    },

    {
        "antosha417/nvim-lsp-file-operations",
        event = "LspAttach",
        dependencies = {
            { "nvim-lua/plenary.nvim" },
            { "nvim-tree/nvim-tree.lua" },
        },
        config = function()
            require("lsp-file-operations").setup()
        end,
    },
}
