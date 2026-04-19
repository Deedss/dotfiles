vim.pack.add {
  { src = 'https://github.com/stevearc/conform.nvim' },
}

-- See `:help conform` to understand what the configuration keys do
require('conform').setup {
  notify_on_error = false,
  default_format_opts = { lsp_format = 'fallback' },
  formatters_by_ft = {
    c = { 'clang-format' },
    cpp = { ' clang-format' },
    cmake = { 'cmake-format' },
    lua = { 'stylua' },
    python = { 'ruff' },
    rust = { 'rustfmt' },
  },
}

vim.keymap.set('n', '<leader>fd', function() require('conform').format { async = true } end, { desc = 'Format' })
