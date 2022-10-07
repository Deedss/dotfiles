local wezterm = require 'wezterm'
return {
    font_size = 10.0,
    color_scheme = "OneDark (base16)",

    ---------------------------------------------
    ------- TAB BAR SETTINGS --------------------
    ---------------------------------------------
    use_fancy_tab_bar = false,
    tab_bar_at_bottom = true,

    -- Tab bar colour schemes
    colors = {
        tab_bar = {
            background = '#282c34',
            active_tab = {
                bg_color = '#282c34',
                fg_color = '#ffffff',
                intensity = 'Bold',
                italic = true,
            },
            inactive_tab = {
                bg_color = '#282c34',
                fg_color = '#a0a0a0',
                intensity = 'Half',
                italic = false,
            },
            new_tab = {
                bg_color = '#282c34',
                fg_color = '#a0a0a0',
            },
        },
    },
}
