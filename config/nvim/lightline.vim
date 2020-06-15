" Setup lightline
let g:lightline = {
  \ 'colorscheme': 'tempus_winter',
  \ 'active': {
  \   'left': [
  \     [ 'mode', 'paste' ],
  \     [ 'readonly', 'diagnostic', 'cocstatus', 'filename', 'cocgit', 'method' ]
  \   ],
  \   'right':[
  \     [ 'filetype', 'fileencoding', 'lineinfo', 'percent' ],
  \     [ 'blame', 'cocgitproject' ]
  \   ],
  \ },
  \ 'component_function': {
  \   'blame': 'LightlineGitBlame',
  \   'cocgitproject': 'LightlineGitProject',
  \   'cocgit': 'LightlineGitInfo',
  \   'cocstatus': 'coc#status',
  \   'filetype': 'ICOFiletype',
  \   'fileformat': 'ICOFileformat',
  \ }
\ }

autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

function! LightlineGitBlame() abort
  let blame = get(b:, 'coc_git_blame', '')
  " return blame
  return winwidth(0) > 120 ? blame : ''
endfunction

function! LightlineGitProject() abort
  let blame = get(g:, 'coc_git_status', '')
  " return blame
  return winwidth(0) > 120 ? blame : ''
endfunction

function! LightlineGitInfo() abort
  let blame = get(b:, 'coc_git_status', '')
  " return blame
  return winwidth(0) > 120 ? blame : ''
endfunction

function! ICOFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! ICOFileformat()
  return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction
