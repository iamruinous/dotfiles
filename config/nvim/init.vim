" Install Vim Plug if not installed
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin()

Plug 'scrooloose/nerdtree'
Plug 'Nopik/vim-nerdtree-direnter'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tomtom/tcomment_vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-gitgutter'
Plug 'ncm2/ncm2'
Plug 'ncm2/ncm2-bufword'
Plug 'roxma/nvim-yarp'
Plug 'Yggdroot/indentLine'
Plug 'dbakker/vim-projectroot'
Plug 'mileszs/ack.vim'
Plug 'kburdett/vim-nuuid'
Plug 'stephpy/vim-yaml'
Plug 'sheerun/vim-polyglot'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'w0rp/ale'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }


" Theme
Plug 'dracula/vim', { 'as': 'dracula' }

" Load Last
Plug 'ryanoasis/vim-devicons'
call plug#end()

colorscheme dracula
let g:airline#extensions#tabline#enabled = 1

let g:ale_linters = {
\   'go': ['gofmt', 'gometalinter'],
\   'rust': ['rls'],
\}
let g:ale_fixers = {
\   'javascript': ['eslint'],
\   'json': ['prettier'],
\   'go': ['gofmt'],
\   'rust': ['rustfmt'],
\}
let g:ale_lint_on_enter = 1
let g:ale_lint_on_text_changed = 'normal'
let g:ale_fix_on_save = 1
let g:ale_go_gometalinter_options = '--disable-all --enable=golint --enable=goimports --enable=vet --enable=vetshadow --enable=gotype --enable=deadcode --enable=errcheck --enable=ineffassign --enable=interfacer --enable=test --enable=megacheck'

nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

let mapleader="\<SPACE>"
set ignorecase          " Make searching case insensitive
set smartcase           " ... unless the query has capital letters.
set gdefault            " Use 'g' flag by default with :s/foo/bar/.
set magic               " Use 'magic' patterns (extended regular expressions).

" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
endif

" Search and Replace
nmap <Leader>s :%s//<Left>

nmap <Leader>t :GFiles<CR>
nmap <Leader>r :BTags<CR>
nmap <Leader>/ :TComment<CR>
nmap <Leader>T :GoCoverageToggle<CR>

set showmatch           " Show matching brackets.
set number              " Show the line numbers on the left side.
set formatoptions+=o    " Continue comment marker in new lines.
set textwidth=0         " Hard-wrap long lines as you type them.
set expandtab           " Insert spaces when TAB is pressed.
set tabstop=2           " Render TABs using this many spaces.
set shiftwidth=2        " Indentation amount for < and > commands.

set linespace=0         " Set line-spacing to minimum.
set nojoinspaces        " Prevents inserting two spaces after punctuation on a join (J)

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


let g:netrw_banner = 0
let g:netrw_browse_split = 3

set encoding=utf8
set guifont=FuraCode\ Nerd\ Font\ 18
let NERDTreeMapOpenInTab='<ENTER>'
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
" let g:polyglot_disabled = ['latex']
autocmd bufreadpre *.tex setlocal textwidth=60

" Turn off vim-go defaults
let g:go_fmt_autosave = 1
let g:go_metalinter_autosave_enabled = []

" enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()

" note that you must keep `noinsert` in completeopt, you must not use
" `longest`. The others are optional. Read `:help completeopt` for
" more info
set completeopt=noinsert,menuone,noselect
set shortmess+=c

au TextChangedI * call ncm2#auto_trigger()

inoremap <c-c> <ESC>

inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Required for operations modifying multiple buffers like rename.
set hidden

let g:LanguageClient_serverCommands = {
    \ 'go': ['go-langserver'],
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
    \ 'javascript': ['javascript-typescript-stdio'],
    \ 'javascript.jsx': ['tcp://127.0.0.1:2089'],
    \ 'python': ['pyls'],
    \ }

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
" Or map each action separately
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

let g:LanguageClient_loggingFile = '/tmp/lc.log'
