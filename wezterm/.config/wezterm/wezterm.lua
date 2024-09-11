-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

config.color_scheme = "catppuccin-mocha"
-- afterglow
-- Batman
--

--- TODO: I would like for the font to get adjusted depending on screen realestate.
---       I would need to get the screen resolution on decide based on that
-- config.font = wezterm.font("Iosevka Nerd Font Mono")
config.font = wezterm.font("JetbrainsMono Nerd Font")
config.font_size = 16
config.enable_tab_bar = false
config.window_decorations = "RESIZE"

-- ------------------------------------------------------
-- Start tmux when wezterm starts
-- TODO: This breaks tmux plugin manager. See why.
-- config.default_prog = { "/opt/homebrew/bin/tmux" }
-- ------------------------------------------------------

-- Start maximized
local mux = wezterm.mux

wezterm.on("gui-startup", function(cmd)
	local _, _, window = mux.spawn_window(cmd or {})
	window:gui_window():maximize()
end)

-- and finally, return the configuration to wezterm
return config
