require('dap')
require("dapui").setup{}
require("nvim-dap-virtual-text").setup()
require('telescope').load_extension('dap')

require "dap.codelldb"
require "dap.python"

--------------------------------------------------------------
-- MAPPINGS
--------------------------------------------------------------
local function map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
  end
  
  vim.fn.sign_define('DapBreakpoint', {text='🟥', texthl='', linehl='', numhl=''})
  vim.fn.sign_define('DapBreakpointRejected', {text='🟦', texthl='', linehl='', numhl=''})
  vim.fn.sign_define('DapStopped', {text='⭐️', texthl='', linehl='', numhl=''})
  map('n', '<leader>db', ':lua require"dap".toggle_breakpoint()<CR>')
  map('n', '<leader>dB', ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
  map('n', '<S-F10>', ':lua require("dap").step_out()<CR>')
  map('n', '<F10>', ':lua require("dap").step_into()<CR>')
  map('n', '<F9>', ':lua require("dap").step_over()<CR>')
  map('n', '<F5>', ':lua require("dap").continue()<CR>')
  map('n', '<leader>dk', ':lua require"dap".up()<CR>')
  map('n', '<leader>dj', ':lua require"dap".down()<CR>')
  map('n', '<leader>dc', ':lua require"dap".disconnect({ terminateDebuggee = true });require"dapui".close();require"dap".close()<CR>')
  map('n', '<leader>dr', ':lua require"dap".repl.open()<CR>')
  map('n', '<leader>dR', ':lua require"dap".repl.close()<CR>')
  
  -----------------------------------------------------------------
  ---- NVIM DAP UI
  -----------------------------------------------------------------
  map('n', '<leader>dut', ':lua require"dapui".toggle()<CR>')