-----------------------------------------------------------
-- Neovim settings
-----------------------------------------------------------

-----------------------------------------------------------
-- Neovim API aliases
-----------------------------------------------------------
--local map = vim.api.nvim_set_keymap  -- set global keymap
local cmd = vim.cmd     		-- execute Vim commands
local exec = vim.api.nvim_exec 	-- execute Vimscript
local fn = vim.fn       		-- call Vim functions
local g = vim.g         		-- global variables
local opt = vim.opt         	-- global/buffer/windows-scoped options

-----------------------------------------------------------
-- General
-----------------------------------------------------------
opt.mouse = 'a'                 -- enable mouse support
opt.clipboard = 'unnamedplus'   -- copy/paste to system clipboard
opt.swapfile = false            -- don't use swapfile
opt.syntax = 'on'
opt.fileencoding = 'utf-8'
opt.updatetime = 700
cmd [[filetype plugin on]]
opt.signcolumn = 'yes:1'

cmd [[set iskeyword+=-]]        -- treat dash separated words as a word text object"
cmd [[set shortmess+=c]]        -- Don't pass messages to |ins-completion-menu|.
cmd [[set inccommand=split]]    -- Make substitution work in realtime

-----------------------------------------------------------
-- Neovim UI
-----------------------------------------------------------
opt.number = true               -- show line number
opt.relativenumber = true       -- show relative line number
opt.showmatch = true            -- highlight matching parenthesis
-- opt.foldmethod = 'marker'       -- enable folding (default 'foldmarker')
opt.splitright = true           -- vertical split to the right
opt.splitbelow = true           -- Horizontal split to the bottom
opt.linebreak = true            -- wrap on word boundary
opt.wrap = false
opt.title = true                -- set a title
opt.titlestring = '%<%F%= - nvim'
opt.cursorline = true           -- Enable highlighting of the current line
opt.cmdheight = 2               -- Set commandlien height
opt.showtabline = 2             -- Always show tabs
opt.inccommand = 'split'        -- inccommand
opt.showmode = false            -- Don't show mode anymore
cmd [[set whichwrap+=<,>,[,],h,l]]

-- remove whitespace on save
cmd [[au BufWritePre * :%s/\s\+$//e]]

-- highlight on yank
exec([[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
  augroup end
]], false)

-----------------------------------------------------------
-- Search
-----------------------------------------------------------
opt.ignorecase = true           -- ignore case letters when search
opt.smartcase = true            -- ignore lowercase for the whole pattern
opt.gdefault = true
opt.incsearch = true

-----------------------------------------------------------
-- Memory, CPU
-----------------------------------------------------------
opt.hidden = true               -- enable background buffers
opt.history = 100               -- remember n lines in history
opt.lazyredraw = true           -- faster scrolling
opt.synmaxcol = 500            -- max column for syntax highlight

-----------------------------------------------------------
-- Colorscheme
-----------------------------------------------------------
opt.termguicolors = true      -- enable 24-bit RGB colors
-- cmd [[set background=dark]]
-- cmd [[colorscheme base16-gruvbox-dark-hard]]
-- opt.background = "dark"
require('onedarkpro').load()
local colors = require("onedarkpro").get_colors("onedark")
-- g.material_style = "darker"
-- cmd [[colorscheme material]]
-----------------------------------------------------------
-- Tabline and BufferLine
-----------------------------------------------------------
require("bufferline").setup{
    options = {
        show_buffer_icons = false,
        show_close_icon = false,
        show_buffer_close_icons = false,
        numbers = function(opts)
            return string.format('[%s]', opts.id)
        end
    },
    -- highlights = {
    --     fill = {
    --         -- guifg = colors.fg,
    --         -- guibg = colors.bg,
    --     },
    -- }
}
require('lualine').setup {
  options = {
      theme = 'onedark'
      -- theme = 'material-nvim'
  }
}

-----------------------------------------------------------
-- Tabs, indent
-----------------------------------------------------------
opt.expandtab = true      -- use spaces instead of tabs
opt.shiftwidth = 4        -- shift 4 spaces when tab
opt.tabstop = 4           -- 1 tab == 4 spaces
opt.smartindent = true    -- autoindent new lines

-----------------------------------------------------------
-- Autocompletion
-----------------------------------------------------------
opt.completeopt = 'menuone,noselect'
-- don't auto commenting new lines
cmd [[au BufEnter * set fo-=c fo-=r fo-=o]]

-----------------------------------------------------------
-- Terminal
-----------------------------------------------------------
-- open a terminal pane on the right using :Term
cmd [[command Term :botright vsplit term://$SHELL]]

-- Terminal visual tweaks
--- enter insert mode when switching to terminal
--- close terminal buffer on process exit
cmd [[
    autocmd TermOpen * setlocal listchars= nonumber norelativenumber nocursorline
    autocmd TermOpen * startinsert
    autocmd BufLeave term://* stopinsert
]]
