-- Set <space> as the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

--------------------------------------------------------------------------
--- OPTIONS                                                            ---
--------------------------------------------------------------------------
-- General
vim.opt.mouse = 'a'               -- enable mouse support
vim.opt.clipboard = 'unnamedplus' -- copy/paste to system clipboard
-- vim.opt.clipboard = vim.opt.vscode_clipboard
vim.opt.swapfile = false          -- don't use swapfile
-- vim.opt.updatetime = 250          -- Decrease update time
-- vim.opt.timeoutlen = 300          -- Decrease update time
vim.opt.signcolumn = 'yes' -- Keep signcolumn on by default
vim.opt.termguicolors = true
-- vim.opt.spelllang = 'en_us'       -- Set language
-- vim.opt.spell = true              -- Set spelling

-- Neovim UI
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
vim.opt.inccommand = 'split'  -- Preview substitutions live, as you type!

-- Search
-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true -- ignore case letters when search
vim.opt.smartcase = true  -- ignore lowercase for the whole pattern
vim.opt.incsearch = true
vim.opt.hlsearch = true

-- Memory, CPU
vim.opt.hidden = true     -- enable background buffers
vim.opt.history = 100     -- remember n lines in history
vim.opt.lazyredraw = true -- faster scrolling
vim.opt.synmaxcol = 500   -- max column for syntax highlight
vim.opt.undofile = true   -- Save undo history

-- Tabs, indent
vim.opt.expandtab = true   -- use spaces instead of tabs
vim.opt.smartindent = true -- autoindent new lines
vim.opt.autoindent = true

-----------------------------------------------------------
-- Autocompletion
-----------------------------------------------------------
vim.opt.completeopt = 'menu,menuone,noselect'
-- don't auto commenting new lines

--------------------------------------------------------------------------
--- KEYMAPS                                                            ---
--------------------------------------------------------------------------
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('x', '<leader>p', '\'_dP')

-- Move to begin/end of line
vim.keymap.set({ 'n', 'v' }, 'L', '$')
vim.keymap.set({ 'n', 'v' }, 'H', '^')

-- Motion Bindings
-- replace currently selected text with default register without yanking it
vim.keymap.set('v', '<leader>p', '\"_dP')

-- Move visual line up/down
-- vim.keymap.set('n', 'j','gj') (default)
-- vim.keymap.set('n', 'k','gk') (default)

-- Go to next/pevrious action marker
vim.keymap.set('n', '[d', [[<cmd>lua require('vscode').call('editor.action.marker.prev')<cr>]])
vim.keymap.set('n', ']d', [[<cmd>lua require('vscode').call('editor.action.marker.next')<cr>]])

-- Taken from telescope
vim.keymap.set('n', '<leader>sb', [[<cmd>lua require('vscode').call('workbench.action.showEditorsInActiveGroup')<cr>]])
vim.keymap.set('n', '<leader>sd', [[<cmd>lua require('vscode').call('workbench.action.problems.focus')<cr>]])
vim.keymap.set('n', '<leader>sf', [[<cmd>lua require('vscode').call('workbench.action.quickOpen')<cr>]])
vim.keymap.set('n', '<leader>sg', [[<cmd>lua require('vscode').call('workbench.action.findInFiles')<cr>]])
vim.keymap.set('n', '<leader>s.', [[<cmd>lua require('vscode').call('workbench.action.openRecent')<cr>]])
vim.keymap.set('n', '<leader>/', [[<cmd>lua require('vscode').action('workbench.action.findInFiles')<cr>]])
vim.keymap.set('n', 'g/', [[<cmd>lua require('vscode').action('workbench.action.quickTextSearch')<cr>]])


-- Taken from lspconfig
-- vim.keymap.set('n', 'gd', [[<cmd>lua require('vscode').action('editor.action.revealDefinition')<cr>]]) (default)
vim.keymap.set('n', 'gr', [[<cmd>lua require('vscode').action('editor.action.goToReferences')<cr>]])
vim.keymap.set('n', 'gI', [[<cmd>lua require('vscode').action('editor.action.goToImplementation')<cr>]])
vim.keymap.set('n', 'gy', [[<cmd>lua require('vscode').action('editor.action.goToTypeDefinition')<cr>]])
-- vim.keymap.set('n', 'gD', [[<cmd>lua require('vscode').action('editor.action.peekDeclaration')<cr>]]) (default)
vim.keymap.set('n', 'gs', [[<cmd>lua require('vscode').action('workbench.action.gotoSymbol')<cr>]])
vim.keymap.set('n', 'gS', [[<cmd>lua require('vscode').action('workbench.action.showAllSymbols')<cr>]])
vim.keymap.set('n', 'cd', [[<cmd>lua require('vscode').action('editor.action.rename')<cr>]])
-- vim.keymap.set({ "n", "x" }, "<leader>r", function() vscode.with_insert(function() vscode.action("editor.action.refactor") end) end) (default)
vim.keymap.set('n', 'g.', [[<cmd>lua require('vscode').action('editor.action.quickFix')<cr>]])
vim.keymap.set({ 'n', 'x' }, '<leader>fd', [[<cmd>lua require('vscode').call('editor.action.formatDocument')<cr>]])
vim.keymap.set({ 'x' }, '<leader>fs', [[<cmd>lua require('vscode').call('editor.action.formatSelection')<cr>]])
-- vim.keymap.set('n', 'K', [[<cmd>lua require('vscode').call('editor.action.showHover')<cr>]])  (default)

vim.keymap.set('v', 'p', 'pgvy')

-- Multi Cursor Selection
vim.keymap.set({ "n", "x", "i" }, "gl",
  function() vscode.with_insert(function() vscode.action("editor.action.addSelectionToNextFindMatch") end) end)
vim.keymap.set({ "n", "x", "i" }, "gL",
  function() vscode.with_insert(function() vscode.action("editor.action.addSelectionToPreviousFindMatch") end) end)

-- -- Treesitter Expand Shrink
-- vim.keymap.set({ 'n', 'x' }, '[x', [[<cmd>lua require('vscode').call('editor.action.smartSelect.expand')<cr>]])
-- vim.keymap.set('x', ']x', [[<cmd>lua require('vscode').call('editor.action.smartSelect.shrink')<cr>]])

---------------------------------------------------------------------------
--- AUTOCOMMANDS                                                        ---
---------------------------------------------------------------------------
-- Set the highlight group for yank
-- Create the autocommand for yank highlighting
vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})


-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- -- [[ Configure and install plugins ]]
require('lazy').setup({
  {
    {
      "folke/flash.nvim",
      event = "VeryLazy",
      opts = {},
      -- stylua: ignore
      keys = {
        { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
        { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
        { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
        { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
        { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
      },
    },
    {
      --     Old text                    Command         New text
      -- --------------------------------------------------------------------------------
      --     surr*ound_words             ysiw)           (surround_words)
      --     *make strings               ys$"            "make strings"
      --     [delete ar*ound me!]        ds]             delete around me!
      --     remove <b>HTML t*ags</b>    dst             remove HTML tags
      --     'change quot*es'            cs'"            "change quotes"
      --     <b>or tag* types</b>        csth1<CR>       <h1>or tag types</h1>
      --     delete(functi*on calls)     dsf             function calls
      "kylechui/nvim-surround",
      version = "*", -- Use for stability; omit to use `main` branch for the latest features
      event = "VeryLazy",
      config = function()
        require("nvim-surround").setup({})
      end,
    },
    { -- Highlight, edit, and navigate code
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
      config = function()
        ---@diagnostic disable-next-line: missing-fields
        require("nvim-treesitter.configs").setup({
          ensure_installed = "all",
          -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
          auto_install = true,
          highlight = { enable = true },
          indent = { enable = true },
          incremental_selection = {
            enable = true,
            keymaps = {
              init_selection = "]x",
              node_incremental = "]x",
              scope_incremental = false,
              node_decremental = "[x",
            },
          },
        })
      end,
    },
    {
      "nvim-treesitter/nvim-treesitter-textobjects",
      after = "nvim-treesitter",
      requires = "nvim-treesitter/nvim-treesitter",
      event = "VeryLazy",
      enabled = true,
      config = function()
        require 'nvim-treesitter.configs'.setup({
          textobjects = {
            move = {
              enable = true,
              goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer", ["]a"] = "@parameter.inner" },
              goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
              goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer", ["[a"] = "@parameter.inner" },
              goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer", ["[A"] = "@parameter.inner" },
            },
          },
        })
      end
    }
  },
})
