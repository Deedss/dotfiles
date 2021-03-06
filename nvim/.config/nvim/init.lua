-- Leader key -> ","
--
-- In general, it's a good idea to set this early in your config, because otherwise
-- if you have any mappings you set BEFORE doing this, they will be set to the OLD
-- leader.
vim.g.mapleader = " "

-- First Load
require "first_load"

-- Plugins
require "plugins"

-- Settings
require "settings"

-- Mappings
require "my_mappings"

-- Telescope
require "telescope-settings"

-- LSP-config
require "lsp-config"

-- Treesitter
require "treesitter"

-- nvim-cmp
require "nvim-cmp"

-- nvim-dap
-- require "nvim-dap"

--nvim-toggletree
require "toggle_term"

--nvim-autopairs
require "nvim-pairs"

