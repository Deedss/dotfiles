vim.pack.add({
  { src = "https://github.com/echasnovski/mini.nvim" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons" }
})

require("mini.ai").setup()
require("mini.diff").setup()
require("mini.move").setup()
require("mini.statusline").setup()
require("mini.tabline").setup()

-- -- Top Pickers & Explorer
-- vim.keymap.set("n", "<leader>/", function() require('snacks').picker.grep() end, { desc = "Grep" })
-- vim.keymap.set("n", "<leader>:", function() require('snacks').picker.command_history() end, { desc = "Command History" })
-- vim.keymap.set("n", "<leader>e", function() require('snacks').explorer() end, { desc = "File Explorer" })
-- -- find
-- vim.keymap.set("n", "<leader>,", function() require('snacks').picker.buffers() end, { desc = "Buffers" })
-- vim.keymap.set("n", "<leader>fb", function() require('snacks').picker.buffers() end, { desc = "Buffers" })
-- vim.keymap.set("n", "<leader>ff", function() require('snacks').picker.files() end, { desc = "Find Files" })
-- vim.keymap.set("n", "<leader>fg", function() require('snacks').picker.git_files() end, { desc = "Find Git Files" })
-- vim.keymap.set("n", "<leader>fp", function() require('snacks').picker.projects() end, { desc = "Projects" })
-- vim.keymap.set("n", "<leader>fr", function() require('snacks').picker.recent() end, { desc = "Recent" })
-- -- git
-- vim.keymap.set("n", "<leader>gb", function() require('snacks').picker.git_branches() end, { desc = "Git Branches" })
-- vim.keymap.set("n", "<leader>gl", function() require('snacks').picker.git_log() end, { desc = "Git Log" })
-- vim.keymap.set("n", "<leader>gL", function() require('snacks').picker.git_log_line() end, { desc = "Git Log Line" })
-- vim.keymap.set("n", "<leader>gs", function() require('snacks').picker.git_status() end, { desc = "Git Status" })
-- vim.keymap.set("n", "<leader>gS", function() require('snacks').picker.git_stash() end, { desc = "Git Stash" })
-- vim.keymap.set("n", "<leader>gd", function() require('snacks').picker.git_diff() end, { desc = "Git Diff (Hunks)" })
-- vim.keymap.set("n", "<leader>gg", function() require('snacks').lazygit() end, { desc = "Lazygit" })
-- -- Grep
-- vim.keymap.set("n", "<leader>sB", function() require('snacks').picker.grep_buffers() end, { desc = "Grep Open Buffers" })
-- vim.keymap.set("n", "<leader>sg", function() require('snacks').picker.grep() end, { desc = "Grep" })
-- vim.keymap.set({ "n", "x" }, "<leader>sw", function() require('snacks').picker.grep_word() end,
--     { desc = "Visual selection or word" })
-- -- search
-- vim.keymap.set("n", '<leader>s"', function() require('snacks').picker.registers() end, { desc = "Registers" })
-- vim.keymap.set("n", "<leader>sb", function() require('snacks').picker.lines() end, { desc = "Buffer Lines" })
-- vim.keymap.set("n", "<leader>sC", function() require('snacks').picker.commands() end, { desc = "Commands" })
-- vim.keymap.set("n", "<leader>sd", function() require('snacks').picker.diagnostics_buffer() end,
--     { desc = "Buffer Diagnostics" })
-- vim.keymap.set("n", "<leader>sh", function() require('snacks').picker.help() end, { desc = "Help Pages" })
-- vim.keymap.set("n", "<leader>sH", function() require('snacks').picker.highlights() end, { desc = "Highlights" })
-- vim.keymap.set("n", "<leader>si", function() require('snacks').picker.icons() end, { desc = "Icons" })
-- vim.keymap.set("n", "<leader>sj", function() require('snacks').picker.jumps() end, { desc = "Jumps" })
-- vim.keymap.set("n", "<leader>sk", function() require('snacks').picker.keymaps() end, { desc = "Keymaps" })
-- vim.keymap.set("n", "<leader>sl", function() require('snacks').picker.loclist() end, { desc = "Location List" })
-- vim.keymap.set("n", "<leader>sm", function() require('snacks').picker.marks() end, { desc = "Marks" })
-- vim.keymap.set("n", "<leader>sM", function() require('snacks').picker.man() end, { desc = "Man Pages" })
-- vim.keymap.set("n", "<leader>sp", function() require('snacks').picker.lazy() end, { desc = "Search for Plugin Spec" })
-- vim.keymap.set("n", "<leader>sq", function() require('snacks').picker.qflist() end, { desc = "Quickfix List" })
-- vim.keymap.set("n", "<leader>sR", function() require('snacks').picker.resume() end, { desc = "Resume" })
-- -- LSP

-- -- Other
-- vim.keymap.set("n", "<leader>cR", function() require('snacks').rename.rename_file() end, { desc = "Rename File" })
-- vim.keymap.set("n", "<c-/>", function() require('snacks').terminal() end, { desc = "Toggle Terminal" })
