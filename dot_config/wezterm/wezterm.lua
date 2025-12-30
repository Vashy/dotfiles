-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- change the initial geometry for new windows
config.initial_cols = 120
config.initial_rows = 28

-- Window padding
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

-- Font
config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = 14

-- config.color_scheme = "Afterglow"
config.color_scheme = "Andromeda"

-- Disable tabs
config.enable_tab_bar = false

-- WSL
local wsl_domains = wezterm.default_wsl_domains()
-- config.default_domain = "Ubuntu"
for idx, dom in ipairs(wsl_domains) do
	if dom.name == "Ubuntu" then
		config.default_domain = dom.name
	end
end

config.audible_bell = "Disabled"

return config
