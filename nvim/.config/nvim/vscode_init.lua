vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.opt.clipboard = 'unnamedplus'

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  defaults = {
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
  },
  require("plugins.nvim-surround"),
  require("plugins.treesitter"),
})

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Move Line up or down in Visual Mode
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- Search results centered
map("n", "n", "nzz", { silent = true })
map("n", "N", "Nzz", { silent = true })
map("n", "*", "*zz", { silent = true })
map("n", "#", "#zz", { silent = true })
map("n", "g*", "g*zz", { silent = true })

-- Jump to start and end of the line using home row
map("n", "H", "^")
map("n", "L", "$")

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- Lsp Config Mappings
vim.cmd [[
  nnoremap [d <Cmd>lua require('vscode-neovim').action('editor.action.marker.prev')<CR>
  nnoremap ]d <Cmd>lua require('vscode-neovim').action('editor.action.marker.next')<CR>
  nnoremap gD <Cmd>lua require('vscode-neovim').action('editor.action.revealDeclaration')<CR>
  nnoremap gd <Cmd>lua require('vscode-neovim').action('editor.action.revealDefinition')<CR>
  nnoremap K <Cmd>lua require('vscode-neovim').action('editor.action.showHover')<CR>
  nnoremap gi <Cmd>lua require('vscode-neovim').action('editor.action.goToImplementation')<CR>
  nnoremap <space>D <Cmd>lua require('vscode-neovim').action('editor.action.goToTypeDefinition')<CR>
  nnoremap <space>rn <Cmd>lua require('vscode-neovim').action('editor.action.rename')<CR>
  nnoremap <space>ca <Cmd>lua require('vscode-neovim').action('editor.action.quickFix')<CR>
  vnoremap <space>ca <Cmd>lua require('vscode-neovim').action('editor.action.quickFix')<CR>
  nnoremap gr <Cmd>lua require('vscode-neovim').action('editor.action.goToReferences')<CR>
  nnoremap <space>f <Cmd>lua require('vscode-neovim').action('editor.action.formatDocument')<CR>
  nnoremap <space>ds <Cmd>lua require('vscode-neovim').action('workbench.action.gotoSymbol')<CR>
  nnoremap <space>ws <Cmd>lua require('vscode-neovim').action('workbench.action.showAllSymbols')<CR>
]]

-- Telescope mappings
vim.cmd [[
  nnoremap <leader>? <Cmd>lua require('vscode-neovim').action('e)


]]
--[[
{ '<leader>?',       '<cmd>Telescope oldfiles<cr>',
{ '<leader><space>', '<cmd>Telescope buffers<cr>',
{ "<leader>fs",      "<cmd>Telescope current_buffer_fuzzy_find<cr>",
{ '<leader>fd',      '<cmd>Telescope diagnostics<cr>',
{ '<leader>ff',      '<cmd>Telescope find_files<cr>',
{ '<leader>fg',      '<cmd>Telescope live_grep<cr>',
{ '<leader>fh',      '<cmd>Telescope help_tags<cr>',
-- GIT
{ '<leader>gf',      '<cmd>Telescope git_files<cr>',
{ '<leader>gs',      '<cmd>Telescope git_status<cr>',
]]
