return { -- Highlight, edit, and navigate code
  {      -- Highlight, edit, and navigate code
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup({
        ensure_installed = "all",
        ignore_install = { "hoon", "ipkg" },
        -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
        auto_install = true,
        highlight = { enable = true },

        indent = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "]x",
            node_incremental = "]x",
            scope_incremental = false,
            node_decremental = "[x",
          },
        },
      })
    end,
  },
  -- {
  --   "nvim-treesitter/nvim-treesitter-textobjects",
  --   after = "nvim-treesitter",
  --   requires = "nvim-treesitter/nvim-treesitter",
  --   config = function()
  --     require 'nvim-treesitter.configs'.setup({
  --       textobjects = {
  --         move = {
  --           enable = true,
  --           goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer", ["]a"] = "@parameter.inner" },
  --           goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
  --           goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer", ["[a"] = "@parameter.inner" },
  --           goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer", ["[A"] = "@parameter.inner" },
  --         },
  --       },
  --     })
  --   end
  -- },
}
