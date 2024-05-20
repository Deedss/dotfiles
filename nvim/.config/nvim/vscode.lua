-- Set <space> as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Jump to start and end of the line using home row
vim.keymap.set("n", "H", "^")
vim.keymap.set("n", "L", "$")

-----------------------------------------------------------
-- VSCODE KEYMAPS
-----------------------------------------------------------
local vscode = require('vscode-neovim')

-- Diagnostics
vim.keymap.set("n", "[d", function() vscode.action('editor.action.marker.prev') end)
vim.keymap.set("n", "]d", function() vscode.action('editor.action.marker.next') end)
-- vim.keymap.set("n", "<leader>e", function () vscode.call('editor.action.problems.focus') end)

-- Telescope
vim.keymap.set("n", "<leader>sf", function() vscode.action("workbench.action.quickOpen") end)
vim.keymap.set("n", "<leader>sw",
  function() vscode.action('workbench.action.findInFiles', { args = { query = vim.fn.expand('<cword>') } }) end)
vim.keymap.set("n", "<leader>sg", function() vscode.action("workbench.action.quickTextSearch") end)
vim.keymap.set("n", "<leader>e", function() vscode.call('editor.action.problems.focus') end)
vim.keymap.set("n", "<leader>s.", function() vscode.action("workbench.action.openRecent") end)

-- Language Servers
vim.keymap.set("n", "<leader>gr", function() vscode.action('editor.action.goToReferences') end)
vim.keymap.set("n", "<leader>gD", function() vscode.action('editor.action.peekDeclaration') end)
vim.keymap.set("n", "<leader>gI", function() vscode.action('editor.action.goToImplementation') end)
vim.keymap.set("n", "<leader>D", function() vscode.action('editor.action.goToTypeDefinition') end)
vim.keymap.set("n", "<leader>ds", function() vscode.action('editor.action.accessibleViewGoToSymbol') end)
vim.keymap.set("n", "<leader>ws", function() vscode.action('editor.action.showAllSymbols') end)
vim.keymap.set("n", "<leader>rn", function() vscode.action('editor.action.rename') end)
vim.keymap.set("n", "<leader>ca", function() vscode.action('editor.action.quickFix') end)
-- vim.keymap.set("n", "<leader>fd", function() vscode.call('editor.action.formatDocument') end)
-- vim.keymap.set({ "n" , "v"}, "<leader>fs", function() vscode.action('editor.action.formatSelection') end)

-----------------------------------------------------------
-- General
-----------------------------------------------------------
vim.opt.mouse = "a"               -- enable mouse support
vim.opt.clipboard = "unnamedplus" -- copy/paste to system clipboard
vim.opt.swapfile = false          -- don't use swapfile
vim.opt.updatetime = 250          -- Decrease update time
vim.opt.timeoutlen = 300          -- Decrease update time
vim.opt.signcolumn = "yes"        -- Keep signcolumn on by default
-- vim.opt.spelllang = "en_us"       -- Set language
-- vim.opt.spell = true -- Set spelling

-----------------------------------------------------------
-- Neovim UI
-----------------------------------------------------------
vim.opt.splitright = true    -- vertical split to the right
vim.opt.splitbelow = true    -- Horizontal split to the bottom
vim.opt.linebreak = true     -- wrap on word boundary::
vim.opt.cursorline = true    -- Enable highlighting of the current line
vim.opt.breakindent = true   -- Enable break indent
vim.opt.inccommand = "split" -- Preview substitutions live, as you type!

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
vim.opt.history = 100     -- remember n lines in history
vim.opt.lazyredraw = true -- faster scrolling
vim.opt.synmaxcol = 500   -- max column for syntax highlight
vim.opt.undofile = true   -- Save undo history

-----------------------------------------------------------
-- Tabs, indent
-----------------------------------------------------------
-- Sets how neovim will display certain whitespace in the editor.
vim.opt.expandtab = true   -- use spaces instead of tabs
vim.opt.smartindent = true -- autoindent new lines
vim.opt.autoindent = true

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
require("lazy").setup({
  {
    {
      "windwp/nvim-autopairs",
      event = "InsertEnter",
      config = true,
      opts = {},
      -- use opts = {} for passing setup options
      -- this is equalent to setup({}) function
    },
    { -- Highlight, edit, and navigate code
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
      config = function()
        -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

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
              init_selection = "gnn",
              node_incremental = "grn",
              scope_incremental = "grc",
              node_decremental = "grm",
            },
          },
        })
      end,
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
        require("nvim-surround").setup({
          -- Configuration here, or leave empty to use defaults
        })
      end,
    },
  },
})
