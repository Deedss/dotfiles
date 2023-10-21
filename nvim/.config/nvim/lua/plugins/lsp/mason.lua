-- cmdline tools and lsp servers
return {
  "williamboman/mason.nvim",
  config = function ()
    local mason = require("mason")

    mason.setup({})
  end
  -- MasonInstall codelldb debugpy cmakelint cpplint jsonlint markdownlint pylint yamllint black clang-format prettier stylua
}
