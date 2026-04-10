-- Add plugins
vim.pack.add({
  { src = "https://github.com/nvim-lualine/lualine.nvim" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
})

-- Setup
require("nvim.config.nvim.lua.plugin.lualine").setup({})
