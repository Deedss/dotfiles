return { -- Collection of various small independent plugins/modules
	"echasnovski/mini.nvim",
	config = function()
		-- Movement for lines
		-- left = '<M-h>',
		-- right = '<M-l>',
		-- down = '<M-j>',
		-- up = '<M-k>',
		require("mini.move").setup()
	end,
}
