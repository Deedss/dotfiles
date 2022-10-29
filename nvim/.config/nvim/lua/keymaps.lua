local function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end


vim.g.mapleader = " "

-- Move Line up or down in Visual Mode
map("v", "J" ,":m '>+1<CR>gv=gv")
map("v" ,"K", ":m '<-2<CR>gv=gv")

-- Move by line
map("n", "j", "gj")
map("n", "k", "gk")

-- Use leader leader to switch between buffers
map("n", "<leader><leader>", "<C-^>")

-- Search results centered
map("n", "n", "nzz", { silent = true })
map("n", "N", "Nzz", { silent = true })
map("n", "*", "*zz", { silent = true })
map("n", "#", "#zz", { silent = true })
map("n", "g*", "g*zz", { silent = true })

-- Ctrl + h to stop search
map("n", "<C-H>", ":nohlsearch<CR>")
map("v", "<C-H>", ":nohlsearch<CR>")

-- Jump to start and end of the line using home row
map("n", "H", "^")
map("n", "L", "$")

-- Switching buffers
map("n", "]b", "<CMD>bn<CR>")
map("n", "[b", "<CMD>bp<CR>")


