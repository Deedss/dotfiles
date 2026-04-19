vim.pack.add {
  { src = 'https://github.com/echasnovski/mini.nvim' },
  { src = 'https://github.com/nvim-tree/nvim-web-devicons' },
}

require('mini.ai').setup()
require('mini.diff').setup()
require('mini.move').setup()
require('mini.statusline').setup()
require('mini.tabline').setup()
