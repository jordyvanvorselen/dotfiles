" Plugins
call plug#begin()
  Plug 'tpope/vim-sensible'             " Some sane default settings
  Plug 'tpope/vim-fugitive'             " Git blaming
  Plug 'tpope/vim-endwise'              " Smart code completion for ending of blocks
  Plug 'tpope/vim-commentary'           " Commenting stuff out

  Plug 'sheerun/vim-polyglot'				    " Syntax highlighting and language support for 599+ programming languages
  Plug 'dense-analysis/ale'				      " Automatic linting & fixing
  Plug 'nvim-lua/plenary.nvim'				  " Dependency for fuzzy finding
  Plug 'nvim-telescope/telescope.nvim'	" Fuzzy finder and file searcher
call plug#end()

" Change leader to comma
let mapleader = ","

" Find or search in files using telescope.nvim
nnoremap <C-p> <cmd>Telescope find_files<cr>
nnoremap <C-f> <cmd>Telescope live_grep<cr>

" Configure telescope.nvim
lua << EOF
local actions = require "telescope.actions"

require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      }
    }
  }
}
EOF
