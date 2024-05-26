local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "

require("lazy").setup({
    -- Themes
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("plugins.config.tokyonight")
            vim.cmd([[colorscheme tokyonight]])
        end,
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = false,
        priority = 1000,
        config = function()
            require("plugins.config.catppuccin")
            -- vim.cmd([[colorscheme catppuccin-mocha]])
        end,
    },
    {
        "ellisonleao/gruvbox.nvim",
        priority = 1000,
        config = function()
            require("plugins.config.gruvbox")
            -- vim.cmd([[colorscheme gruvbox]])
        end,
    },

    -- UI Elemets
    {
        'goolord/alpha-nvim',
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("plugins.config.alpha")
        end,
    },
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("nvim-tree").setup {}
        end,
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        config = function()
            require("plugins.config.whichkey")
        end,
    },
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        config = function ()
            require("plugins.config.toggleterm")
        end,
        opts = {
            shell = "pwsh.exe"
        }
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("plugins.config.lualine")
        end,
    },
    {
        "akinsho/bufferline.nvim",
        version = "*",
        dependencies = { "nvim-tree/nvim-web-devicons", "famiu/bufdelete.nvim" },
        config = function()
            require("plugins.config.bufferline")
        end
    },
    {
        'nvim-treesitter/nvim-treesitter',
        config = function()
            require("plugins.config.treesitter")
        end,
    },
    {
        "folke/todo-comments.nvim",
        dependencies = "nvim-lua/plenary.nvim",
        lazy = false,
        config = function()
            require("todo-comments").setup {}
        end
    },
    {
        "rcarriga/nvim-notify",
        config = function()
            require("notify").setup({
                enabled = false,
            })
        end
    },
    {
        'rmagatti/goto-preview',
        config = function()
            require('goto-preview').setup {
                width = 120, -- Width of the floating window
                height = 15, -- Height of the floating window
                border = { "↖", "─", "┐", "│", "┘", "─", "└", "│" }, -- Border characters of the floating window
                default_mappings = true,
                debug = false, -- Print debug information
                opacity = 75, -- 0-100 opacity level of the floating window where 100 is fully transparent.
                resizing_mappings = false, -- Binds arrow keys to resizing the floating window.
                post_open_hook = nil, -- A function taking two arguments, a buffer and a window to be ran as a hook.
                references = { -- Configure the telescope UI for slowing the references cycling window.
                    telescope = require("telescope.themes").get_dropdown({ hide_preview = false })
                },
                -- These two configs can also be passed down to the goto-preview definition and implementation calls for one off "peak" functionality.
                focus_on_open = true,                                        -- Focus the floating window when opening it.
                dismiss_on_move = false,                                     -- Dismiss the floating window when moving the cursor.
                force_close = true,                                          -- passed into vim.api.nvim_win_close's second argument. See :h nvim_win_close
                bufhidden = "wipe",                                          -- the bufhidden option to set on the floating window. See :h bufhidden
                stack_floating_preview_windows = true,                       -- Whether to nest floating windows
                preview_window_title = { enable = true, position = "left" }, -- Whether
            }
        end
    },
    {
        "folke/noice.nvim",
        config = function()
            require("noice").setup({
                -- add any options here
                routes = {
                    {
                        filter = {
                            event = 'msg_show',
                            any = {
                                { find = '%d+L, %d+B' },
                                { find = '; after #%d+' },
                                { find = '; before #%d+' },
                                { find = '%d fewer lines' },
                                { find = '%d more lines' },
                            },
                        },
                        opts = { skip = true },
                    }
                },
            })
        end,
        dependencies = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim",
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            "rcarriga/nvim-notify",
        }
    },

    { "norcalli/nvim-colorizer.lua" },
    { "iamcco/markdown-preview.nvim" },
    { "folke/zen-mode.nvim" },

    -- LSP
    {
        "neovim/nvim-lspconfig",
        config = function()
            require("plugins.config.lsp.lsp")
        end,
    },
    { "hrsh7th/cmp-nvim-lsp" },
    {
        "williamboman/mason.nvim",
        config = function()
            require("plugins.config.lsp.mason")
            require("mason-lspconfig").setup()
        end,
        build = ":MasonUpdate"  -- :MasonUpdate updates registry contents
    },
    { 'onsails/lspkind-nvim' }, -- vscode-like pictograms
    -- {
    --     "jose-elias-alvarez/null-ls.nvim",
    --     config = function()
    --         require("plugins.config.lsp.null-ls")
    --     end,
    -- }, -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua
    {
        "MunifTanjim/prettier.nvim",
        config = function()
            require("plugins.config.prettier")
        end,
    }, -- Prettier plugin for Neovim's built-in LSP client
    { 'williamboman/mason-lspconfig.nvim' },
    { 'princejoogie/tailwind-highlight.nvim' },
    {
        'glepnir/lspsaga.nvim',
        config = function()
            require("plugins.config.lsp.lspsaga")
        end,
    }, -- LSP UIs
    { 'L3MON4D3/LuaSnip' },

    {
        "mfussenegger/nvim-jdtls",
        dependencies = { "folke/which-key.nvim" },
    },


    -- Completions
    {
        "hrsh7th/nvim-cmp",
        config = function()
            require("plugins.config.cmp")
        end,
    },                              -- The completion plugin
    { "hrsh7th/cmp-buffer" },       -- buffer completions
    { "hrsh7th/cmp-path" },         -- path completions
    { "saadparwaiz1/cmp_luasnip" }, -- snippet completions
    { "windwp/nvim-ts-autotag" },   -- automatic bracket pairs

    -- Snippets
    { "L3MON4D3/LuaSnip" },             --snippet engine
    { "rafamadriz/friendly-snippets" }, -- a bunch of snippets to use

    -- Cherry on the top
    {
        'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {
        "numToStr/Comment.nvim",
        config = function()
            require("plugins.config.comment")
        end,
    },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("plugins.config.gitsigns")
        end,
    },
    {
        "ahmedkhalf/project.nvim",
        config = function()
            require("plugins.config.project")
        end,
    },
    {
        "mg979/vim-visual-multi",
    }
})
