-- See `:help conform` to understand what the configuration keys do
return { -- Autoformat
    "stevearc/conform.nvim",
    opts = {
        notify_on_error = false,
        format_on_save = {
            timeout_ms = 500,
            lsp_fallback = true,
        },
        formatters_by_ft = {
            lua = { "stylua" },
            c = { "clang-format" },
            cpp = { " clang-format" },
            python = { "black" },
        },
    },
}
