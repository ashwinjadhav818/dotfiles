" ---- Basic Config ----
set number
set relativenumber
set autoindent
set tabstop=4
set shiftwidth=4
set smarttab
set softtabstop=4
set mouse=a
set cursorline
set swapfile
set dir=~/tmp
set wildignore="node_modules, .git"
" ---- Basic Config End ----

" ---- Plugins ----
call plug#begin()

Plug 'https://github.com/preservim/nerdtree' " NERDTree a file manager
Plug 'https://github.com/kyazdani42/nvim-tree.lua'
Plug 'https://github.com/kyazdani42/nvim-web-devicons' " for file icons
Plug 'https://github.com/tpope/vim-commentary' " For commenting gcc & gc
Plug 'https://github.com/vim-airline/vim-airline' " Status bar
Plug 'https://github.com/ap/vim-css-color' " CSS color preview
Plug 'https://github.com/rafi/awesome-vim-colorschemes' " Retro color schemes
Plug 'https://github.com/neoclide/coc.nvim'  " Visual Studio Code like auto completes
Plug 'https://github.com/ryanoasis/vim-devicons' " Developer icons for NERDTree
Plug 'https://github.com/preservim/tagbar' " Tagbar for code navigation
Plug 'https://github.com/terryma/vim-multiple-cursors' " CTRL + N for multiple cursors
Plug 'https://github.com/nvim-telescope/telescope.nvim' " Telescope a fuzzy file finder
Plug 'https://github.com/nvim-lua/plenary.nvim' " Lua plugin needed for Telescope
Plug 'https://github.com/HerringtonDarkholme/yats.vim' " TypeScript syntax
Plug 'https://github.com/Xuyuanp/nerdtree-git-plugin' " Git status to NERDTree
Plug 'https://github.com/tiagofumo/vim-nerdtree-syntax-highlight' " Colors for the icons in NERDTree
Plug 'https://github.com/airblade/vim-gitgutter' " Git gutter

set encoding=UTF-8

call plug#end()
" ---- Plugins End ----

" ---- Custom Keybord Shortcuts ----
nnoremap <C-b> :NERDTree<CR>
nnoremap <C-e> :NERDTreeToggle<CR>
nnoremap <C-l> :call CocActionAsync('jumpDefinition')<CR>
nnoremap <C-p> :Telescope file_browser<CR>
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>

nmap <C-t> :TagbarToggle<CR>
nmap <C-w> :w<CR>
nmap <C-q> :q<CR>
nmap <silent> s :<C-u>split<CR>
nmap <silent> t :<C-u>terminal<CR>
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

inoremap jj <esc>
" ---- Custom Keybord Shortcuts End ----

" ---- Theme Config ----
if exists("&termguicolors") && exists("&winblend")
  syntax enable
  set termguicolors
  set winblend=0
  set wildoptions=pum
  set pumblend=5
  set background=dark

  let g:neosolarized_termtrans=1

  " colorscheme OceanicNext
  " colorscheme challenger_deep
  " colorscheme NeoSolarized
  colorscheme gruvbox
endif
" ---- Theme End ----

" ---- NERDTree Config ----
let g:NERDTreeIgnore = ['^node_modules$', '^.git$']
" ---- NERDTree Config End ----

" ---- Air Line Config ----
let g:airline_powerline_fonts = 1
" ---- Air Line Config End ----

" ---- COC Config ----
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-tsserver',
  \ 'coc-eslint', 
  \ 'coc-prettier', 
  \ 'coc-json', 
  \ ]
" ---- COC Config End ----

" ---- Prettier Config ----
"let g:prettier#quickfix_enabled = 0
"let g:prettier#quickfix_auto_focus = 0
" prettier command for coc
command! -nargs=0 Prettier :CocCommand prettier.formatFile
" run prettier on save
"let g:prettier#autoformat = 0
"autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync
" ---- Prettier Config End ----
