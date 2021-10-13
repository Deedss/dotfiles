" -- Leader key -> ","
" --
" -- In general, it's a good idea to set this early in your config, because otherwise
" -- if you have any mappings you set BEFORE doing this, they will be set to the OLD
" -- leader.
let mapleader = ","

"-- First Load
:lua require("first_load")

"-- Plugins
:lua require("plugins")

"-- Settings
:lua require("settings")

"-- Mappings
:lua require("my_mappings")
:lua require("telescope_mappings")

"-- LSP-config
:lua require("lsp-config")

"-- nvim-cmp
:lua require("nvim-cmp")

"-- nvim-dap
"-- require "nvim-dap"

set showmode
