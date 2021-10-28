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
    use 'RRethy/nvim-base16'
    use 'olimorris/onedarkpro.nvim'
    use 'marko-cerovac/material.nvim'

    -- Telescope
    use {
        'nvim-telescope/telescope.nvim',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

    -- -- NVim-Tree
    -- use {
    --     'kyazdani42/nvim-tree.lua',
    --     requires = 'kyazdani42/nvim-web-devicons',
    --     config = function() require'nvim-tree'.setup {} end
    -- }

    -- Toggleterm
    use {"akinsho/toggleterm.nvim"}

    -- Treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }

    -- LSP config
    use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client

     -- TEXT MANIUPLATION
    use 'tpope/vim-fugitive' -- Git commands in nvim
    use 'tpope/vim-rhubarb' -- Fugitive-companion to interact with github
    use 'tpope/vim-commentary' -- "gc" to comment visual regions/lines
    use "godlygeek/tabular" -- Quickly align text by pattern
    -- use 'tpope/vim-surround'
    use {
        "blackCauldron7/surround.nvim",
        config = function()
            require"surround".setup {mappings_style = "surround"}
        end
    }

    -- Nvim Completions
    use 'hrsh7th/nvim-cmp'              -- Autocompletion plugin
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-nvim-lua'
    use "hrsh7th/cmp-path"

    -- Snippets
    use "rafamadriz/friendly-snippets"
    use "L3MON4D3/LuaSnip"

    -- Interface
    use {
      'hoob3rt/lualine.nvim',
      requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }
    use {'akinsho/bufferline.nvim', requires = 'kyazdani42/nvim-web-devicons'}

    -- Nvim Debug Adapter Protocol
    use "mfussenegger/nvim-dap"
    use "rcarriga/nvim-dap-ui"
    use "theHamsta/nvim-dap-virtual-text"
    use "nvim-telescope/telescope-dap.nvim"
end)

