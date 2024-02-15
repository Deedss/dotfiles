local wezterm = require("wezterm")
local act = wezterm.action

return {
	font_size = 10.0,
	-- color_scheme = "OneDark (base16)",
	warn_about_missing_glyphs = false,
	check_for_updates = false,

	window_close_confirmation = "NeverPrompt",

	initial_rows = 30,
	initial_cols = 110,

	---------------------------------------------
	------- TAB BAR SETTINGS --------------------
	---------------------------------------------
	use_fancy_tab_bar = false,
	tab_bar_at_bottom = true,

	-- Tab bar colour schemes
	colors = {
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
	},
	-----------------------------------------
	-------- KEY MAPPINGS -------------------
	-----------------------------------------
	keys = {
		-- vertical split
		{
			key = "Enter",
			mods = "CTRL|SHIFT|ALT",
			action = act.SplitVertical,
		},
		-- This will create a new split and run your default program inside it
		{
			key = "Enter",
			mods = "CTRL|SHIFT",
			action = act.SplitHorizontal,
		},
		{
			key = "H",
			mods = "CTRL|SHIFT",
			action = act.ActivatePaneDirection("Left"),
		},
		{
			key = "L",
			mods = "CTRL|SHIFT",
			action = act.ActivatePaneDirection("Right"),
		},
		{
			key = "K",
			mods = "CTRL|SHIFT",
			action = act.ActivatePaneDirection("Up"),
		},
		{
			key = "J",
			mods = "CTRL|SHIFT",
			action = act.ActivatePaneDirection("Down"),
		},
	},
}
