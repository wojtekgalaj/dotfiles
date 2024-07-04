-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

config.color_scheme = "catppuccin-mocha"
-- afterglow
-- Batman
--

config.font = wezterm.font("Iosevka Nerd Font Mono")
config.font_size = 21
config.enable_tab_bar = false

-- ------------------------------------------------------
-- Start tmux when wezterm starts
-- TODO: This breaks tmux plugin manager. See why.
-- config.default_prog = { "/opt/homebrew/bin/tmux" }
-- ------------------------------------------------------

-- Start maximized
local mux = wezterm.mux

wezterm.on("gui-startup", function(cmd)
	-- local tab, pane, window = mux.spawn_window(cmd or {})
	local _, _, window = mux.spawn_window(cmd or {})
	window:gui_window():toggle_fullscreen()
end)

-- and finally, return the configuration to wezterm
return config
