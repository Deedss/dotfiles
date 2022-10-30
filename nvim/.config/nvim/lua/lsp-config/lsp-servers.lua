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
lsp.dartls.setup{}
lsp.omnisharp.setup{
    cmd = { omnisharp_bin, "--languageserver" , "--hostPID", tostring(vim.fn.getpid()) },
}
lsp.pylsp.setup{}
lsp.robotframework_ls.setup{}
lsp.rust_analyzer.setup{}
lsp.vimls.setup{}
