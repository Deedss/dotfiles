local function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end


vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Move Line up or down in Visual Mode
map("v", "J" ,":m '>+1<CR>gv=gv")
map("v" ,"K", ":m '<-2<CR>gv=gv")

-- Search results centered
map("n", "n", "nzz", { silent = true })
map("n", "N", "Nzz", { silent = true })
map("n", "*", "*zz", { silent = true })
map("n", "#", "#zz", { silent = true })
map("n", "g*", "g*zz", { silent = true })

-- Jump to start and end of the line using home row
map("n", "H", "^")
map("n", "L", "$")


