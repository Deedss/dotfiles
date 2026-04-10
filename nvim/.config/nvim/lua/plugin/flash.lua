vim.pack.add({ "https://github.com/folke/flash.nvim" })

require("nvim.config.nvim.lua.plugin.flash").setup({})

vim.keymap.set{{ "n", "x", "o" }, "s", function() require("nvim.config.nvim.lua.plugin.flash").jump() end, desc = "Flash" }
vim.keymap.set{{ "n", "x", "o" }, "S", function() require("nvim.config.nvim.lua.plugin.flash").treesitter() end, desc = "Flash Treesitter" }
vim.keymap.set{{ "o" }, "r", function() require("nvim.config.nvim.lua.plugin.flash").remote() end, desc = "Remote Flash" }
vim.keymap.set{{ "o", "x" }, "R", function() require("nvim.config.nvim.lua.plugin.flash").treesitter_search() end, desc = "Treesitter Search" }
vim.keymap.set{{ "c"}, "<C-s>", function() require("nvim.config.nvim.lua.plugin.flash").toggle() end, desc = "Toggle Flash Search" }
