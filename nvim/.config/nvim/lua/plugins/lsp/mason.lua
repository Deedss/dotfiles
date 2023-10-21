-- cmdline tools and lsp servers
return {
  "williamboman/mason.nvim",
  cmd = "Mason",
  keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
  build = ":MasonUpdate",
  opts = {
    ensure_installed = {
      -- DAP
      "codelldb",
      "debugpy",

      -- Linters
      "cmakelint",
      "cpplint",
      "jsonlint",
      "markdownlint",
      "pylint",
      "yamllint",

      -- Format
      "black",
      "clang-format",
      "prettier",
      "stylua",
    },
    automatic_installation = true
  },
}
