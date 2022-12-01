--------------------------------------------------------------------
-- Enable the following language servers
--------------------------------------------------------------------
local lsp = require 'lspconfig'

lsp.bashls.setup{}
lsp.clangd.setup{
    cmd = {
        "clangd",
        "--background-index",
        "--suggest-missing-includes",
        "--clang-tidy",
        "--header-insertion=iwyu",
    },
    -- Required for lsp-status
    init_options = {
        clangdFileStatus = true,
    },
}
lsp.cmake.setup{}
lsp.pylsp.setup{}
lsp.rust_analyzer.setup{}
