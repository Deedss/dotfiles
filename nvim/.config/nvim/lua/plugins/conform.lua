return {
  'stevearc/conform.nvim',
  lazy = true,
  event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        json = { "prettier" },
        python = { "black" },
        lua = { "stylua" },
        c = { "clang-format" },
        cpp = { "clang-format" },
        rust = { "rust-fmt" },
        yaml = { "prettier" },
        markdown = { "prettier" }
      },
      format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 500,
        lsp_fallback = true,
      },
    })
  end
}
