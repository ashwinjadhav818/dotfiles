return {
  {
    "Wansmer/treesj",
    lazy = true,
    cmd = { "TSJToggle", "TSJSplit", "TSJJoin" },
    keys = { { "<space>j", "<cmd>TSJToggle<CR>", desc = "Toggle Split/Join" } },
    opts = {
      use_default_keymaps = false
    },
  },
}
