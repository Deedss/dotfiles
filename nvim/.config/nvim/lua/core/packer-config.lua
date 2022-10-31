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
        'nvim-telescope/telescope.nvim',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

    -- Toggleterm
    use {"akinsho/toggleterm.nvim"}

    -- Treesitter
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
      'jose-elias-alvarez/null-ls.nvim'
    }
    -- use 'simrat39/rust-tools.nvim'

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
    use {
      'hrsh7th/nvim-cmp',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lua',
      "hrsh7th/cmp-path",
      'windwp/nvim-autopairs',
    }

    -- Interface
    use {
      'hoob3rt/lualine.nvim',
      requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }
    use {'akinsho/bufferline.nvim', tag = "*", requires = 'kyazdani42/nvim-web-devicons'}


end)

