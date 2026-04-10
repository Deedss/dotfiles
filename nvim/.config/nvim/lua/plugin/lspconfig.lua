-- Add plugins (including dependency)
vim.pack.add({
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/j-hui/fidget.nvim" },
})

-- Setup dependency
require("fidget").setup({})

-- LSP attach behavior
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
  callback = function(event)
    local map = function(mode, keys, func, desc)
      vim.keymap.set(mode, keys, func, {
        buffer = event.buf,
        desc = "LSP: " .. desc,
      })
    end

    map({ "n", "v" }, "g.", vim.lsp.buf.code_action, "Code Action")
    map({ "n", "v" }, "cd", vim.lsp.buf.rename, "Change Definition")
    map("n", "<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

    map("n", "<leader>fd", function()
      vim.lsp.buf.format({ async = true })
    end, "[F]ormat")

    local client = vim.lsp.get_client_by_id(event.data.client_id)

    if client and client.server_capabilities.documentHighlightProvider then
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = event.buf,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = event.buf,
        callback = vim.lsp.buf.clear_references,
      })
    end
  end,
})

-- Capabilities (cmp integration)
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend(
  "force",
  capabilities,
  require("blink.cmp").get_lsp_capabilities()
)

-- Servers
local servers = {
  clangd = {},
  cmake = {},
  pylsp = {},
  rust_analyzer = {},
  lua_ls = {
    settings = {
      Lua = {
        runtime = { version = "LuaJIT" },
        workspace = {
          checkThirdParty = false,
          library = { vim.env.VIMRUNTIME },
        },
        defaultConfig = {
          indent_style = "space",
          indent_size = "2",
        },
      },
    },
  },
}

-- Configure servers
for server_name, server in pairs(servers) do
  vim.lsp.config(server_name, {
    cmd = server.cmd,
    settings = server.settings,
    filetypes = server.filetypes,
    capabilities = vim.tbl_deep_extend(
      "force",
      {},
      capabilities,
      server.capabilities or {}
    ),
  })
end

-- Enable servers
for server_name, _ in pairs(servers) do
  vim.lsp.enable(server_name)
end
