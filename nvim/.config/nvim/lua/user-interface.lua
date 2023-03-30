local opt = vim.opt         	-- global/buffer/windows-scoped options

opt.termguicolors = true      -- enable 24-bit RGB colors
opt.background = "dark"
-- require('onedarkpro').load()
require('github-theme').setup({
  theme_style = "dimmed",
})

require('lualine').setup{}

  -- Set barbar's options
require'bufferline'.setup{}