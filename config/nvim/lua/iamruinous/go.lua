-- go stuff
vim.cmd [[ autocmd BufWritePre *.go :silent! lua require('go.format').goimport() ]]
vim.cmd [[ au FileType go set noexpandtab ]]
vim.cmd [[ au FileType go set shiftwidth=4 ]]
vim.cmd [[ au FileType go set softtabstop=4 ]]
vim.cmd [[ au FileType go set tabstop=4 ]]
