-- trouble keybindings
local m = require("mapx")
m.nnoremap("<leader>xx", ":Trouble<cr>", "Trouble: toggle", "silent")
m.nnoremap("<leader>xw", ":Trouble lsp_workspace_diagnostics<cr>", "Trouble: LSP Workspace Diagnostics", "silent")
m.nnoremap("<leader>xd", ":Trouble lsp_workspace_diagnostics<cr>", "Trouble: LSP Document Diagnostics", "silent")
m.nnoremap("<leader>xl", ":Trouble loclist<cr>", "Trouble: loclist", "silent")
m.nnoremap("<leader>xq", ":Trouble loclist<cr>", "Trouble: Quickfix", "silent")
m.nnoremap("gR", ":Trouble lsp_references<cr>", "Trouble: LSP References", "silent")
