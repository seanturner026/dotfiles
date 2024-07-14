local wezterm = require("wezterm")
return {
  color_scheme = "Tokyo Night Moon",
  enable_tab_bar = false,
  font_size = 16.0,
  font = wezterm.font("JetBrains Mono"),
  macos_window_background_blur = 30,
  window_background_opacity = 1.0,
  window_decorations = "RESIZE",
  window_padding = {
    left = 0,
    -- top = 0,
    right = 0,
    bottom = 0,
  },
  keys = {
    {
      key = "f",
      mods = "CTRL",
      action = wezterm.action.ToggleFullScreen,
    },
  },
  mouse_bindings = {
    {
      event = { Up = { streak = 1, button = "Left" } },
      mods = "CTRL",
      action = wezterm.action.OpenLinkAtMouseCursor,
    },
  },
}
