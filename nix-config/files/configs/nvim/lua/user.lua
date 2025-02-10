vim.cmd [[colorscheme tokyonight-night]]

-- Setup language servers.
local lspconfig = require('lspconfig')
lspconfig.basedpyright.setup {}
lspconfig.lua_ls.setup{}
lspconfig.nil_ls.setup{}
lspconfig.rust_analyzer.setup {}
