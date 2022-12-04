local opt = vim.opt         	-- global/buffer/windows-scoped options

opt.termguicolors = true      -- enable 24-bit RGB colors
opt.background = "dark"
require('onedarkpro').load()

-- require('lualine').setup{}