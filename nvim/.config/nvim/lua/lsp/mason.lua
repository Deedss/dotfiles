---- MASON SETTINGS
require("mason").setup()
require("mason-lspconfig").setup()

--- MASON

-- Language Servers
---- python-lsp-server
---- rust-analyzer
---- clangd
---- cmake-language-server
---- bash-language-server

-- DAP
---- debugpy
---- codelldb

-- Linter
---- codespell
---- cpplint

-- Formatter
---- rustfmt
---- clang-format
---- black
