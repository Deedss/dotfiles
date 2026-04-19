vim.pack.add {
  { src = 'https://github.com/neovim/nvim-lspconfig' },
  { src = 'https://github.com/j-hui/fidget.nvim' },
}

require('fidget').setup()

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend('force', capabilities, require('blink.cmp').get_lsp_capabilities())

local servers = {
  clangd = {},
  cmake = {},
  pylsp = {},
  rust_analyzer = {},
  lua_ls = {
    settings = {
      Lua = {
        format = { enable = false },
        runtime = { version = 'LuaJIT' },
        workspace = {
          checkThirdParty = false,
          -- Tells lua_ls where to find all the Lua files that you have loaded
          -- for your neovim configuration.
          library = { vim.env.VIMRUNTIME },
        },
      },
    },
  },
}

-- Ensure the servers and tools above are installed
for server_name, server in pairs(servers) do
  vim.lsp.config(server_name, {
    cmd = server.cmd,
    settings = server.settings,
    filetypes = server.filetypes,
    capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {}),
  })
end

for server_name, server in pairs(servers) do
  vim.lsp.enable(server_name)
end

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
  callback = function(event)
    local map = function(mode, keys, func, desc) vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc }) end

    map({ 'n', 'v' }, 'cd', vim.lsp.buf.rename, 'Change Definition')

    -- Opens a popup that        -- Show the signature of the function you're currently completing.
    map('n', '<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

    -- The following two autocommands are used to highlight references of the
    -- word under your cursor when your cursor rests there for a little while.
    --    See `:help CursorHold` for information about when this is executed
    --
    -- When you move your cursor, the highlights will be cleared (the second autocommand).
    local client = vim.lsp.get_client_by_id(event.buf)
    if client and client.server_capabilities.documentHighlightProvider then
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        callback = vim.lsp.buf.clear_references,
      })
    end
  end,
})
