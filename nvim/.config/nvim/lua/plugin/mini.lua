-- Add the plugin
vim.pack.add({
  { src = "https://github.com/echasnovski/mini.nvim" },
})

-- Setup (only mini.ai, like your config)
require("mini.ai").setup()
