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
      "catppuccin/nvim",
      name = "catppuccin",
      lazy = false,
      priority = 1000,
      config = function()
         require("plugins.config.catppuccin")
         vim.cmd([[colorscheme catppuccin-mocha]])
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
      config = true,
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
   { "norcalli/nvim-colorizer.lua" },
   { "iamcco/markdown-preview.nvim" },

   -- LSP
   {
      "neovim/nvim-lspconfig",
      config = function()
         require("plugins.config.lsp")
      end,
   },
   { "hrsh7th/cmp-nvim-lsp" },
   {
      "williamboman/mason.nvim",
      config = function()
         require("mason").setup()
         require("mason-lspconfig").setup()
      end,
      build = ":MasonUpdate"              -- :MasonUpdate updates registry contents
   },
   { 'onsails/lspkind-nvim' },            -- vscode-like pictograms
   { 'jose-elias-alvarez/null-ls.nvim' }, -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua
   { 'MunifTanjim/prettier.nvim' },       -- Prettier plugin for Neovim's built-in LSP client
   { 'williamboman/mason-lspconfig.nvim' },
   { 'princejoogie/tailwind-highlight.nvim' },
   {
      'glepnir/lspsaga.nvim',
      config = function()
         require("plugins.config.lspsaga")
      end,
   }, -- LSP UIs
   { 'L3MON4D3/LuaSnip' },
   {
      "mfussenegger/nvim-jdtls",
      config = function()
         require("jdtls").start_or_attach({
            cmd = { 'java' },
            root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw', 'src' }, { upward = true })[1]),
         })
      end
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
      tag = '0.1.1',
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
