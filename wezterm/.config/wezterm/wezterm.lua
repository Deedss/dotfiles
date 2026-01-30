local wezterm = require("wezterm")
local config = {}

local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")
tabline.setup({
	sections = {
		tabline_a = { nil },
		tabline_b = { nil },
		tabline_c = { nil },
		tab_active = {
			{ 'parent',  padding = 0,                      max_length = 8 },
			'/',
			{ 'cwd',     padding = { left = 0, right = 1 } },
			{ 'process', icons_enabled = false,            padding = { left = 1, right = 1 } },
		},
		tab_inactive = {
			{ 'parent',  padding = 0,                      max_length = 8 },
			'/',
			{ 'cwd',     padding = { left = 0, right = 1 } },
			{ 'process', icons_enabled = false,            padding = { left = 1, right = 1 } },
			{ 'output' },
		},
		tabline_x = { 'ram', 'cpu' },
		tabline_y = { nil },
		tabline_z = { 'domain' },
	},
	extensions = {},
})
tabline.apply_to_config(config)

-- disable updates
config.check_for_updates = false

config.warn_about_missing_glyphs = false
config.window_close_confirmation = "NeverPrompt"

-- initial size
config.initial_rows = 30
config.initial_cols = 110

-- UI
config.window_decorations = "NONE"
config.tab_bar_at_bottom = true
config.font_size = 9.0

-- disable blinking
config.cursor_blink_rate = 0
config.text_blink_rate = 0
config.text_blink_rate_rapid = 0

-- Fix fps
config.max_fps = 120
config.animation_fps = 120

config.window_padding = {
	left = 4,
	right = 4,
	top = 4,
	bottom = 4,
}
config.color_scheme = "Catppuccin Mocha"

-----------------------------------------
-------- KEY MAPPINGS -------------------
-----------------------------------------
config.keys = {
	-- vertical split
	{
		key = ")",
		mods = "CTRL|SHIFT",
		action = wezterm.action.SplitVertical,
	},
	-- This will create a new split and run your default program inside it
	{
		key = "(",
		mods = "CTRL|SHIFT",
		action = wezterm.action.SplitHorizontal,
	},
}

return config
