local wezterm = require("wezterm")
local config = {}

-- disable updates
config.check_for_updates = false

-- disable warnings
config.warn_about_missing_glyphs = false
config.window_close_confirmation = "NeverPrompt"

-- initial size
config.initial_rows = 30
config.initial_cols = 110

-- UI
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.font_size = 10.0

-- disable blinking
config.cursor_blink_rate = 0
config.text_blink_rate = 0
config.text_blink_rate_rapid = 0

config.window_padding = {
  left = 4,
  right = 4,
  top = 6,
  bottom = 0,
}
-- config.color_scheme = "Catppuccin Frappe"
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
