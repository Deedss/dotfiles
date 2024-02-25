return { -- Collection of various small independent plugins/modules
    "echasnovski/mini.nvim",
    config = function()
        -- Better Around/Inside textobjects
        --
        -- Examples:
        --  - va)  - [V]isually select [A]round [)]parenthen
        --  - yinq - [Y]ank [I]nside [N]ext [']quote
        --  - ci'  - [C]hange [I]nside [']quote
        require("mini.ai").setup({ n_lines = 500 })

        -- Add/delete/replace surroundings (brackets, quotes, etc.)
        --
        -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
        -- - sd'   - [S]urround [D]elete [']quotes
        -- - sr)'  - [S]urround [R]eplace [)] [']
        require("mini.surround").setup()

        -- Simple and easy statusline.
        --  You could remove this setup call if you don't like it,
        --  and try some other statusline plugin
        require("mini.statusline").setup()

        -- Simple and easy tablin
        require("mini.tabline").setup()

        -- Simple and easy pairs
        require("mini.pairs").setup()

        -- Movement for lines
        -- left = '<M-h>',
        -- right = '<M-l>',
        -- down = '<M-j>',
        -- up = '<M-k>',
        require("mini.move").setup()



        -- ... and there is more!
        --  Check out: https://github.com/echasnovski/mini.nvim
    end,
}