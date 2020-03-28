" Install Vim Plug if not installed
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin()

Plug 'scrooloose/nerdtree' "file manager
Plug 'Nopik/vim-nerdtree-direnter' "fix nerdtree behavior
Plug 'tomtom/tcomment_vim' "commenting support
Plug 'itchyny/lightline.vim' "statusbar
Plug 'tpope/vim-fugitive' "git integration
Plug 'lervag/vimtex' "LaTeX
Plug 'dense-analysis/ale' "Linting
Plug 'neoclide/coc.nvim', {'branch': 'release'} "Autocomplete

" Theme
Plug 'dracula/vim', { 'as': 'dracula' } "dracula, duh

" Load Last
Plug 'ryanoasis/vim-devicons' "icons
call plug#end()

" Set colors
colorscheme dracula

" Enable true color for neovim
let $NVIM_TUI_ENABLE_TRUE_COLOR = 0

" Enables cursor similar to gui programs
set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor

" Turn off netrw
let g:netrw_banner = 0
let g:netrw_browse_split = 3

" Setup NERDTree
let NERDTreeMapOpenInTab='<ENTER>'
let NERDTreeShowHidden=1

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
set termguicolors
set listchars=tab:›\ ,eol:¬
set list

let g:tex_flavor = 'latex' "don't want that plaintex

" Setup lightline
let g:lightline = {
  \ 'colorscheme': 'dracula',
  \ 'active': {
  \   'left': [
  \     [ 'mode', 'paste' ],
  \     [ 'ctrlpmark', 'git', 'diagnostic', 'cocstatus', 'filename', 'method' ]
  \   ],
  \   'right':[
  \     [ 'filetype', 'fileencoding', 'lineinfo', 'percent' ],
  \     [ 'blame' ]
  \   ],
  \ },
  \ 'component_function': {
  \   'blame': 'LightlineGitBlame',
  \   'cocstatus': 'coc#status',
  \ }
\ }

autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

function! LightlineGitBlame() abort
  let blame = get(b:, 'coc_git_blame', '')
  " return blame
  return winwidth(0) > 120 ? blame : ''
endfunction

source ~/.config/nvim/coc.vim "include coc settings
