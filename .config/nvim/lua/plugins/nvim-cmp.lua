return {
    -- Autocompletion with nvim-cmp
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            { "L3MON4D3/LuaSnip" },
            { "hrsh7th/cmp-nvim-lsp" },
        },
        config = function()
            local success, lsp_zero = pcall(require, "lsp-zero")
            if not success then return end

            lsp_zero.extend_cmp()

            local cmp_success, cmp = pcall(require, "cmp")
            if not cmp_success then return end

            local cmp_action = lsp_zero.cmp_action()
            local luasnip_success, luasnip = pcall(require, "luasnip")
            if luasnip_success then
                require("luasnip.loaders.from_vscode").lazy_load()
            end

            cmp.setup({
                formatting = lsp_zero.cmp_format({ details = true }),
                sources = {
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                },
                mapping = cmp.mapping.preset.insert({
                    ["<CR>"] = cmp.mapping.confirm({ select = false }),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-d>"] = cmp.mapping.scroll_docs(4),
                    ["<C-f>"] = cmp_action.luasnip_jump_forward(),
                    ["<C-b>"] = cmp_action.luasnip_jump_backward(),
                }),
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
            })
        end,
    },

}
