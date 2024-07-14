-- See `:help conform` to understand what the configuration keys do
return { -- Autoformat
  "stevearc/conform.nvim",

  config = function()
    -- Ensure formatters are installed
    local ensure_installed = vim.tbl_keys({})
    ensure_installed = {
      "black",
      "clang-format",
      "cmakelang",
      "codespell",
      "shfmt",
      "stylua",
    }
    require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
  end,
  opts = {
    notify_on_error = false,
    formatters_by_ft = {
      c = { "clang-format" },
      cpp = { " clang-format" },
      python = { "black" },
      cmake = { "cmake-format" },
      sh = { "shfmt" },
      lua = { "stylua" },
    },
  }
}
