-- LUALINE
return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		options = {
			icons_enabled = false,
			component_separators = "|",
			section_separators = "",
		},
	},
}
