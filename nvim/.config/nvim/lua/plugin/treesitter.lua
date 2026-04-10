vim.pack.add({
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
})

-- Install parsers (equivalent to build + config)
require("nvim-treesitter").install({ "all" })
