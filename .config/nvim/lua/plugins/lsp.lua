return {
    -- LSP-Zero Core
  {
    'VonHeikemen/lsp-zero.nvim',
    lazy = false, -- Load immediately to prevent issues
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
    -- Snippets with LuaSnip and friendly-snippets
    {
        "L3MON4D3/LuaSnip",
        dependencies = {
            "rafamadriz/friendly-snippets",
        },
        config = function()
            local luasnip = require("luasnip")
            require("luasnip.loaders.from_vscode").lazy_load()
        end,
    },

    -- LSP Configuration
    {
        "neovim/nvim-lspconfig",
        cmd = { "LspInfo", "LspInstall", "LspStart" },
        event = { "BufReadPre", "BufNewFile" },
        keys = {
            { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code Action" },
            { "<leader>lf", "<cmd>lua vim.lsp.buf.format{async=true}<cr>", desc = "Format" },
            { "<leader>li", "<cmd>LspInfo<cr>", desc = "Info" },
            { "<leader>lI", "<cmd>LspInstallInfo<cr>", desc = "Installer Info" },
            { "<leader>lj", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", desc = "Next Diagnostic" },
            { "<leader>lk", "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>", desc = "Prev Diagnostic" },
            { "<leader>ll", "<cmd>lua vim.lsp.codelens.run()<cr>", desc = "CodeLens Action" },
            { "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<cr>", desc = "Quickfix" },
            { "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "Rename" },
         
        },
    },
}
