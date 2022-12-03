-- LOAD PACKER AND PLUGINS
require "core.first_load"
require "core.packer-config"

-- LOAD SETTINGS AND KEYMAPS
require "core.options"
require "core.keymaps"
require "core.commands"

-- -- LOAD LSP SETTINGS
require "lsp-config.lsp-config"

-- -- LOAD NVIM-DAP
-- require "nvim-dap-config.nvim-dap-config"

-- -- LOAD UI ELEMENTS
require "ui-config.colorscheme"
require "ui-config.barbar-config"
-- require "ui-config.bufferline-config"
require "ui-config.lualine-config"
-- require "ui-config.feline-config"

-- -- LOAD REMAINING PLUGINS
require "plugins.nvim-autopairs-config"
require "plugins.nvim-tree-config"
require "plugins.telescope-config"
require "plugins.toggleterm-config"
require "plugins.treesitter-config"
