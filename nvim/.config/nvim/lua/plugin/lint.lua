-- Add the plugin
vim.pack.add({
  "https://github.com/mfussenegger/nvim-lint"
})

-- Configure it
local lint = require("nvim.config.nvim.lua.plugin.lint")

lint.linters_by_ft = {
  c = { "clangtidy" },
  cpp = { "clangtidy" },
  cmake = { "cmakelint" },
  python = { "ruff" },
}

-- Recreate the Lazy "event" behavior with autocommands
vim.api.nvim_create_autocmd(
  { "BufWritePost", "BufReadPost", "InsertLeave" },
  {
    callback = function()
      lint.try_lint()
    end,
  }
)