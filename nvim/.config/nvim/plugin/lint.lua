if vim.g.vscode then return end

vim.pack.add {
  { src = 'https://github.com/mfussenegger/nvim-lint' },
}

require('lint').linters_by_ft = {
  c = { 'clangtidy' },
  cpp = { 'clangtidy' },
  cmake = { 'cmakelint' },
  python = { 'ruff' },
}
