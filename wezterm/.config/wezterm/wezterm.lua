-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices
config.color_scheme = "Greenscreen (dark) (terminal.sexy)"
-- config.color_scheme = "catppuccin-mocha"
-- afterglow
-- Batman
--

--- TODO: I would like for the font to get adjusted depending on screen realestate.
---       I would need to get the screen resolution on decide based on that
-- config.font = wezterm.font("Iosevka Nerd Font Mono")
config.font = wezterm.font("JetbrainsMono Nerd Font")
config.font_size = 16
config.line_height = 1.2
config.enable_tab_bar = false
config.window_decorations = "RESIZE"

-- Start maximized
local mux = wezterm.mux

wezterm.on("gui-attached", function(domain)
	-- maximize all displayed windows on startup
	local workspace = mux.get_active_workspace()
	for _, window in ipairs(mux.all_windows()) do
		if window:get_workspace() == workspace then
			window:gui_window():maximize()
		end
	end
end)

-- and finally, return the configuration to wezterm
return config
