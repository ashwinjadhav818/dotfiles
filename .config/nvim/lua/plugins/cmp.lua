return {
    {
        "hrsh7th/nvim-cmp",
        config = function()
            local status, cmp = pcall(require, "cmp")
            if (not status) then
                return
            end
            local lspkind = require 'lspkind'

            cmp.setup({
                snippet = {
                    -- REQUIRED - you must specify a snippet engine
                    expand = function(args)
                        -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
                        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
                        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
                        -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
                    end,
                },
                window = {
                    -- completion = cmp.config.window.bordered(),
                    -- documentation = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    -- { name = 'luasnip' }, -- For luasnip users.
                    -- { name = 'ultisnips' }, -- For ultisnips users.
                    -- { name = 'snippy' }, -- For snippy users.
                }, {
                    { name = 'buffer' },
                }),
                formatting = {
                    format = lspkind.cmp_format({
                        mode = 'symbol', -- show only symbol annotations
                        maxwidth = 50,   -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                        -- can also be a function to dynamically calculate max width such as
                        -- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
                        ellipsis_char = '...',    -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
                        show_labelDetails = true, -- show labelDetails in menu. Disabled by default

                        -- The function below will be called before any actual modifications from lspkind
                        -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
                        before = function(entry, vim_item)
                            return vim_item
                        end
                    })
                }
            })

            -- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
            -- Set configuration for specific filetype.
            --[[ cmp.setup.filetype('gitcommit', {
               sources = cmp.config.sources({
                 { name = 'git' },
               }, {
                 { name = 'buffer' },
               })
            })
            require("cmp_git").setup() ]] --

            -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline({ '/', '?' }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = 'buffer' }
                }
            })


            -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'path' }
                }, {
                    { name = 'cmdline' }
                }),
                matching = { disallow_symbol_nonprefix_matching = false }
            })
            vim.cmd [[
                set completeopt=menuone,noinsert,noselect
                highlight! default link CmpItemKind CmpItemMenuDefault
            ]]
        end
    },                              -- The completion plugin
    { "hrsh7th/cmp-nvim-lsp" },     -- cmp and lsp
    { "hrsh7th/cmp-buffer" },       -- buffer completions
    { "hrsh7th/cmp-path" },         -- path completions
    { "saadparwaiz1/cmp_luasnip" }, -- snippet completions
    { "windwp/nvim-ts-autotag" },   -- automatic bracket pairs
    {
        "onsails/diaglist.nvim",
        config = function()
            require("diaglist").init({
                -- optional settings
                -- below are defaults
                debug = false,

                -- increase for noisy servers
                debounce_ms = 150,
            })

            vim.cmd [[nmap <space>dw <cmd>lua require('diaglist').open_all_diagnostics()<cr>]]
            vim.cmd [[nmap <space>d0 <cmd>lua require('diaglist').open_buffer_diagnostics()<cr>]]
        end
    }, -- quickfix and localist dialogs
}
