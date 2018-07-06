" Install Vim Plug if not installed
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin()

Plug 'dikiaap/minimalist'
Plug 'scrooloose/nerdtree'
Plug 'Nopik/vim-nerdtree-direnter'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tomtom/tcomment_vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-gitgutter'
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'ludovicchabant/vim-gutentags'
Plug 'Yggdroot/indentLine'
Plug 'dbakker/vim-projectroot'
Plug 'mileszs/ack.vim'
Plug 'kburdett/vim-nuuid'
" Plug 'lervag/vimtex'

" YAML Plugins
Plug 'stephpy/vim-yaml'

"Javascript Plugins
Plug 'sheerun/vim-polyglot'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'carlitux/deoplete-ternjs'
Plug 'ternjs/tern_for_vim', { 'do': 'npm install ; npm install -g tern' }
Plug 'w0rp/ale'
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'

" Load Last
Plug 'ryanoasis/vim-devicons'
call plug#end()

let g:airline#extensions#tabline#enabled = 1

let g:ale_linters = {'go': ['gofmt', 'gometalinter']}
let g:ale_fixers = {
\   'javascript': ['eslint'],
\   'json': ['prettier'],
\   'go': ['gofmt'],
\}
let g:ale_lint_on_enter = 1
let g:ale_lint_on_text_changed = 'normal'
let g:ale_fix_on_save = 1
let g:ale_go_gometalinter_options = '--disable-all --enable=golint --enable=goimports --enable=vet --enable=vetshadow --enable=gotype --enable=deadcode --enable=errcheck --enable=ineffassign --enable=interfacer --enable=test --enable=megacheck'

nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_ignore_case = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#enable_camel_case = 1
let g:deoplete#enable_refresh_always = 1
let g:deoplete#max_abbr_width = 0
let g:deoplete#max_menu_width = 0
let g:deoplete#omni#input_patterns = get(g:,'deoplete#omni#input_patterns',{})
call deoplete#custom#source('_', 'matchers', ['matcher_full_fuzzy'])

let g:tern_request_timeout = 1
let g:tern_request_timeout = 6000
let g:tern#command = ["tern"]
let g:tern#arguments = ["--persistent"]
let g:deoplete#sources#tss#javascript_support = 1

let g:indentLine_enabled = 1
let g:indentLine_char = '¦'

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

let g:gutentags_generate_on_new = 1
let g:gutentags_project_root_finder = 'ProjectRootGuess'
let g:gutentags_ctags_tagfile = '.tags'
let g:gutentags_file_list_command = 'rg --files'
set tags=./.tags;./tags

set encoding=utf8
set guifont=FuraCode\ Nerd\ Font\ 18
let NERDTreeMapOpenInTab='<ENTER>'
colorscheme minimalist 
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
" let g:polyglot_disabled = ['latex']
autocmd bufreadpre *.tex setlocal textwidth=60

" Turn off vim-go defaults
let g:go_fmt_autosave = 1
let g:go_metalinter_autosave_enabled = []
