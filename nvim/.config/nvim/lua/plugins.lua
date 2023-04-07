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

    -- Telescope
    use { 'nvim-telescope/telescope.nvim', tag = '0.1.0', requires = {{ 'nvim-lua/plenary.nvim' }}}
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable 'make' == 1 }

    -- Treesitter
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use "danymat/neogen"
    use "github/copilot.vim"

    -- LSP config
    use {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
      "jose-elias-alvarez/null-ls.nvim"
    }
    -- Useful status updates for LSP
    use {
      'j-hui/fidget.nvim',
      config = function()
        require('fidget').setup()
      end,
    }

    -- Nvim Debug Adapter Protocol
    use {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-telescope/telescope-dap.nvim"
    }

     -- TEXT MANIPULATION
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
    use {
      'windwp/nvim-autopairs',
      config = function()
        require('nvim-autopairs').setup{}
      end,
    }

    -- Interface
    use 'olimorris/onedarkpro.nvim'
    use ({ 'projekt0n/github-nvim-theme', tag = 'v0.0.7' })
    use 'nvim-tree/nvim-web-devicons'
    use {
      "folke/trouble.nvim",
      config = function()
        require("trouble").setup {}
      end
    }
    use 'hoob3rt/lualine.nvim'
    use 'romgrk/barbar.nvim'
end)

