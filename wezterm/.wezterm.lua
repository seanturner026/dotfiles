local wezterm = require("wezterm")
local action = wezterm.action

return {
  audible_bell = "Disabled",
  color_scheme = "Tokyo Night Moon",
  enable_tab_bar = false,
  font_size = 16.0,
  font = wezterm.font("RobotoMono Nerd Font Mono"),
  -- font = wezterm.font("JetBrains Mono"),
  macos_window_background_blur = 30,
  window_background_opacity = 1.0,
  window_decorations = "RESIZE",
  window_padding = {
    left = 0,
    top = 0,
    right = 0,
    bottom = 0,
  },
  keys = {
    {
      key = "f",
      mods = "CTRL",
      action = wezterm.action.ToggleFullScreen,
    },
    {
      mods = "OPT",
      key = "LeftArrow",
      action = action.SendKey({
        mods = "ALT",
        key = "b",
      }),
    },
    {
      mods = "OPT",
      key = "RightArrow",
      action = action.SendKey({
        mods = "ALT",
        key = "f",
      }),
    },
    {
      mods = "CMD",
      key = "LeftArrow",
      action = action.SendKey({
        mods = "CTRL",
        key = "a",
      }),
    },
    {
      mods = "CMD",
      key = "RightArrow",
      action = action.SendKey({
        mods = "CTRL",
        key = "e",
      }),
    },
    {
      mods = "CMD",
      key = "Backspace",
      action = action.SendKey({
        mods = "CTRL",
        key = "u",
      }),
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
