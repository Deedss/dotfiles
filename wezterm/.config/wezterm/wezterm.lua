local wezterm = require("wezterm")
local config = {}

-- disable updates
config.check_for_updates = false

config.warn_about_missing_glyphs = false
config.window_close_confirmation = "NeverPrompt"

-- initial size
config.initial_rows = 30
config.initial_cols = 110

-- UI
config.use_fancy_tab_bar = false
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
config.color_scheme = "Catppuccin Macchiato"

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
	-- Panel navigation
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
	{
		key = "H",
		mods = "CTRL|SHIFT|ALT",
		action = wezterm.action.AdjustPaneSize{ "Left", 2 },
	},
	{
		key = "L",
		mods = "CTRL|SHIFT|ALT",
		action = wezterm.action.AdjustPaneSize{ "Right", 2 },
	},
	{
		key = "K",
		mods = "CTRL|SHIFT|ALT",
		action = wezterm.action.AdjustPaneSize{ "Up", 2 },
	},
	{
		key = "J",
		mods = "CTRL|SHIFT|ALT",
		action = wezterm.action.AdjustPaneSize{ "Down", 2 },
	},
}

return config
