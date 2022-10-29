-- LOAD PACKER AND PLUGINS
require "first_load"
require "packer-config"

-- LOAD SETTINGS AND KEYMAPS
require "options"
require "keymaps"
require "commands"

-- LOAD LSP SETTINGS
require "lsp-config"
require "nvim-cmp-config"
require "nvim-dap-config"
require "nvim-pairs-config"

-- LOAD UI ELEMENTS
require "colorscheme"
require "bufferline-config"
require "lualine-config"

-- LOAD NEOVIM EXTENSIONS
require "telescope-config"
require "toggleterm-config"

-- LOAD REMAINING
require "treesitter-config"
require "nvim-tree-config"