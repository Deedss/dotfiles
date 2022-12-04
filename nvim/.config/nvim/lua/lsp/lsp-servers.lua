--------------------------------------------------------------------
-- Enable the following language servers
--------------------------------------------------------------------
local lsp = require 'lspconfig'
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

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
    capabilities = capabilities,
}
lsp.cmake.setup{
    capabilities = capabilities,
}
lsp.pylsp.setup{
    capabilities = capabilities,
}
lsp.rust_analyzer.setup{
    capabilities = capabilities,
}