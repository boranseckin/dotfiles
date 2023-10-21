local wezterm = require "wezterm"

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.color_scheme = "OneDark (base16)"

config.font = wezterm.font 'Hack Nerd Font Mono'
config.font_size = 13

config.scrollback_lines = 60000

config.hide_tab_bar_if_only_one_tab = true
config.quick_select_patterns = {
  "(\\w+\\/?)+(\\.\\w+)?",
}

config.keys = {
  { key = 't', mods = 'CMD|SHIFT', action = wezterm.action.ShowLauncher },
  -- Make Option-Left equivalent to Alt-b which many line editors interpret as backward-word
  {key="LeftArrow", mods="OPT", action=wezterm.action{SendString="\x1bb"}},
  -- Make Option-Right equivalent to Alt-f; forward-word
  {key="RightArrow", mods="OPT", action=wezterm.action{SendString="\x1bf"}},
}

return config
