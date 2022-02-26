-- Leader key -> ","
--
-- In general, it's a good idea to set this early in your config, because otherwise
-- if you have any mappings you set BEFORE doing this, they will be set to the OLD
-- leader.
vim.g.mapleader = " "


-----------------------------------------------------------------
-- FIRST LOAD PACKER 
-----------------------------------------------------------------
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd 'packadd packer.nvim'
end

-----------------------------------------------------------------------------------
-- PLUGINS
-- All installed plugins that are used in the nvim config
------------------------------------------------------------------------------------
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

require('packer').startup(function()
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- Color Schemes
    use 'RRethy/nvim-base16'
    use 'olimorris/onedarkpro.nvim'
    -- use 'marko-cerovac/material.nvim'

    -- Telescope
    use {
        'nvim-telescope/telescope.nvim',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

    -- -- NVim-Tree
    -- use {
    --     'kyazdani42/nvim-tree.lua',
    --     requires = 'kyazdani42/nvim-web-devicons',
    --     config = function() require'nvim-tree'.setup {} end
    -- }

    -- Toggleterm
    use {"akinsho/toggleterm.nvim"}

    -- Treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }

    -- LSP config
    use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client

     -- TEXT MANIUPLATION
    use 'tpope/vim-fugitive' -- Git commands in nvim
    use 'tpope/vim-rhubarb' -- Fugitive-companion to interact with github
    use 'tpope/vim-commentary' -- "gc" to comment visual regions/lines
    use "godlygeek/tabular" -- Quickly align text by pattern
    -- use 'tpope/vim-surround'
    use {
      "ur4ltz/surround.nvim",
      config = function()
        require"surround".setup {mappings_style = "surround"}
      end
    }

    -- Nvim Completions
    use 'hrsh7th/nvim-cmp'              -- Autocompletion plugin
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-nvim-lua'
    use "hrsh7th/cmp-path"
    use "onsails/lspkind-nvim"

    -- Snippets
    use "rafamadriz/friendly-snippets"
    use "L3MON4D3/LuaSnip"

    -- Interface
    use {
      'hoob3rt/lualine.nvim',
      requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }
    use {'akinsho/bufferline.nvim', requires = 'kyazdani42/nvim-web-devicons'}

    -- Nvim Debug Adapter Protocol
    use "mfussenegger/nvim-dap"
    use "rcarriga/nvim-dap-ui"
    use "theHamsta/nvim-dap-virtual-text"
    use "nvim-telescope/telescope-dap.nvim"
end)

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
