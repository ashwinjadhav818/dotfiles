local hooks = require "core.hooks"

hooks.add("install_plugins", function(use)
  use 'rafi/awesome-vim-colorschemes'
  use 'mg979/vim-visual-multi'
  use {
    'iamcco/markdown-preview.nvim',
    ft   = 'markdown',
    run = 'cd app && yarn install'
  } 
end)
