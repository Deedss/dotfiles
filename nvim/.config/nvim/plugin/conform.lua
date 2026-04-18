vim.pack.add({
    { src = "https://github.com/stevearc/conform.nvim" }
})

-- See `:help conform` to understand what the configuration keys do
require('conform').setup({
    notify_on_error = false,
    formatters_by_ft = {
        c = { "clang-format" },
        cpp = { " clang-format" },
        cmake = { "cmake-format" },
        python = { "ruff" },
        rust = { "rustfmt", lsp_format = "fallback" },
    }
})