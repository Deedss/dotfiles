return { -- Collection of various small independent plugins/modules
	"echasnovski/mini.nvim",
	config = function()
		-- Better Around/Inside textobjects
		-- Examples:
		--  - va)  - [V]isually select [A]round [)]parenthen
		--  - yinq - [Y]ank [I]nside [N]ext [']quote
		--  - ci'  - [C]hange [I]nside [']quote
		require("mini.ai").setup({ n_lines = 500 })

		-- Simple and easy tablin
		require("mini.tabline").setup()

		-- Movement for lines
		-- left = '<M-h>',
		-- right = '<M-l>',
		-- down = '<M-j>',
		-- up = '<M-k>',
		require("mini.move").setup()
	end,
}
