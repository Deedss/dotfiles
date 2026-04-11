return { -- Highlight, edit, and navigate code
  {      -- Highlight, edit, and navigate code
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup({
        ignore_install = { "hoon", "ipkg" },
        auto_install = true,
        highlight = { enable = true },
        folds = { enable = true },
        indent = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "]x",
            node_incremental = "]x",
            scope_incremental = false,
            node_decremental = "[x",
          },
        },
      })
      require('nvim-treesitter').install('all')
    end,
  },
}