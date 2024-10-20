-- See `:help conform` to understand what the configuration keys do
return { -- Autoformat
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    notify_on_error = false,
    formatters_by_ft = {
      c = { "clang-format" },
      cpp = { " clang-format" },
      python = { "black" },
      cmake = { "cmake-format" },
    },
  }
}
