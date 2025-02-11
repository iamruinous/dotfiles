-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroLSP allows you to customize the features in AstroNvim's LSP configuration engine
-- Configuration documentation can be found with `:h astrolsp`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    features = {
      inlay_hints = true,
    },
    -- enable servers that you already have installed without mason
    servers = {
      "basedpyright",
      "lua_ls",
      "nil_ls",
      "harper_ls",
      "rust_analyzer",
      -- "pyright"
    },
    -- customize language server configuration options passed to `lspconfig`
    ---@diagnostic disable: missing-fields
    config = {
      nil_ls = {
        settings = {
          ["nil"] = {
            testSetting = 42,
            formatting = {
              command = { "alejandra" },
            },
          },
        },
      },
    },
  },
}
