vim.pack.add {
  { src = "https://github.com/saghen/blink.cmp",            version = vim.version.range('1.0') },
  { src = "https://github.com/rafamadriz/friendly-snippets" }
}

require('blink.cmp').setup({
  keymap = { preset = 'super-tab' },
  completion = { documentation = { auto_show = true, auto_show_delay_ms = 200 } },
  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  },
  fuzzy = { implementation = "prefer_rust_with_warning" }
})
