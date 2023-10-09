local wezterm = require "wezterm"

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.color_scheme = "OneDark (base16)"

config.scrollback_lines = 60000

config.hide_tab_bar_if_only_one_tab = true
config.quick_select_patterns = {
  "(\\w+\\/?)+(\\.\\w+)?",
}

config.keys = {
  { key = 't', mods = 'CMD|SHIFT', action = wezterm.action.ShowLauncher },
}

return config
