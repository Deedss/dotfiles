vim.pack.add {
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects' },
}

-- configuration
require('nvim-treesitter-textobjects').setup {
  select = {
    -- Automatically jump forward to textobj, similar to targets.vim
    lookahead = true,
    -- You can choose the select mode (default is charwise 'v')
    --
    -- Can also be a function which gets passed a table with the keys
    -- * query_string: eg '@function.inner'
    -- * method: eg 'v' or 'o'
    -- and should return the mode ('v', 'V', or '<c-v>') or a table
    -- mapping query_strings to modes.
    selection_modes = {
      ['@function.inner'] = 'V', -- linewise
      ['@function.outer'] = 'V', -- linewise
      ['@class.outer'] = 'V', -- linewise
      ['@class.inner'] = 'V', -- linewise
      ['@parameter.outer'] = 'v', -- charwise
    },
    -- If you set this to `true` (default is `false`) then any textobject is
    -- extended to include preceding or succeeding whitespace. Succeeding
    -- whitespace has priority in order to act similarly to eg the built-in
    -- `ap`.
    --
    -- Can also be a function which gets passed a table with the keys
    -- * query_string: eg '@function.inner'
    -- * selection_mode: eg 'v'
    -- and should return true of false
    include_surrounding_whitespace = false,
    move = {
      -- whether to set jumps in the jumplist
      set_jumps = true,
    },
  },
}

-- Selects
local select = require 'nvim-treesitter-textobjects.select'
vim.keymap.set({ 'x', 'o' }, 'am', function() select.select_textobject('@function.outer', 'textobjects') end, { desc = 'select outer function' })
vim.keymap.set({ 'x', 'o' }, 'im', function() select.select_textobject('@function.inner', 'textobjects') end, { desc = 'select inner function' })
vim.keymap.set({ 'x', 'o' }, 'ac', function() select.select_textobject('@class.outer', 'textobjects') end, { desc = 'select outer class' })
vim.keymap.set({ 'x', 'o' }, 'ic', function() select.select_textobject('@class.inner', 'textobjects') end, { desc = 'select inner class' })
-- You can also use captures from other query groups like `locals.scm`
vim.keymap.set({ 'x', 'o' }, 'as', function() select.select_textobject('@local.scope', 'locals') end, { desc = 'select locals' })

-- Swaps
local swap = require 'nvim-treesitter-textobjects.swap'
vim.keymap.set('n', '<leader>a', function() swap.swap_next '@parameter.inner' end, { desc = 'swap next parameter' })
vim.keymap.set('n', '<leader>A', function() swap.swap_previous '@parameter.outer' end, { desc = 'swap previous parameter' })

local move = require 'nvim-treesitter-textobjects.move'
vim.keymap.set({ 'n', 'x', 'o' }, ']m', function() move.goto_next_start('@function.outer', 'textobjects') end, { desc = 'goto start next function' })
vim.keymap.set({ 'n', 'x', 'o' }, ']]', function() move.goto_next_start('@class.outer', 'textobjects') end, { desc = 'goto start next class' })
-- You can also pass a list to group multiple queries.
vim.keymap.set({ 'n', 'x', 'o' }, ']o', function() move.goto_next_start({ '@loop.inner', '@loop.outer' }, 'textobjects') end, { desc = 'goto start next loop' })
-- You can also use captures from other query groups like `locals.scm` or `folds.scm`
vim.keymap.set({ 'n', 'x', 'o' }, ']s', function() move.goto_next_start('@local.scope', 'locals') end, { desc = 'goto start next locals' })
vim.keymap.set({ 'n', 'x', 'o' }, ']z', function() move.goto_next_start('@fold', 'folds') end, { desc = 'goto start next fold' })

vim.keymap.set({ 'n', 'x', 'o' }, ']M', function() move.goto_next_end('@function.outer', 'textobjects') end, { desc = 'goto end next function' })
vim.keymap.set({ 'n', 'x', 'o' }, '][', function() move.goto_next_end('@class.outer', 'textobjects') end, { desc = 'goto end next class' })

vim.keymap.set({ 'n', 'x', 'o' }, '[m', function() move.goto_previous_start('@function.outer', 'textobjects') end, { desc = 'goto start previous function' })
vim.keymap.set({ 'n', 'x', 'o' }, '[[', function() move.goto_previous_start('@class.outer', 'textobjects') end, { desc = 'goto start previous class' })

vim.keymap.set({ 'n', 'x', 'o' }, '[M', function() move.goto_previous_end('@function.outer', 'textobjects') end, { desc = 'goto end previous function' })
vim.keymap.set({ 'n', 'x', 'o' }, '[]', function() move.goto_previous_end('@class.outer', 'textobjects') end, { desc = 'goto end previous class' })

local ts_repeat_move = require 'nvim-treesitter-textobjects.repeatable_move'

-- Repeat movement with ; and ,
-- ensure ; goes forward and , goes backward regardless of the last direction
vim.keymap.set({ 'n', 'x', 'o' }, ';', ts_repeat_move.repeat_last_move_next, { desc = 'repeat last move next' })
vim.keymap.set({ 'n', 'x', 'o' }, ',', ts_repeat_move.repeat_last_move_previous, { desc = 'repeat last move previous' })

-- Optionally, make builtin f, F, t, T also repeatable with ; and ,
vim.keymap.set({ 'n', 'x', 'o' }, 'f', ts_repeat_move.builtin_f_expr, { expr = true })
vim.keymap.set({ 'n', 'x', 'o' }, 'F', ts_repeat_move.builtin_F_expr, { expr = true })
vim.keymap.set({ 'n', 'x', 'o' }, 't', ts_repeat_move.builtin_t_expr, { expr = true })
vim.keymap.set({ 'n', 'x', 'o' }, 'T', ts_repeat_move.builtin_T_expr, { expr = true })
