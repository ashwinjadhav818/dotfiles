return {
  {
    "SmiteshP/nvim-navic",
    event = { "CursorMoved", "BufWinEnter", "BufFilePost" },
    config = function()
      vim.api.nvim_set_hl(0, "NavicText", { link = "Winbar" })
      vim.api.nvim_set_hl(0, "NavicSeparator", { link = "Winbar" })

      require('nvim-navic').setup({
        lsp = {
          auto_attach = true,
          preference = nil,
        },
        highlight = true,
        depth_limit = 0,
        depth_limit_indicator = "..",
        safe_output = true
      })

      require('utils.winbar')
    end,
    dependencies = "neovim/nvim-lspconfig",
  },
}
