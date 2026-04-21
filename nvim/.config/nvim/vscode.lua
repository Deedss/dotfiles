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
vim.opt.completeopt = "menuone,noinsert,noselect"
-- don't auto commenting new lines

--------------------------------------------------------------------------
--- KEYMAPS                                                            ---
--------------------------------------------------------------------------
local vscode = require('vscode')
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('x', '<leader>p', '\'_dP')

-- Move to begin/end of line
vim.keymap.set({ 'n', 'v' }, 'L', '$')
vim.keymap.set({ 'n', 'v' }, 'H', '^')

-- Motion Bindings
-- replace currently selected text with default regist!er without yanking it
vim.keymap.set('v', '<leader>p', '\"_dP')

-- Move visual line up/down
-- vim.keymap.set('n', 'j','gj') (default)
-- vim.keymap.set('n', 'k','gk') (default)

-- Go to next/previous action marker
vim.keymap.set('n', '[d', function() vscode.call('editor.action.marker.prev') end)
vim.keymap.set('n', ']d', function() vscode.call('editor.action.marker.next') end)

-- Taken from telescope
vim.keymap.set('n', '<leader><leader>', function() vscode.call('workbench.action.showEditorsInActiveGroup') end)
vim.keymap.set('n', '<leader>sd', function() vscode.call('workbench.action.problems.focus') end)
vim.keymap.set('n', '<leader>ff', function() vscode.call('workbench.action.quickOpen') end)
vim.keymap.set('n', '<leader>fg', function() vscode.call('workbench.action.findInFiles') end)
vim.keymap.set('n', '<leader>s.', function() vscode.call('workbench.action.openRecent') end)
vim.keymap.set('n', '<leader>/', function() vscode.action('workbench.action.findInFiles') end)
vim.keymap.set('n', 'g/', function() vscode.action('workbench.action.quickTextSearch') end)


-- Taken from lspconfig
-- vim.keymap.set('n', 'gd', function() vscode.action('editor.action.revealDefinition') end) (default)
vim.keymap.set('n', 'gr', function() vscode.action('editor.action.goToReferences') end)
vim.keymap.set('n', 'gI', function() vscode.action('editor.action.goToImplementation') end)
vim.keymap.set('n', 'gy', function() vscode.action('editor.action.goToTypeDefinition') end)
-- vim.keymap.set('n', 'gD', function() vscode.action('editor.action.peekDeclaration') end) (default)
vim.keymap.set('n', 'gs', function() vscode.action('workbench.action.gotoSymbol') end)
vim.keymap.set('n', 'gS', function() vscode.action('workbench.action.showAllSymbols') end)
-- vim.keymap.set('n', 'cd', function() vscode.action('editor.action.rename') end)
vim.keymap.set('n', 'cd', function() vscode.action("editor.action.rename") end)

-- vim.keymap.set({ "n", "x" }, "<leader>r", function() vscode.with_insert(function() vscode.action("editor.action.refactor") end) end) (default)
vim.keymap.set('n', 'g.', function() vscode.action('editor.action.quickFix') end)
vim.keymap.set({ 'n', 'x' }, '<leader>fd', function() vscode.call('editor.action.formatDocument') end)
vim.keymap.set({ 'x' }, '<leader>fs', function() vscode.call('editor.action.formatSelection') end)
-- vim.keymap.set('n', 'K', function() vscode.call('editor.action.showHover') end) (default)

vim.keymap.set('v', 'p', 'pgvy')

-- Multi Cursor Selection
-- vim.keymap.set({ "n", "x", "i" }, "<M-d>",
--   function() vscode.with_insert(function() vscode.action("editor.action.addSelectionToNextFindMatch") end) end)
-- vim.keymap.set({ "n", "x", "i" }, "<M-D>",
--   function() vscode.with_insert(function() vscode.action("editor.action.addSelectionToPreviousFindMatch") end) end)

-- -- Treesitter Expand Shrink
vim.keymap.set({ 'n', 'x' }, '[x', function() vscode.call('editor.action.smartSelect.expand') end)
vim.keymap.set('x', ']x', function() vscode.call('editor.action.smartSelect.shrink') end)

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
