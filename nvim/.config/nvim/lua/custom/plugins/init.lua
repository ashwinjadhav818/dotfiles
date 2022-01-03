local hooks = require "core.hooks"
local override_req = require("core.utils").override_req

hooks.add("install_plugins", function(use)
  -- My plugins
  use "mg979/vim-visual-multi"

  use "github/copilot.vim"

  use "preservim/tagbar"
   
  use "sbdchd/neoformat"
   
  use {
    "prettier/vim-prettier",
    run = "yarn install --frozen-lockfile --production"
  }

  use {
    "iamcco/markdown-preview.nvim",
    ft   = "markdown",
    run = "cd app && yarn install"
  }

  use {
    "folke/which-key.nvim",
    config = override_req("which-key", "custom.plugins.configs.whichkey")
  }

  use {
    "akinsho/toggleterm.nvim",
    config = override_req("toggleterm", "custom.plugins.configs.toggleterm")
  }

  -- Fuzzy Finders
  use {
    "junegunn/fzf",
    run = ":call fzf#install()"
  }

  use "junegunn/fzf.vim"

  -- ColorSchemes
  use "rebelot/kanagawa.nvim"

  use "RRethy/nvim-base16"

  use "rafi/awesome-vim-colorschemes"
end)
