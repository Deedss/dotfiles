return {
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    lazy = false,
    config = function()
      vim.cmd([[colorscheme tokyonight-moon]])
    end
  },
  {
    "olimorris/onedarkpro.nvim",
    priority = 1000,
    lazy = false,
    config = function()
      -- vim.cmd([[colorscheme onedark]])
    end
  },
}
