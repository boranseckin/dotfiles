local wezterm = require "wezterm"

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.color_scheme = "OneDark (base16)"

config.hide_tab_bar_if_only_one_tab = true

config.keys = {
  { key = 't', mods = 'CMD|SHIFT', action = wezterm.action.ShowLauncher },
}

return config
