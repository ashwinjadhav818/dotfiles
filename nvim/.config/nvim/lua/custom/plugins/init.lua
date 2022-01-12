local hooks = require "core.hooks"
local override_req = require("core.utils").override_req

hooks.add("install_plugins", function(use)
  -- My plugins
  use "mg979/vim-visual-multi"

  use "github/copilot.vim"

  use "preservim/tagbar"
   
  use "sbdchd/neoformat"
   
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

  -- LSP plugins
  use {
    "williamboman/nvim-lsp-installer",
    config = function()
       local lsp_installer = require "nvim-lsp-installer"

       lsp_installer.on_server_ready(function(server)
          local opts = {}

          server:setup(opts)
          vim.cmd [[ do User LspAttachBuffers ]]
       end)
    end,
   }

  -- Fuzzy Finders
  use {
    "nvim-telescope/telescope-media-files.nvim",
    after = "telescope.nvim",
    config = function()
      require("telescope").setup {
        extensions = {
          media_files = {
            filetypes = { "png", "webp", "jpg", "jpeg" },
            find_cmd = "rg", -- find command (defaults to `fd`)
          },
        },
      }
      require("telescope").load_extension "media_files"
    end,
   }

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
