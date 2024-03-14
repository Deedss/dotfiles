local wezterm = require("wezterm")
local config = {}

config.check_for_updates = false
config.warn_about_missing_glyphs = false
config.window_close_confirmation = "NeverPrompt"

config.initial_rows = 30
config.initial_cols = 110

config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true

config.font_size = 10.0

-- Tab bar colour schemes
config.colors = {
	-- # GitHub Dimmed
	-- [colors]
	foreground = "#adbac7",
	background = "#22272e",
	cursor_bg = "#6cb6ff",
	cursor_border = "#6cb6ff",
	cursor_fg = "#101216",
	selection_bg = "#264466",
	selection_fg = "#ffffff",

	ansi = { "#545d68", "#f47067", "#57ab5a", "#c69026", "#539bf5", "#b083f0", "#39c5cf", "#909dab" },
	brights = { "#636e7b", "#ff938a", "#6bc46d", "#daaa3f", "#6cb6ff", "#dcbdfb", "#56d4dd", "#cdd9e5" },
	tab_bar = {
		background = "#282c34",
		active_tab = {
			bg_color = "#282c34",
			fg_color = "#ffffff",
			intensity = "Bold",
			italic = true,
		},
		inactive_tab = {
			bg_color = "#282c34",
			fg_color = "#a0a0a0",
			intensity = "Half",
			italic = false,
		},
		new_tab = {
			bg_color = "#282c34",
			fg_color = "#a0a0a0",
		},
	},
}
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
	{
		key = "H",
		mods = "CTRL|SHIFT",
		action = wezterm.action.ActivatePaneDirection("Left"),
	},
	{
		key = "L",
		mods = "CTRL|SHIFT",
		action = wezterm.action.ActivatePaneDirection("Right"),
	},
	{
		key = "K",
		mods = "CTRL|SHIFT",
		action = wezterm.action.ActivatePaneDirection("Up"),
	},
	{
		key = "J",
		mods = "CTRL|SHIFT",
		action = wezterm.action.ActivatePaneDirection("Down"),
	},
}

return config
