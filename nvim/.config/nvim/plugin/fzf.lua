vim.pack.add({
  { src = "https://github.com/ibhagwan/fzf-lua" },
  { src = "https://github.com/otavioschwanck/fzf-lua-explorer.nvim" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
})

require('fzf-lua').setup()
require("fzf-lua-explorer").setup()

local fzflua = require('fzf-lua')

-- -- Top Pickers
vim.keymap.set("n", "<leader>e", function ()
  require("fzf-lua-explorer").explorer()
end, { desc = "File Explorer" })
-- -- find
vim.keymap.set("n", "<leader>,", fzflua.buffers, { desc = "Buffers" })
vim.keymap.set("n", "<leader>fb", fzflua.buffers, { desc = "Buffers" })
vim.keymap.set("n", "<leader>ff", fzflua.files, { desc = "Find Files" })
-- git
vim.keymap.set("n", "<leader>fg", fzflua.git_files, { desc = "Find Git Files" })
vim.keymap.set("n", "<leader>gb", fzflua.git_branches, { desc = "Git Branches" })
vim.keymap.set("n", "<leader>gs", fzflua.git_status, { desc = "Git Status" })
vim.keymap.set("n", "<leader>gS", fzflua.git_stash, { desc = "Git Stash" })
vim.keymap.set("n", "<leader>gd", fzflua.git_diff, { desc = "Git Diff (Hunks)" })
-- Grep
vim.keymap.set("n", "<leader>/", fzflua.live_grep, { desc = "Grep" })
vim.keymap.set({ "n", "x" }, "<leader>gw", fzflua.grep_cword, { desc = "Visual selection or word" })
-- search
vim.keymap.set("n", '<leader>s"', fzflua.registers, { desc = "Registers" })
vim.keymap.set("n", "<leader>sb", fzflua.lines, { desc = "Buffer Lines" })
vim.keymap.set("n", "<leader>sC", fzflua.commands, { desc = "Commands" })
vim.keymap.set("n", "<leader>sd", fzflua.diagnostics_document, { desc = "Buffer Diagnostics" })
vim.keymap.set("n", "<leader>sh", fzflua.helptags, { desc = "Help Pages" })
vim.keymap.set("n", "<leader>sH", fzflua.highlights, { desc = "Highlights" })
vim.keymap.set("n", "<leader>sj", fzflua.jumps, { desc = "Jumps" })
vim.keymap.set("n", "<leader>sk", fzflua.keymaps, { desc = "Keymaps" })
vim.keymap.set("n", "<leader>sl", fzflua.loclist, { desc = "Location List" })
vim.keymap.set("n", "<leader>sm", fzflua.marks, { desc = "Marks" })
vim.keymap.set("n", "<leader>sM", fzflua.manpages, { desc = "Man Pages" })
vim.keymap.set("n", "<leader>sq", fzflua.quickfix, { desc = "Quickfix List" })
vim.keymap.set("n", "<leader>:", fzflua.command_history, { desc = "Command History" })
-- LSP
vim.keymap.set("n", "gd", fzflua.lsp_definitions, { desc = "Goto Definition" })
vim.keymap.set("n", "gD", fzflua.lsp_declarations, { desc = "Goto Declaration" })
vim.keymap.set("n", "gr", fzflua.lsp_references, { desc = "References" })
vim.keymap.set("n", "gI", fzflua.lsp_implementations, { desc = "Goto Implementation" })
vim.keymap.set("n", "gy", fzflua.lsp_typedefs, { desc = "Goto Type Definition" })
vim.keymap.set("n", "<leader>ss", fzflua.lsp_document_symbols, { desc = "LSP Symbols" })
vim.keymap.set("n", "<leader>sS", fzflua.lsp_workspace_symbols, { desc = "LSP Workspace Symbols" })
vim.keymap.set({ "n", "v" }, "g.", fzflua.lsp_code_actions, { desc = "Code Action" })
