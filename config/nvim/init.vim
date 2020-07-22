" Install Vim Plug if not installed
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin()

Plug 'scrooloose/nerdtree' "file manager
Plug 'Nopik/vim-nerdtree-direnter' "fix nerdtree behavior
Plug 'Xuyuanp/nerdtree-git-plugin' "nerdtree+git
Plug 'tomtom/tcomment_vim' "commenting support
Plug 'itchyny/lightline.vim' "statusbar
Plug 'tpope/vim-fugitive' "git integration
Plug 'lervag/vimtex' "LaTeX
Plug 'dense-analysis/ale' "Linting
Plug 'junegunn/fzf' "FZF shell stuff
Plug 'junegunn/fzf.vim' "Actual FZF vim plugin
Plug 'neoclide/coc.nvim', {'branch': 'release'} "Autocomplete
Plug 'tpope/vim-unimpaired' "better navigation mapping
Plug 'cespare/vim-toml' "toml support
Plug 'evanleck/vim-svelte', {'branch': 'main'} "svelte

" Theme
" Plug 'dracula/vim', { 'as': 'dracula' } "dracula, duh
" Plug 'wadackel/vim-dogrun'
Plug 'https://gitlab.com/protesilaos/tempus-themes-vim.git'

" Load Last
Plug 'ryanoasis/vim-devicons' "icons
call plug#end()

" Enables cursor similar to gui programs
set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor

" Turn off netrw
let g:netrw_banner = 0
let g:netrw_browse_split = 3

" Setup NERDTree
let NERDTreeShowHidden=1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeCustomOpenArgs={'file':{'where': 't'}}
nnoremap <Leader>F :NERDTreeToggle<CR>
nnoremap <silent> <Leader>v :NERDTreeFind<CR>

set title
set titlestring=%t
set nocursorcolumn
set nocursorline
set lazyredraw " Don't redraw screen as often
set noshowmode " Hide mode indicator
set shortmess=atI " Don’t show the intro message when starting Vim
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

source ~/.config/nvim/lightline.vim "include lightline settings
source ~/.config/nvim/coc.vim "include coc settings
source ~/.config/nvim/fzf.vim "include lightline settings
