" Author: Jade Meskill <https://github.com/iamruinous>
" Description: megacheck for Go files

call ale#linter#Define('go', {
\   'name': 'megacheck',
\   'executable': 'megacheck',
\   'command': 'megacheck %s',
\   'callback': 'ale#handlers#unix#HandleAsWarning',
\   'output_stream': 'both'
\})
