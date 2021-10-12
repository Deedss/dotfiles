-----------------------------------------------------------------------------------
-- MAPPINGS
-- Contains all mappings for nvim
-----------------------------------------------------------------------------------
local function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- -- Easy select all of file
-- map("n", "<Leader>sa", "ggVG<c-$>")

-- -- Make visual yanks place the cursor back where started
-- map("v", "y", "ygv<Esc>")

-- -- switch buffers in Normal mode
-- map("n", "<Tab>", ":bnext<CR>")
-- map("n", "<S-Tab>", ":bprevious<CR>")
-- map("n", "<leader><leader>", "<C-^>")

-- -- Make Y yank to end of the line
-- map("n", "Y", "y$")

-- -- Automatically go to current directory
-- map("n", "<leader>cd", ":cd %:p:h<CR>")

-- --After searching, pressing escape stops the highlight
-- map("n", "<esc>", ":noh<cr><esc>", { silent = true })

-- -- map navigation between splits using <C-{h,j,k,l}>
-- map("n", "<C-k>", [[<Cmd> wincmd k<CR>]])
-- map("n", "<C-l>", [[<Cmd> wincmd l<CR>]])
-- map("n", "<C-h>", [[<Cmd> wincmd h<CR>]])
-- map("n", "<C-j>", [[<Cmd> wincmd j<CR>]])

map("v", "J" ,":m '>+1<CR>gv=gv")
map("v" ,"K", ":m '<-2<CR>gv=gv")

-- map("n", "j", "gj")
-- map("n", "k", "gk")
-- -- " Useful mappings for managing tabs
-- map("n", "<leader>te", ":tabedit<Space>")
-- map("n", "<leader>tm", ":tabm<Space>")
-- map("n", "<leader>td", ":tabclose<CR>")
-- map("n", "<leader>tl", ":tabnext<CR>")
-- map("n", "<leader>th", ":tabprev<CR>")
-- map("n", "<leader>tn", ":tabnew<space>")

-- -- save
-- map("n", "zz", [[<Cmd> w<CR>]], { silent = true })

-- map("t", "<Esc>", [[<C-\><C-n>]], { silent = true })

-- -- horizontal & vertical resize
-- map("n", "+", [[<Cmd> vertical resize +5<CR>]])
-- map("n", "_", [[<Cmd> vertical resize -5<CR>]])
-- map("n", "<leader>=", [[<Cmd> resize +5<CR>]])
-- map("n", "<leader>-", [[<Cmd> resize -5<CR>]])

-- map('n', '<leader>wv', [[<Cmd>vsplit<CR>]])
-- map('n', '<leader>wh', [[<Cmd>split<CR>]])

-- -- Easier indenting control in visual mode
-- map('v', '>', '>gv')
-- map('v', '<', '<gv')

-- -- Ctrl+t to open an integrated terminal in a split, like other IDEs
-- map('n', '<leader>t', ':vsplit | set nonumber norelativenumber | terminal<CR>:set nobuflisted<CR>a', {silent = true})

-- -- Keeping it centered
-- map("n","n", "nzzzv")
-- map("n","N", "Nzzzv")
-- map("n", "J", "mzJ'z")

-- map("i", ",", ",<c-g>u")
-- map("i", ".", ".<c-g>u")
-- map("i", "!", "!<c-g>u")
-- map("i", "?", "?<c-g>u")

-- map("n", "<leader>p", "0p")
-- map("n", "<leader>P", "0P")
