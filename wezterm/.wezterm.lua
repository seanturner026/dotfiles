local wezterm = require("wezterm")
local action = wezterm.action

local config = {}

config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 10000 }

config.color_scheme = "Tokyo Night Moon"

config.audible_bell = "Disabled"
config.enable_tab_bar = true

config.font_size = 16.0
config.font = wezterm.font("RobotoMono Nerd Font")

config.macos_window_background_blur = 30
config.window_background_opacity = 1.0
config.window_decorations = "RESIZE"
config.window_padding = {
  left = 10,
  top = 10,
  right = 10,
  bottom = 10,
}

config.keys = {
  {
    key = "f",
    mods = "CTRL",
    action = wezterm.action.ToggleFullScreen,
  },
  -- Navigate words like iterm
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
  -- tmux-like bindings
  {
    mods = "LEADER",
    key = "c",
    action = wezterm.action.SpawnTab("CurrentPaneDomain"),
  },
  {
    mods = "LEADER",
    key = "x",
    action = wezterm.action.CloseCurrentPane({ confirm = true }),
  },
  {
    mods = "LEADER",
    key = "b",
    action = wezterm.action.ActivateTabRelative(-1),
  },
  {
    mods = "LEADER",
    key = "n",
    action = wezterm.action.ActivateTabRelative(1),
  },
  {
    mods = "LEADER",
    key = "v",
    action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
  },
  {
    mods = "LEADER",
    key = "s",
    action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
  },
  {
    mods = "LEADER",
    key = "h",
    action = wezterm.action.ActivatePaneDirection("Left"),
  },
  {
    mods = "LEADER",
    key = "j",
    action = wezterm.action.ActivatePaneDirection("Down"),
  },
  {
    mods = "LEADER",
    key = "k",
    action = wezterm.action.ActivatePaneDirection("Up"),
  },
  {
    mods = "LEADER",
    key = "l",
    action = wezterm.action.ActivatePaneDirection("Right"),
  },
  {
    mods = "LEADER",
    key = "LeftArrow",
    action = wezterm.action.AdjustPaneSize({ "Left", 5 }),
  },
  {
    mods = "LEADER",
    key = "RightArrow",
    action = wezterm.action.AdjustPaneSize({ "Right", 5 }),
  },
  {
    mods = "LEADER",
    key = "DownArrow",
    action = wezterm.action.AdjustPaneSize({ "Down", 5 }),
  },
  {
    mods = "LEADER",
    key = "UpArrow",
    action = wezterm.action.AdjustPaneSize({ "Up", 5 }),
  },
}

config.mouse_bindings = {
  {
    event = { Up = { streak = 1, button = "Left" } },
    mods = "CTRL",
    action = wezterm.action.OpenLinkAtMouseCursor,
  },
}

return config
