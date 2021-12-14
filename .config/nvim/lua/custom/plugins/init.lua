local hooks = require "core.hooks"

hooks.add("install_plugins", function(use)
  use 'rafi/awesome-vim-colorschemes'
  use 'mg979/vim-visual-multi'
  use {
    'iamcco/markdown-preview.nvim',
    ft   = 'markdown',
    run = 'cd app && yarn install'
  }
  use {
    'prettier/vim-prettier',
    run = 'yarn install --frozen-lockfile --production',
    branch = 'release/0.x'
  }
end)

