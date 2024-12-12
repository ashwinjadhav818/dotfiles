return {
  -- LSP-Zero Core
  {
    'VonHeikemen/lsp-zero.nvim',
    lazy = false, -- Load immediately to prevent issues
    config = false,
    init = function()
      -- Disable automatic setup; we are configuring manually
      vim.g.lsp_zero_extend_cmp = 0
      vim.g.lsp_zero_extend_lspconfig = 0
    end,
  },

  -- Snippets with LuaSnip and friendly-snippets
  {
    'L3MON4D3/LuaSnip',
    dependencies = {
      'saadparwaiz1/cmp_luasnip',
      'rafamadriz/friendly-snippets',
    },
    config = function()
      local luasnip = require("luasnip")
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },

  -- Autocompletion with nvim-cmp
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      {'L3MON4D3/LuaSnip'},
      {'hrsh7th/cmp-nvim-lsp'},
    },
    config = function()
      local success, lsp_zero = pcall(require, 'lsp-zero')
      if not success then return end

      lsp_zero.extend_cmp()

      local cmp_success, cmp = pcall(require, 'cmp')
      if not cmp_success then return end

      local cmp_action = lsp_zero.cmp_action()
      local luasnip_success, luasnip = pcall(require, "luasnip")
      if luasnip_success then
        require("luasnip.loaders.from_vscode").lazy_load()
      end

      cmp.setup({
        formatting = lsp_zero.cmp_format({details = true}),
        sources = {
          {name = 'nvim_lsp'},
          {name = 'luasnip'},
        },
        mapping = cmp.mapping.preset.insert({
          ['<CR>'] = cmp.mapping.confirm({select = false}),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
          ['<C-f>'] = cmp_action.luasnip_jump_forward(),
          ['<C-b>'] = cmp_action.luasnip_jump_backward(),
        }),
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
      })
    end,
  },

  -- LSP Configuration
  {
    'neovim/nvim-lspconfig',
    cmd = {'LspInfo', 'LspInstall', 'LspStart'},
    event = {'BufReadPre', 'BufNewFile'},
    dependencies = {
      {'hrsh7th/cmp-nvim-lsp'},
      {'williamboman/mason-lspconfig.nvim'},
    },
    config = function()
      local success, lsp_zero = pcall(require, 'lsp-zero')
      if not success then return end

      lsp_zero.extend_lspconfig()

      lsp_zero.on_attach(function(client, bufnr)
        lsp_zero.default_keymaps({buffer = bufnr})
      end)

      local mason_lspconfig_success, mason_lspconfig = pcall(require, 'mason-lspconfig')
      if not mason_lspconfig_success then return end

      mason_lspconfig.setup({
        ensure_installed = {'lua_ls'}, -- Add more servers as needed
        handlers = {
          -- Default handler for all servers
          function(server_name)
            require('lspconfig')[server_name].setup({})
          end,
          -- Custom handler for Lua
          lua_ls = function()
            local lua_opts = lsp_zero.nvim_lua_ls()
            require('lspconfig').lua_ls.setup(lua_opts)
          end,
        },
      })
    end,
  },
}
