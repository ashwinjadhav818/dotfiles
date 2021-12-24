local hooks = require "core.hooks"

hooks.add("install_plugins", function(use)
  use "rafi/awesome-vim-colorschemes"
  use "mg979/vim-visual-multi"
  use {
    "iamcco/markdown-preview.nvim",
    ft   = "markdown",
    run = "cd app && yarn install"
  }
  use {
    "prettier/vim-prettier",
    run = "yarn install --frozen-lockfile --production",
    branch = "release/0.x"
  }
  use "overcache/NeoSolarized"
  use "folke/lsp-colors.nvim"
  use {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup {
        require("custom.plugins.configs.whichkey")
      }
    end
  }
  use {
    "akinsho/toggleterm.nvim",
    config = function()
      require("toggleterm").setup {
        require("custom.plugins.configs.toggleterm")
      }
    end
  }

end)

