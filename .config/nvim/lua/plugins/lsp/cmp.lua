return {{
    "hrsh7th/nvim-cmp",
    config = function()
        local status, cmp = pcall(require, "cmp")
        if (not status) then
            return
        end
        local lspkind = require 'lspkind'

        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.close(),
                ['<CR>'] = cmp.mapping.confirm({
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = true
                })
            }),
            sources = cmp.config.sources({{
                name = 'nvim_lsp'
            }, {
                name = 'buffer'
            }}),
            formatting = {
                format = lspkind.cmp_format({
                    with_text = false,
                    maxwidth = 50
                })
            }
        })

        vim.cmd [[
  set completeopt=menuone,noinsert,noselect
  highlight! default link CmpItemKind CmpItemMenuDefault
]]

    end
}, -- The completion plugin
{"hrsh7th/cmp-nvim-lsp"}, -- cmp and lsp 
{"hrsh7th/cmp-buffer"}, -- buffer completions
{"hrsh7th/cmp-path"}, -- path completions
{"saadparwaiz1/cmp_luasnip"}, -- snippet completions
{"windwp/nvim-ts-autotag"} -- automatic bracket pairs
}
