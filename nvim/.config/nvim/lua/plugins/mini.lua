return { -- Collection of various small independent plugins/modules
  "echasnovski/mini.nvim",
  version = false,
  config = function()
    require("mini.move").setup()
    require("mini.files").setup()
  end,
}
