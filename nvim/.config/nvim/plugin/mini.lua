if vim.g.vscode then return end

vim.pack.add {
  { src = 'https://github.com/echasnovski/mini.nvim' },
  { src = 'https://github.com/nvim-tree/nvim-web-devicons' },
}

require('mini.icons').setup()
require('mini.ai').setup()
require('mini.diff').setup()
require('mini.files').setup()
require('mini.move').setup()
require('mini.statusline').setup()
require('mini.tabline').setup()

vim.keymap.set('n', '-', function() MiniFiles.open() end, { desc = 'MiniFiles Open' })
