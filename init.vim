" Plugins
call plug#begin()
  " General
  Plug 'tpope/vim-sensible'               " Some sane default settings
  Plug 'tpope/vim-fugitive'               " Git blaming
  Plug 'tpope/vim-commentary'             " Commenting stuff out
  Plug 'dense-analysis/ale'				        " Automatic linting & fixing
  Plug 'ConradIrwin/vim-bracketed-paste'  " no more set paste
  Plug 'ntpeters/vim-better-whitespace'   " no more manually removing whitespace
  Plug 'tpope/vim-surround'               " surroundings
  Plug 'vim-airline/vim-airline'          " airline to see info about file
  Plug 'vim-airline/vim-airline-themes'   " fancy colors

  " Copilot
  Plug 'https://github.com/github/copilot.vim'

  " Theme
  Plug 'ray-x/starry.nvim'

  " Highlighting
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'neovim/nvim-lspconfig'

  " Autocompletion
  Plug 'neoclide/coc.nvim', {'branch': 'release'}

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

  " Go
  Plug 'ray-x/go.nvim'
  Plug 'ray-x/guihua.lua'

call plug#end()

" Change leader to comma
let mapleader = ","

" Disable the mouse
set mouse=

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

function! FormatTempl(buffer) abort
    return {
    \   'command': 'templ fmt'
    \}
endfunction

execute ale#fix#registry#Add('templfmt', 'FormatTempl', ['templ'], 'Templ fmt for templ')

" ale settings
let g:ale_fixers = {
\   'javascript': ['prettier'],
\   'css': ['prettier'],
\   'scss': ['prettier'],
\   'ruby': ['prettier'],
\   'python': ['black', 'isort'],
\   'templ': ['templfmt'],
\}

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

" use ctrl + j and ctrl + k to navigate through coc completion menu
inoremap <silent><expr> <C-j> coc#pum#visible() ? coc#pum#next(1) : CheckBackspace() ? "\<C-j>" : coc#refresh()
inoremap <expr><C-k> coc#pum#visible() ? coc#pum#prev(1) : "\<C-k>"

" use enter to select current selected completion
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" go to code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nnoremap <silent> <Space> :call CocActionAsync('doHover')<CR>

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
hi NormalFloat ctermfg=LightGrey

" disable annoying highlighting when searching
set nohlsearch

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

require('nvim-treesitter.configs').setup {
    endwise = {
        enable = true,
    },
    -- A list of parser names, or "all" (the five listed parsers should always be installed)
    ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "go" },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = true,

    -- List of parsers to ignore installing (or "all")
    ignore_install = { },

    ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
    -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

    highlight = {
      enable = true,

      -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
      -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
      -- the name of the parser)
      -- list of language that will be disabled
      disable = { },

      -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
      -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
      -- Using this option may slow down your editor, and you may see some duplicate highlights.
      -- Instead of true it can also be a list of languages
      additional_vim_regex_highlighting = false,
    },
}

local lspconfig = require("lspconfig")

local servers = { 'gopls', 'templ' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })
end

vim.filetype.add({ extension = { templ = "templ" } })

require('starry').setup()
require('starry.functions').change_style("moonlight")
vim.cmd("highlight Normal guibg=NONE ctermbg=NONE")

require('go').setup()
require("go.format").goimport()

local format_sync_grp = vim.api.nvim_create_augroup("GoImport", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
   require('go.format').goimport()
  end,
  group = format_sync_grp,
})

EOF
