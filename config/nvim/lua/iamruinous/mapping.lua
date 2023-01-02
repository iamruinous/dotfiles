-- trouble keybindings
local m = require("mapx")
m.nnoremap("<leader>xx", ":Trouble<cr>", "Trouble: toggle", "silent")
m.nnoremap("<leader>xw", ":Trouble lsp_workspace_diagnostics<cr>", "Trouble: LSP Workspace Diagnostics", "silent")
m.nnoremap("<leader>xd", ":Trouble lsp_workspace_diagnostics<cr>", "Trouble: LSP Document Diagnostics", "silent")
m.nnoremap("<leader>xl", ":Trouble loclist<cr>", "Trouble: loclist", "silent")
m.nnoremap("<leader>xq", ":Trouble loclist<cr>", "Trouble: Quickfix", "silent")
m.nnoremap("gR", ":Trouble lsp_references<cr>", "Trouble: LSP References", "silent")

-- telescope keybindings
m.nnoremap("<leader>ff", ":Telescope find_files<cr>", "Telescope: files")
m.nnoremap("<leader>fg", ":Telescope live_grep<cr>", "Telescope: grep")
m.nnoremap("<leader>fb", ":Telescope buffers<cr>", "Telescope: buffers")
m.nnoremap("<leader>fh", ":Telescope help_tags<cr>", "Telescope: tags")

-- crates keybindings
m.nnoremap("<leader>ct", ":lua require('crates').toggle()<cr>", "silent")
m.nnoremap("<leader>cr", ":lua require('crates').reload()<cr>", "silent")
m.nnoremap("<leader>cv", ":lua require('crates').show_versions_popup()<cr>", "silent")
m.nnoremap("<leader>cf", ":lua require('crates').show_features_popup()<cr>", "silent")
m.nnoremap("<leader>cu", ":lua require('crates').update_crate()<cr>", "silent")
m.vnoremap("<leader>cu", ":lua require('crates').update_crates()<cr>", "silent")
m.nnoremap("<leader>ca", ":lua require('crates').update_all_crates()<cr>", "silent")
m.nnoremap("<leader>cU", ":lua require('crates').upgrade_crate()<cr>", "silent")
m.vnoremap("<leader>cU", ":lua require('crates').upgrade_crates()<cr>", "silent")
m.nnoremap("<leader>cA", ":lua require('crates').upgrade_all_crates()<cr>", "silent")

-- nvim-tree keybindings
m.nnoremap("<C-n>", ":NvimTreeToggle<cr>")
