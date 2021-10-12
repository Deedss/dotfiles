---- Leader key -> ","
--
-- In general, it's a good idea to set this early in your config, because otherwise
-- if you have any mappings you set BEFORE doing this, they will be set to the OLD
-- leader.
vim.g.mapleader = " "

------------------------------------------------------------------------------------
--  FIRST LOAD
--  setting up the Packer plugin 
------------------------------------------------------------------------------------
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd 'packadd packer.nvim'
end

------------------------------------------------------------------------------------
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
    use 'navarasu/onedark.nvim' 
    use 'marko-cerovac/material.nvim'
    
    -- Telescope
    use {
        'nvim-telescope/telescope.nvim',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    
    use {
        'kyazdani42/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons',
        config = function() require'nvim-tree'.setup {} end
    }   
    -- LSP config
    use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client

     -- TEXT MANIUPLATION
    use 'tpope/vim-fugitive' -- Git commands in nvim
    use 'tpope/vim-rhubarb' -- Fugitive-companion to interact with github
    use 'tpope/vim-commentary' -- "gc" to comment visual regions/lines
    use "godlygeek/tabular" -- Quickly align text by pattern
    use 'tpope/vim-surround'
    -- use 'blackCauldron7/surround.nvim'
    -- Highlight, edit, and navigate code using a fast incremental parsing library

    use 'nvim-treesitter/nvim-treesitter'

    use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
    use 'hrsh7th/cmp-nvim-lsp'

    use {
      'hoob3rt/lualine.nvim',
      requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }

    use {'akinsho/bufferline.nvim', requires = 'kyazdani42/nvim-web-devicons'}

    use 'mfussenegger/nvim-dap'
end)

require('telescope').load_extension('fzf')

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
require("bufferline").setup{}
require('lualine').setup {
  options = {
      -- theme = 'onedark'
      theme = 'material-nvim'
  }
}

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

-- Easy select all of file
map("n", "<Leader>sa", "ggVG<c-$>")

-- Make visual yanks place the cursor back where started
map("v", "y", "ygv<Esc>")

-- switch buffers in Normal mode
map("n", "<Tab>", ":bnext<CR>")
map("n", "<S-Tab>", ":bprevious<CR>")
map("n", "<leader><leader>", "<C-^>")

-- Make Y yank to end of the line
map("n", "Y", "y$")

-- Automatically go to current directory
map("n", "<leader>cd", ":cd %:p:h<CR>")

--After searching, pressing escape stops the highlight
map("n", "<esc>", ":noh<cr><esc>", { silent = true })

-- map navigation between splits using <C-{h,j,k,l}>
map("n", "<C-k>", [[<Cmd> wincmd k<CR>]])
map("n", "<C-l>", [[<Cmd> wincmd l<CR>]])
map("n", "<C-h>", [[<Cmd> wincmd h<CR>]])
map("n", "<C-j>", [[<Cmd> wincmd j<CR>]])

map("v", "J" ,":m '>+1<CR>gv=gv")
map("v" ,"K", ":m '<-2<CR>gv=gv")

-- " Useful mappings for managing tabs
map("n", "<leader>te", ":tabedit<Space>")
map("n", "<leader>tm", ":tabm<Space>")
map("n", "<leader>td", ":tabclose<CR>")
map("n", "<leader>tl", ":tabnext<CR>")
map("n", "<leader>th", ":tabprev<CR>")
map("n", "<leader>tn", ":tabnew<space>")

-- save
map("n", "zz", [[<Cmd> w<CR>]], { silent = true })

map("t", "<Esc>", [[<C-\><C-n>]], { silent = true })

-- horizontal & vertical resize
map("n", "+", [[<Cmd> vertical resize +5<CR>]])
map("n", "_", [[<Cmd> vertical resize -5<CR>]])
map("n", "<leader>=", [[<Cmd> resize +5<CR>]])
map("n", "<leader>-", [[<Cmd> resize -5<CR>]])

map('n', '<leader>wv', [[<Cmd>vsplit<CR>]])
map('n', '<leader>wh', [[<Cmd>split<CR>]])

-- Easier indenting control in visual mode
map('v', '>', '>gv')
map('v', '<', '<gv')

-- Ctrl+t to open an integrated terminal in a split, like other IDEs
map('n', '<leader>t', ':vsplit | set nonumber norelativenumber | terminal<CR>:set nobuflisted<CR>a', {silent = true})

-- Keeping it centered
map("n","n", "nzzzv")
map("n","N", "Nzzzv")
map("n", "J", "mzJ'z")

map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", "!", "!<c-g>u")
map("i", "?", "?<c-g>u")

map("n", "<leader>p", "0p")
map("n", "<leader>P", "0P")
--------------------------------------------------------
-- Telescope Keymaps
--------------------------------------------------------
local map_tele = function(key, action)
    local mode = "n"
    local rhs = string.format("<cmd>lua require('telescope.builtin').%s()<CR>", action)

    local map_options = {
        noremap = true,
        silent = true,
    }

    vim.api.nvim_set_keymap(mode, key, rhs, map_options)
end

-- Nvim
map_tele("<leader>fb", "buffers")
map_tele("<leader>fi", "find_files")
map_tele("<leader>fs", "file_browser")
map_tele("<leader>fg", "live_grep")
map_tele("<leader>fh", "help_tags")
map_tele("<leader>ff", "current_buffer_fuzzy_find")
map_tele("<leader>gp", "grep_prompt")

-- Git
map_tele("<leader>gs", "git_status")
map_tele("<leader>gc", "git_commits")

-----------------------------------------------------------------------------------
-- LANGUAGE SERVER PROTOCOL 
-- Contains all settings for the LSP configurations
-----------------------------------------------------------------------------------
local nvim_lsp = require 'lspconfig'
local on_attach = function(_, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'v', '<leader>ca', '<cmd>lua vim.lsp.buf.range_code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>so', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end

--------------------------------------------------------------------
-- Enable the following language servers
--------------------------------------------------------------------
local servers = {'vimls', 'bashls', 'clangd','pyright', 'rust_analyzer' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

local pid = vim.fn.getpid()
local omnisharp_bin = "/home/gertjan/Tools/omnisharp-linux-x64/run"
require'lspconfig'.omnisharp.setup{
    cmd = { omnisharp_bin, "--languageserver" , "--hostPID", tostring(pid) };
}

-----------------------------------------------------------------------------------
-- NVIM Completion with LSP
-- Sets up nvim-cmp for use with LSP
-----------------------------------------------------------------------------------
-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = function(fallback)
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-n>', true, true, true), 'n')
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-p>', true, true, true), 'n')
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
  },
}
