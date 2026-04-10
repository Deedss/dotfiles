vim.pack.add({ "https://github.com/lewis6991/gitsigns.nvim" })

require("nvim.config.nvim.lua.plugin.gitsigns").setup({
    signs = {
      add = { text = "+" },
      change = { text = "~" },
      delete = { text = "_" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
    },
})
