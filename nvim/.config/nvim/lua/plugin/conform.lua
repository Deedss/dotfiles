vim.pack.add({
  { src = "https://github.com/stevearc/conform.nvim" }
})

require("nvim.config.nvim.lua.plugin.conform").setup({
  formatters_by_ft = {
    c = { "clang-format" },
    cpp = { "clang-format" },
    cmake = { "cmake-format" },
    python = { "ruff" },
    rust = { "rustfmt", lsp_format = "fallback" },
  },
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    require("nvim.config.nvim.lua.plugin.conform").format({ bufnr = args.buf })
  end,
})
