-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-----------------------------------------------------------
-- General
-----------------------------------------------------------
vim.opt.mouse = "a"               -- enable mouse support
vim.opt.clipboard = 'unnamedplus' -- copy/paste to system clipboard
vim.opt.swapfile = false          -- don't use swapfile
vim.opt.updatetime = 250          -- Decrease update time
vim.opt.timeoutlen = 300          -- Decrease update time
vim.opt.signcolumn = "yes"        -- Keep signcolumn on by default
vim.opt.termguicolors = true

-----------------------------------------------------------
-- Neovim UI
-----------------------------------------------------------
vim.opt.number = true         -- show line number
vim.opt.relativenumber = true -- show relative line number
vim.opt.showmatch = true      -- highlight matching parenthesis
vim.opt.showmode = false      -- Don't show the mode, since it's already in status line
vim.opt.splitright = true     -- vertical split to the right
vim.opt.splitbelow = true     -- Horizontal split to the bottom
vim.opt.linebreak = true      -- wrap on word boundary::
vim.opt.cursorline = true     -- Enable highlighting of the current line
vim.opt.showtabline = 1       -- Always show tabs
vim.o.breakindent = true      -- Enable break indent
vim.opt.scrolloff = 10        -- Minimal number of screen lines to keep above and below the cursor.
vim.opt.inccommand = "split"  -- Preview substitutions live, as you type!

-----------------------------------------------------------
-- Search
-----------------------------------------------------------
-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true -- ignore case letters when search
vim.opt.smartcase = true  -- ignore lowercase for the whole pattern
vim.opt.incsearch = true
vim.opt.hlsearch = true

-----------------------------------------------------------
-- Memory, CPU
-----------------------------------------------------------
vim.opt.hidden = true     -- enable background buffers
vim.opt.history = 100     -- remember n lines in history
vim.opt.lazyredraw = true -- faster scrolling
vim.opt.synmaxcol = 500   -- max column for syntax highlight
vim.opt.undofile = true   -- Save undo history

-----------------------------------------------------------
-- Tabs, indent
-----------------------------------------------------------
-- Sets how neovim will display certain whitespace in the editor.
--  See :help 'list'
--  and :help 'listchars'
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

vim.opt.expandtab = true   -- use spaces instead of tabs
vim.opt.smartindent = true -- autoindent new lines
vim.opt.autoindent = true

-----------------------------------------------------------
-- Autocompletion
-----------------------------------------------------------
vim.opt.completeopt = "menuone"
-- don't auto commenting new lines
