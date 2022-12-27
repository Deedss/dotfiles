local opt = vim.opt         	-- global/buffer/windows-scoped options

-----------------------------------------------------------
-- General
-----------------------------------------------------------
opt.mouse = 'a'                 -- enable mouse support
opt.clipboard = 'unnamedplus'   -- copy/paste to system clipboard
opt.swapfile = false            -- don't use swapfile
opt.updatetime = 250
vim.wo.signcolumn = 'yes'

-----------------------------------------------------------
-- Neovim UI
-----------------------------------------------------------
opt.number = true               -- show line number
opt.relativenumber = true       -- show relative line number
opt.showmatch = true            -- highlight matching parenthesis
-- opt.foldmethod = 'marker'       -- enable folding (default 'foldmarker')
opt.splitright = true           -- vertical split to the right
opt.splitbelow = true           -- Horizontal split to the bottom
opt.linebreak = true            -- wrap on word boundary::
opt.cursorline = true           -- Enable highlighting of the current line
opt.cmdheight = 1               -- Set commandlien height
opt.showtabline = 1             -- Always show tabs
vim.o.breakindent = true        -- Enable break indent

-----------------------------------------------------------
-- Search
-----------------------------------------------------------
opt.ignorecase = true           -- ignore case letters when search
opt.smartcase = true            -- ignore lowercase for the whole pattern
opt.incsearch = true
opt.hlsearch = false

-----------------------------------------------------------
-- Memory, CPU
-----------------------------------------------------------
opt.hidden = true               -- enable background buffers
opt.history = 100               -- remember n lines in history
opt.lazyredraw = true           -- faster scrolling
opt.synmaxcol = 500            -- max column for syntax highlight

-----------------------------------------------------------
-- Tabs, indent
-----------------------------------------------------------
opt.expandtab = true      -- use spaces instead of tabs
opt.shiftwidth = 4        -- shift 4 spaces when tab
opt.tabstop = 4           -- 1 tab == 4 spaces
opt.smartindent = true    -- autoindent new lines
opt.autoindent = true

-----------------------------------------------------------
-- Autocompletion
-----------------------------------------------------------
opt.completeopt = 'menu,menuone,noselect'
-- don't auto commenting new lines
