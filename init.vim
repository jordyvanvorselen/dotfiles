" Plugins
call plug#begin()
  " General
  Plug 'tpope/vim-sensible'               " Some sane default settings
  Plug 'tpope/vim-fugitive'               " Git blaming
  Plug 'tpope/vim-endwise'                " Smart code completion for ending of blocks
  Plug 'tpope/vim-commentary'             " Commenting stuff out
  Plug 'sheerun/vim-polyglot'				      " Syntax highlighting and language support for 599+ programming languages
  Plug 'dense-analysis/ale'				        " Automatic linting & fixing
  Plug 'ConradIrwin/vim-bracketed-paste'  " no more set paste
  Plug 'ervandew/supertab'                " tab completion
  Plug 'ntpeters/vim-better-whitespace'   " no more manually removing whitespace
  Plug 'tpope/vim-surround'               " surroundings
  Plug 'vim-airline/vim-airline'          " airline to see info about file
  Plug 'vim-airline/vim-airline-themes'   " fancy colors

  " Searching
  Plug 'nvim-lua/plenary.nvim'				    " Dependency for fuzzy finding
  Plug 'nvim-telescope/telescope.nvim'	  " Fuzzy finder and file searcher

  " Testing
  Plug 'janko-m/vim-test'                 " run tests with shortcuts
  Plug 'skywind3000/asyncrun.vim'         " run async tests

  " Ruby
  Plug 'keith/rspec.vim'                  " Better highlighting for rspec
  Plug 'tpope/vim-cucumber'               " find steps by [d
  Plug 'tpope/vim-rails'                  " rails helpers
call plug#end()

" Change leader to comma
let mapleader = ","

" backspace over everything in insert mode
set backspace=indent,eol,start

" use tab in normal/visual mode to go to matching brackets:
nnoremap <tab> %
vnoremap <tab> %

" set vim.test strategy
let g:asyncrun_open = 1
let g:asyncrun_mode = "term"
let g:asyncrun_last = 2
let test#strategy = "asyncrun_background_term"
let test#javascript#runner = 'jest'

" ale settings
let g:ale_fixers = {
\   'javascript': ['prettier'],
\   'css': ['prettier'],
\   'scss': ['prettier'],
\   'ruby': ['prettier'],
\}

" auto run black
augroup pythonchecks
  autocmd!
  autocmd BufWritePost *.py !python3 -m black .
  autocmd BufWritePost *.py :e
  autocmd BufWritePost *.py :setf python
augroup END

let g:ale_fix_on_save = 1
let g:ale_lint_on_save = 1

let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_enter = 0

" fix tabs
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab
set smarttab

" other config settings
set number
set t_Co=256
set ignorecase

" Find or search in files using telescope.nvim
nnoremap <C-p> <cmd>lua require('telescope.builtin').git_files({ show_untracked = true })<cr>
nnoremap <C-f> <cmd>lua require('telescope.builtin').live_grep()<cr>

" vim-better-whitespace
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1
let g:strip_whitespace_confirm=0

" vim-test bindings
tnoremap <Leader><Leader> <C-\><C-n>
nnoremap <Leader>ts :TestSuite<CR>
nnoremap <Leader>tf :TestFile<CR>
nnoremap <Leader>tl :TestLast<CR>
nnoremap <Leader>tn :TestNearest<CR>
nnoremap <Leader>tb :TestNearest<CR>

" vim-test settings
let test#ruby#rspec#executable = "docker-compose run --rm -e RAILS_ENV=test $(basename $(pwd)) bin/rspec"
let test#ruby#cucumber#executable = "docker-compose run --rm -e RAILS_ENV=test -e CUCUMBER_FORMAT=pretty $(basename $(pwd)) bin/cucumber"

let test#python#runner = "pytest"
let test#python#pytest#executable = "docker-compose run --rm -e FLASK_ENV=test $(basename $(pwd)) pytest"

" keep selected after indent
vnoremap > >gv
vnoremap < <gv

" splitjoin bindings
nnoremap <Leader>S :SplitjoinSplit<CR>
nnoremap <Leader>J :SplitjoinJoin<CR>

nnoremap <Leader>s :write<CR>
nnoremap <Leader>w :write<CR>
nnoremap <Leader>q :quit<CR>
nnoremap <Leader>ex :Explore<CR>

" shared clipboards, no more pasting using the mouse
set clipboard=unnamed

" edit vimrc easily
nnoremap <Leader>ve :e ~/.config/nvim/init.vim<CR>
nnoremap <Leader>vi :source ~/.config/nvim/init.vim<CR>:PlugInstall<CR>
nnoremap <Leader>vs :source ~/.config/nvim/init.vim<CR>

" disable arrow keys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" make highlighted search result colors more readable
hi Search cterm=NONE ctermfg=grey ctermbg=blue

" disable annoying highlighting when searching
set nohlsearch

" trigger `autoread` when files changes on disk
"set autoread
"autocmd FocusGained,BufEnter,CursorHold,CursorHoldI *
"        \ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif

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
