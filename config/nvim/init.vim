" Install Vim Plug if not installed
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin()

" Navigation & Presentation
"Plug 'scrooloose/nerdtree' "file manager
"Plug 'Nopik/vim-nerdtree-direnter' "fix nerdtree behavior
"Plug 'Xuyuanp/nerdtree-git-plugin' "nerdtree+git
"Plug 'itchyny/lightline.vim' "statusbar

" Utils
Plug 'tpope/vim-unimpaired' "better navigation mapping
Plug 'tomtom/tcomment_vim' "commenting support
Plug 'tpope/vim-fugitive' "git integration
Plug 'tpope/vim-sensible' "sensible defaults

" Language Support
Plug 'lervag/vimtex' "LaTeX
Plug 'cespare/vim-toml' "toml support
Plug 'evanleck/vim-svelte', {'branch': 'main'} "svelte

" Code completion & Linting
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
"Plug 'dense-analysis/ale' "Linting
"Plug 'neoclide/coc.nvim', {'branch': 'release'} "Autocomplete
"
" Fuzzy finding
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
"Plug 'junegunn/fzf' "FZF shell stuff
"Plug 'junegunn/fzf.vim' "Actual FZF vim plugin
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" File explorer
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'

" Status line
Plug 'glepnir/galaxyline.nvim'

" Theme
" Plug 'dracula/vim', { 'as': 'dracula' } "dracula, duh
" Plug 'wadackel/vim-dogrun'
Plug 'https://gitlab.com/protesilaos/tempus-themes-vim.git'

" Load Last
" Plug 'ryanoasis/vim-devicons' "icons
call plug#end()

" Automatically install missing plugins on startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif

" Enables cursor similar to gui programs
set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor

" Turn off netrw
"let g:netrw_banner = 0
"let g:netrw_browse_split = 3

" Setup NERDTree
"let NERDTreeShowHidden=1
"let NERDTreeMinimalUI = 1
"let NERDTreeDirArrows = 1
"let NERDTreeCustomOpenArgs={'file':{'where': 't'}}
"nnoremap <Leader>F :NERDTreeToggle<CR>
"nnoremap <silent> <Leader>v :NERDTreeFind<CR>

let g:nvim_tree_gitignore = 1 "0 by default
let g:nvim_tree_auto_open = 1 "0 by default, opens the tree when typing `vim $DIR` or `vim`
let g:nvim_tree_auto_close = 1 "0 by default, closes the tree when it's the last window

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c

set title
set titlestring=%t
set nocursorcolumn
set nocursorline
set lazyredraw " Don't redraw screen as often
set noshowmode " Hide mode indicator
"set shortmess=atI " Don’t show the intro message when starting Vim
set backspace=indent,eol,start " Backspace over anything
set laststatus=2        " Always show statusline
set noswapfile          " No swapfiles
set ignorecase          " Make searching case insensitive
set smartcase           " ... unless the query has capital letters.
set gdefault            " Use 'g' flag by default with :s/foo/bar/.
set magic               " Use 'magic' patterns (extended regular expressions).
set shell=/bin/bash     " default shell
set showmatch           " Show matching brackets.
set noruler             " Hide ruler
set number              " Show the line numbers on the left side.
set formatoptions+=o    " Continue comment marker in new lines.
set textwidth=0         " Hard-wrap long lines as you type them.
set expandtab           " Insert spaces when TAB is pressed.
set tabstop=2           " Render TABs using this many spaces.
set shiftwidth=2        " Indentation amount for < and > commands.
set hidden              " Required for operations modifying multiple buffers like rename.
set linespace=0         " Set line-spacing to minimum.
set nojoinspaces        " Prevents inserting two spaces after punctuation on a join (J)
set encoding=UTF-8
set listchars=tab:›\ ,eol:¬
set list
set switchbuf+=usetab,newtab
set virtualedit=block

" deal with truecolor
if exists('+termguicolors')
  set termguicolors
else
  set t_Co=256
  set notermguicolors
endif

" Set colors
set background=dark
syntax enable
colorscheme tempus_winter

let g:tex_flavor = 'latex' "don't want that plaintex

" svelte stuff
let g:svelte_preprocessors = ['typescript']

let g:completion_enable_snippet = 'UltiSnips'

augroup highlight_yank
  autocmd!
  autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()
augroup END

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fl <cmd>Telescope git_files<cr>

nnoremap <leader>tt :NvimTreeToggle<CR>
nnoremap <leader>tr :NvimTreeRefresh<CR>
nnoremap <leader>tn :NvimTreeFindFile<CR>

augroup NvimTreeConfig
  au!
  au BufEnter * if isdirectory(expand('%')) | exec("cd " . expand('%')) | exec('NvimTreeOpen') | endif
augroup END

lua << EOF
  require'nvim-tree.events'.on_nvim_tree_ready(function ()
    vim.cmd("NvimTreeRefresh")
  end)
EOF

" galaxyline
luafile ~/.config/nvim/eviline.lua

lua << EOF
require'lspconfig'.rust_analyzer.setup{on_attach=require'completion'.on_attach}
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
    },
  indent = {
    enable = true,
    },
  }
EOF


"source ~/.config/nvim/lightline.vim "include lightline settings
"source ~/.config/nvim/coc.vim "include coc settings
"source ~/.config/nvim/fzf.vim "include lightline settings
