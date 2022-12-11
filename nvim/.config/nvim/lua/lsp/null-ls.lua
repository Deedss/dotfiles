local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        -- Completions
        null_ls.builtins.completion.luasnip,
        null_ls.builtins.completion.tags,

        -- Diagnostics
        null_ls.builtins.diagnostics.codespell,
        null_ls.builtins.diagnostics.cpplint,

        -- Formatting
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.clang_format,
        null_ls.builtins.formatting.rustfmt,
    },
})

vim.cmd('map <Leader>lf :lua vim.lsp.buf.format()<CR>')