return {
  'nvim-telescope/telescope.nvim',
  cmd = 'Telescope',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      -- NOTE: If you are having trouble with this installation,
      --       refer to the README for telescope-fzf-native for more instructions.
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
      config = function()
        require('telescope').load_extension('fzf')
      end,
    },
  },
  config = function()
    require('telescope').setup({
      defaults = {
        mappings = {
          i = {
            ['<C-u>'] = false,
            ['<C-d>'] = false,
          },
        },
      },
    })
  end,
  keys = {
    { '<leader>?', '<cmd>Telescope oldfiles<cr>', desc = '[?] Find recently opened files' },
    { '<leader><space>', '<cmd>Telescope buffers<cr>', desc = '[ ] Find existing buffers' },
    { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = '[/] Fuzzily search in current buffer' },
    { '<leader>sd', '<cmd>Telescope diagnostics<cr>', desc = '[S]earch [D]iagnostics' },
    { '<leader>sf', '<cmd>Telescope find_files<cr>', desc = '[S]earch [F]iles' },
    { '<leader>sg', '<cmd>Telescope live_grep<cr>', desc = '[S]earch by [G]rep' },
    { '<leader>sh', '<cmd>Telescope help_tags<cr>', desc = '[S]earch [H]elp' },
    { '<leader>sw', '<cmd>Telescope grep_string<cr>', desc = '[S]earch current [W]ord' },

    -- GIT
    { '<leader>gf', '<cmd>Telescope git_files<cr>', desc = 'Search [G]it [F]iles' },
    { '<leader>gs', '<cmd>Telescope git_status<cr>', desc = '[G]it [S]tatus' },
  }
}