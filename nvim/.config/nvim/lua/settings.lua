-----------------------------------------------------------------------------------
-- SETTINGS
-- Contains all settings concerning nvim
-----------------------------------------------------------------------------------
vim.cmd('set iskeyword+=-') -- treat dash separated words as a word text object"
vim.cmd('set shortmess+=c') -- Don't pass messages to |ins-completion-menu|.
vim.cmd('set inccommand=split') -- Make substitution work in realtime
vim.o.hidden = true -- Required to keep multiple buffers open multiple buffers
vim.o.title = true
vim.o.titlestring="%<%F%=%l/%L - nvim"
vim.wo.wrap = true -- Display long lines as just one line
vim.o.textwidth = 80
vim.cmd('set whichwrap+=<,>,[,],h,l') -- move to next line with theses keys
vim.cmd('syntax on') -- syntax highlighting vim.o.pumheight = 10 -- Makes popup menu smaller
vim.o.fileencoding = "utf-8" -- The encoding written to file
vim.o.cmdheight = 2 -- More space for displaying messages
vim.cmd('set colorcolumn=99999') -- fix indentline for now
vim.o.mouse = "a" -- Enable your mouse
vim.o.splitbelow = true -- Horizontal splits will automatically be below

vim.o.ruler = true
vim.o.showmatch = true
vim.o.splitright = true -- Vertical splits will automatically be to the right
vim.o.conceallevel = 0 -- So that I can see `` in markdown files
vim.cmd('set ts=4') -- Insert 2 spaces for a tab
vim.cmd('set sw=4') -- Change the number of space characters inserted for indentation
vim.cmd('set expandtab') -- Converts tabs to spaces
vim.bo.smartindent = true -- Makes indenting smart
vim.wo.number = true -- set numbered lines
vim.wo.relativenumber = true -- set relative number
vim.wo.cursorline = true -- Enable highlighting of the current line
vim.o.showtabline = 2 -- Always show tabs
vim.o.showmode = false -- We don't need to see things like -- INSERT -- anymore
vim.o.backup = false -- This is recommended by coc
vim.o.writebackup = false -- This is recommended by coc
vim.wo.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
vim.o.updatetime = 300 -- Faster completion
vim.o.clipboard = "unnamedplus" -- Copy paste between vim and everything else
vim.cmd('filetype plugin on') -- filetype detection
vim.o.completeopt = 'menuone,noselect'

---------------------------------
-- Color Schemes
---------------------------------
vim.o.termguicolors = true
-- vim.g.onedark_style = 'darker'
-- require('onedark').setup()
vim.g.material_style = 'darker'
vim.cmd([[colorscheme material]])
require("bufferline").setup{
    options = {
        numbers = function(opts)
            return string.format('[%s]', opts.id)
        end
    }
}
require('lualine').setup {
  options = {
      -- theme = 'onedark'
      theme = 'material-nvim'
  }
}

