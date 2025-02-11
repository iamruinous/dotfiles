vim.cmd [[colorscheme tokyonight-night]]

-- Setup language servers.
local lspconfig = require "lspconfig"
---@diagnostic disable: missing-fields
lspconfig.basedpyright.setup {}
lspconfig.lua_ls.setup {}
local caps = vim.tbl_deep_extend(
  "force",
  vim.lsp.protocol.make_client_capabilities(),
  require("cmp_nvim_lsp").default_capabilities(),
  -- File watching is disabled by default for neovim.
  -- See: https://github.com/neovim/neovim/pull/22405
  { workspace = { didChangeWatchedFiles = { dynamicRegistration = true } } }
)
lspconfig.nil_ls.setup {
  capabilities = caps,
  settings = {
    ["nil"] = {
      testSetting = 42,
      formatting = {
        command = { "nixfmt" },
      },
    },
  },
}
lspconfig.rust_analyzer.setup {}
