-- LOAD PACKER AND PACKER PLUGINS
require "first_load"
require "plugins"

-- LOAD SETTINGS AND KEYMAPS
require "options"
require "keymaps"
require "commands"
require "user-interface"

-- LOAD PLUGINS
require "plugin.nvim-tree-config"
require "plugin.telescope-config"
require "plugin.treesitter-config"

-- LOAD LSP-config
require "lsp.mason"
require "lsp.lsp"
require "lsp.nvim-cmp-config"
require "lsp.null-ls"

-- LOAD DAP config
require "dap.dap"