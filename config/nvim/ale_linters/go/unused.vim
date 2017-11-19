" Author: Jade Meskill <https://github.com/iamruinous>
" Description: unused for Go files

call ale#linter#Define('go', {
\   'name': 'unused',
\   'executable': 'unused',
\   'command': 'unused %s',
\   'callback': 'ale#handlers#unix#HandleAsWarning',
\   'output_stream': 'both'
\})
