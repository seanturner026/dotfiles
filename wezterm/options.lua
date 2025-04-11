local wezterm = require("wezterm")
local action = wezterm.action

local function options(config)
  config.color_scheme = "Tokyo Night Moon"
  config.audible_bell = "Disabled"
  config.max_fps = 120

  config.font_size = 16.0
  config.font = wezterm.font("RobotoMono Nerd Font")

  config.macos_window_background_blur = 30
  config.window_background_opacity = 1.0
  config.window_decorations = "RESIZE"

  config.enable_tab_bar = true
  config.hide_tab_bar_if_only_one_tab = true
  config.use_fancy_tab_bar = false

  config.scrollback_lines = 6000
  config.quick_select_patterns = {
    "[0-9a-f]{7,40}", -- Hash default
    "[a-zA-Z0-9][a-zA-Z0-9-]+", -- More general pattern for Kubernetes resources
  }

  config.mouse_bindings = {
    {
      event = { Up = { streak = 1, button = "Left" } },
      mods = "CTRL",
      action = action.OpenLinkAtMouseCursor,
    },
  }

  config.window_padding = {
    left = 2,
    right = 2,
    top = 15,
    bottom = 0,
  }
end

return options
