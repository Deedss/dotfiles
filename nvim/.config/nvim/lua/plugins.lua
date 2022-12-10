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
    use 'olimorris/onedarkpro.nvim'

    -- Telescope
    use {
      'nvim-telescope/telescope.nvim', tag = '0.1.0',
      requires = { {'nvim-lua/plenary.nvim'} }
    }
    -- Toggleterm
    use {"akinsho/toggleterm.nvim"}

    -- Treesitter
    use "danymat/neogen"
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }
    use {
      'nvim-tree/nvim-tree.lua',
      requires = {
        'nvim-tree/nvim-web-devicons', -- optional, for file icons
      },
    }

    -- LSP config
    use {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
      "jose-elias-alvarez/null-ls.nvim"
    }

    -- Nvim Debug Adapter Protocol
    use {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-telescope/telescope-dap.nvim"
    }

     -- TEXT MANIUPLATION
    use {
      "ur4ltz/surround.nvim",
      config = function()
        require"surround".setup {mappings_style = "surround"}
      end
    }
    use {
      'numToStr/Comment.nvim',
      config = function()
          require('Comment').setup()
      end,
    }

    -- Nvim Completions
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-cmdline'
    use "hrsh7th/cmp-path"
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-nvim-lua'
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'
    use 'windwp/nvim-autopairs'

    use {
      "folke/trouble.nvim",
      requires = "nvim-tree/nvim-web-devicons",
    }

    -- Interface
    use {
      'hoob3rt/lualine.nvim',
      requires = {'nvim-tree/nvim-web-devicons', opt = true}
    }
    use 'nvim-tree/nvim-web-devicons'
    use {'romgrk/barbar.nvim', wants = 'nvim-web-devicons'}
end)

