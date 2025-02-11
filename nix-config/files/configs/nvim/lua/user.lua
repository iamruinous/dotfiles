vim.cmd [[colorscheme tokyonight-night]]

-- Setup language servers.
require("mason-lspconfig").setup {
  ensure_installed = {},
  automatic_installation = false,
}
require("mason-null-ls").setup {
  ensure_installed = {},
  automatic_installation = false,
}
