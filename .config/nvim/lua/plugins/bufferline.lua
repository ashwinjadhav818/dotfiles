return {
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      {
        "echasnovski/mini.bufremove",
        version = "*",
        config = function()
          require("mini.bufremove").setup({
            silent = true,
          })
        end,
      },
    },
    config = function()
      local bufferline = require("bufferline")
      bufferline.setup {
        options = {
          close_command = function(n)
            require("mini.bufremove").delete(n, false)
          end,
          right_mouse_command = function(n)
            require("mini.bufremove").delete(n, false)
          end,
          show_buffer_close_icons = false,
          separator_style = { "|", "|" },
          always_show_bufferline = true,
          style_preset = bufferline.style_preset.no_italic,
          numbers = function(opts)
            return string.format("%s", opts.ordinal)
          end,
          custom_filter = function(buf_number)
            -- filter out filetypes you don't want to see
            if vim.bo[buf_number].filetype ~= "qf" then
              return true
            end
          end,
          offsets = {
            {
              filetype = "NvimTree",
              text = "File Explorer",
              highlight = "EcovimNvimTreeTitle",
              text_align = "center",
              separator = true,
            },
          },
        },
      }
    end,
    keys = {
      { "<A-1>",       "<cmd>BufferLineGoToBuffer 1<CR>" },
      { "<A-2>",       "<cmd>BufferLineGoToBuffer 2<CR>" },
      { "<A-3>",       "<cmd>BufferLineGoToBuffer 3<CR>" },
      { "<A-4>",       "<cmd>BufferLineGoToBuffer 4<CR>" },
      { "<A-5>",       "<cmd>BufferLineGoToBuffer 5<CR>" },
      { "<A-6>",       "<cmd>BufferLineGoToBuffer 6<CR>" },
      { "<A-7>",       "<cmd>BufferLineGoToBuffer 7<CR>" },
      { "<A-8>",       "<cmd>BufferLineGoToBuffer 8<CR>" },
      { "<A-9>",       "<cmd>BufferLineGoToBuffer 9<CR>" },
    }
  }
}
