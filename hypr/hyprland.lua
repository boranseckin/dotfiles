------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
  output   = "",
  mode     = "preferred",
  position = "auto",
  scale    = "auto",
})


---------------------
---- MY PROGRAMS ----
---------------------

local terminal    = "uwsm app -- kitty"
local fileManager = "uwsm app -- dolphin"
local menu        = "pkill rofi || rofi -show drun"
local browser     = "uwsm app -- librewolf"
local power       = "/bin/bash ~/.config/hypr/scripts/power-controls.sh"
local volume      = "/bin/bash ~/.config/hypr/scripts/volume.sh"
local sinks       = "/usr/bin/python3 ~/.config/hypr/scripts/sinks.py"
local bluetooth   = "/bin/bash ~/.config/hypr/scripts/bluetooth.sh"

-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
  hl.exec_cmd("uwsm app -- quickshell")
  hl.exec_cmd("uwsm app -- copyq --start-server")
  hl.exec_cmd("gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'")
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("XDG_MENU_PREFIX", "arch-")
hl.env("QT_QPA_PLATFORMTHEME", "hyprqt6engine")

-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
  general = {
    gaps_in          = 5,
    gaps_out         = 20,

    border_size      = 2,

    col              = {
      active_border   = "rgba(d5edf5cc)",
      inactive_border = "rgba(595959aa)",
    },

    resize_on_border = false,

    allow_tearing    = true,

    layout           = "dwindle",
  },

  decoration = {
    rounding         = 5,
    rounding_power   = 2,

    -- Change transparency of focused and unfocused windows
    active_opacity   = 1.0,
    inactive_opacity = 1.0,

    shadow           = {
      enabled      = true,
      range        = 4,
      render_power = 3,
      color        = "rgba(1a1a1aee)",
    },

    blur             = {
      enabled  = true,
      size     = 3,
      passes   = 1,
      vibrancy = 0.1696,
    },
  },

  xwayland = {
    force_zero_scaling = true,
  }
})

-- Default curves and animations, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7, bezier = "quick" })

-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
hl.config({
  dwindle = {
    preserve_split = true,
  },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
hl.config({
  master = {
    new_status = "master",
  },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/ for more
hl.config({
  scrolling = {
    fullscreen_on_one_column = true,
  },
})

---------------
---- INPUT ----
---------------

hl.config({
  input = {
    kb_layout    = "us",

    follow_mouse = 2,
  },
})

---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + G", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd(power))
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.exec_cmd(power .. " grub"))
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd(sinks))
hl.bind(mainMod .. " + SHIFT + O", hl.dsp.exec_cmd(bluetooth))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + U", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())

-- Move focus with mainMod + hjkl
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))

-- Resize windows with mainMod + SHIFT + hjkl
hl.dsp.window.resize()
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.resize({ x = -10, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.resize({ x = 10, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.resize({ x = 0, y = -10, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.resize({ x = 0, y = 10, relative = true }), { repeating = true })

-- Move windows with mainMod + ALT + hjkl
hl.bind(mainMod .. " + ALT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + ALT + L", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + ALT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + ALT + J", hl.dsp.window.move({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
  local key = i % 10 -- 10 maps to key 0
  hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
  hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Special workspace (scratchpad)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume",
  hl.dsp.exec_cmd("wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+ && wpctl set-mute @DEFAULT_AUDIO_SINK@ 0 && " ..
    volume), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",
  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- && wpctl set-mute @DEFAULT_AUDIO_SINK@ 0 && " .. volume),
  { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle && " .. volume),
  { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl s 10%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 10%-"), { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl -p spotify play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl -p spotify play-pause"), { locked = true })

-- Screenshot
hl.bind("Print",
  hl.dsp.exec_cmd(
    'grim -g "$(slurp -d)" - | satty --filename - --output-filename ~/Pictures/ss-$(date \'+%Y%m%d-%H:%M:%S\').png'))

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Ignore maximize requests from all apps.
hl.window_rule({
  name           = "suppress-maximize-events",
  match          = { class = ".*" },

  suppress_event = "maximize",
})

hl.window_rule({
  -- Fix some dragging issues with XWayland
  name     = "fix-xwayland-drags",
  match    = {
    class      = "^$",
    title      = "^$",
    xwayland   = true,
    float      = true,
    fullscreen = false,
    pin        = false,
  },
  no_focus = true,
})

-- Steam / games: tag windows
local gameClasses = {
  "^steam_app.*",
  "gamescope",
  "tf_linux64",
  "hl2_linux",
  "RimWorldLinux",
  "FTL.*",
  "factorygame.*",
  "CoreKeeper",
  ".*Silksong",
  "Slay.the.Spire.*",
  "Dome.Keeper",
  "ck3",
}

-- Title-based game tag
local gameTitles = {
  "Terraria.*"
}


for _, class in ipairs(gameClasses) do
  hl.window_rule({
    name  = "tag-game-" .. class,
    match = { class = class },
    tag   = "+game",
  })
end

for _, title in ipairs(gameTitles) do
  hl.window_rule({
    name  = "tag-game-" .. title,
    match = { title = title },
    tag   = "+game",
  })
end

-- Games: fullscreen on workspace 5, immediate tearing
hl.window_rule({
  name       = "game-fullscreen",
  match      = { tag = "game" },
  fullscreen = true,
  workspace  = 5,
  immediate  = true,
})

-- Picture-in-Picture
hl.window_rule({
  name  = "pip-float-pin",
  match = { title = "^Picture-in-Picture$" },
  float = true,
  pin   = true,
})
