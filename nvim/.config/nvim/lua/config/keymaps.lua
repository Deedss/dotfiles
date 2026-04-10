vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("x", "<leader>p", "\"_dP")

-- Jump to start and end of the line using home row
vim.keymap.set("n", "H", "^")
vim.keymap.set("n", "L", "$")

-- https://vim.fandom.com/wiki/Moving_lines_up_or_down#Mappings_to_move_lines
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { silent = true, noremap = true })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { silent = true, noremap = true })
vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi", { silent = true, noremap = true })
vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi", { silent = true, noremap = true })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { silent = true, noremap = true })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { silent = true, noremap = true })
