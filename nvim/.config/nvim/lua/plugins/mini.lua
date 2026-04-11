return { -- Collection of various small independent plugins/modules
  "echasnovski/mini.nvim",
  version = false,
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("mini.ai").setup()
    require("mini.diff").setup()
    require("mini.move").setup()
    require("mini.statusline").setup()
    require("mini.tabline").setup()
  end,
}
