return {
  'mfussenegger/nvim-lint',
  config = function()
    -- Ensure linters are installed
    local ensure_installed = vim.tbl_keys({})
    ensure_installed = {
      "cpplint",
      "cmakelint",
      "pylint",
    }
    require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
  end,
  opts = {
    linters_by_ft = {
      c = { "cpplint" },
      cpp = { "cpplint" },
      cmake = { "cmakelint" },
      python = { "pylint" },
    },
  }
}
