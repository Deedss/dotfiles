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
    { '<leader>?', '<cmd>Telescope oldfiles<cr>', desc = 'Telescope: Find recently opened files' },
    { '<leader><space>', '<cmd>Telescope buffers<cr>', desc = 'Telescope: Current Buffers' },
    { "<leader>fs", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = 'Telescope: Current buffer fuzzy find' },
    { '<leader>fd', '<cmd>Telescope diagnostics<cr>', desc = 'Telescope: Diagnostics' },
    { '<leader>ff', '<cmd>Telescope find_files<cr>', desc = 'Telescope: Find Files' },
    { '<leader>fg', '<cmd>Telescope live_grep<cr>', desc = 'Telescope: Live Grep' },
    { '<leader>fh', '<cmd>Telescope help_tags<cr>', desc = 'Telescope: Help Tags' },

    -- GIT
    { '<leader>gf', '<cmd>Telescope git_files<cr>', desc = 'Telescope: Git Files' },
    { '<leader>gs', '<cmd>Telescope git_status<cr>', desc = 'Telescope: Git Status' },
  }
}
