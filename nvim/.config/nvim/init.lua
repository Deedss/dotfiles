-- LOAD PACKER AND PACKER PLUGINS
require "first_load"
require "plugins"

-- LOAD SETTINGS AND KEYMAPS
require "options"
require "keymaps"
require "commands"
require "user-interface"

-- LOAD PLUGINS
require "plugin.nvim-autopairs-config"
require "plugin.nvim-tree-config"
require "plugin.telescope-config"
require "plugin.toggleterm-config"
require "plugin.treesitter-config"
require "plugin.trouble-config"

-- LOAD LSP-config
require "lsp.lsp-keymaps"
require "lsp.lsp-servers"
require "lsp.nvim-cmp-config"
require "lsp.null-ls"