" Install Vim Plug if not installed
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin()

Plug 'scrooloose/nerdtree'
Plug 'Nopik/vim-nerdtree-direnter'

Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'tomtom/tcomment_vim'
Plug 'whatyouhide/vim-lengthmatters'

Plug 'itchyny/lightline.vim'

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

Plug 'dbakker/vim-projectroot'
Plug 'mileszs/ack.vim'
Plug 'kburdett/vim-nuuid'

Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}

Plug 'sheerun/vim-polyglot'

Plug 'RRethy/vim-hexokinase'

" Theme
Plug 'dracula/vim', { 'as': 'dracula' }

" Load Last
Plug 'ryanoasis/vim-devicons'
call plug#end()

" Set colors
colorscheme dracula

" Enable true color for neovim
let $NVIM_TUI_ENABLE_TRUE_COLOR = 0

" Enables cursor similar to gui programs
let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1

" Change window title to filename
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
set encoding=utf8

" More natural splits
set splitbelow          " Horizontal split below current.
set splitright          " Vertical split to right of current.

if !&scrolloff
set scrolloff=3       " Show next 3 lines while scrolling.
endif
if !&sidescrolloff
set sidescrolloff=5   " Show next 5 columns while side-scrolling.
endif
set nostartofline       " Do not jump to first character with page commands.

" Turn off netrw
let g:netrw_banner = 0
let g:netrw_browse_split = 3

" note that you must keep `noinsert` in completeopt, you must not use
" `longest`. The others are optional. Read `:help completeopt` for
" more info
set completeopt=noinsert,menuone,noselect

" suppress the annoying 'match x of y', 'The only match' and 'Pattern not
" found' messages
set shortmess+=c

" manage filetypes
augroup filetype_jsx
  autocmd!
  au BufNewFile,BufRead *.jsx set filetype=javascript.jsx
augroup END

augroup filetype_js
  autocmd!
  autocmd BufReadPost *.js setlocal filetype=javascript
augroup END

autocmd bufreadpre *.tex setlocal textwidth=80
autocmd bufreadpre *.md setlocal textwidth=80 spell spelllang=en_us
autocmd FileType gitcommit spell spelllang=en_us

" Commands
let mapleader="\<SPACE>"

" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
endif

" CTRL-C doesn't trigger the InsertLeave autocmd . map to <ESC> instead.
inoremap <c-c> <ESC>

" Use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Search and Replace
nmap <Leader>s :%s//<Left>

nmap <Leader>t :GFiles<CR>
nmap <Leader>r :BTags<CR>
nmap <Leader>/ :TComment<CR>

" setup AG for search
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" Setup NERDTree
let NERDTreeMapOpenInTab='<ENTER>'

" Setup lightline
let g:lightline = {
      \ 'colorscheme': 'Dracula',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified', 'cocstatus' ] ],
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head',
      \   'cocstatus': 'coc#status'
      \ },
      \ }

" Setup Hexokinase
let g:Hexokinase_ftAutoload = ['css', 'xml']

set termguicolors
