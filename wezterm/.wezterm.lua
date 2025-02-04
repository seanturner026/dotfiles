local wezterm = require("wezterm")
local action = wezterm.action

local config = {}

config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 10000 }

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

config.keys = {
  { key = "f",       mods = "CTRL",      action = action.ToggleFullScreen },

  -- Navigate words like iterm
  { mods = "OPT",    key = "LeftArrow",  action = action.SendKey({ mods = "ALT", key = "b" }) },
  { mods = "OPT",    key = "RightArrow", action = action.SendKey({ mods = "ALT", key = "f" }) },
  { mods = "CMD",    key = "LeftArrow",  action = action.SendKey({ mods = "CTRL", key = "a" }) },
  { mods = "CMD",    key = "RightArrow", action = action.SendKey({ mods = "CTRL", key = "e" }) },
  { mods = "CMD",    key = "Backspace",  action = action.SendKey({ mods = "CTRL", key = "u" }) },

  -- tmux-like bindings
  { mods = "LEADER", key = "c",          action = action.SpawnTab("CurrentPaneDomain") },
  { mods = "LEADER", key = "x",          action = action.CloseCurrentPane({ confirm = true }) },
  { mods = "LEADER", key = "b",          action = action.ActivateTabRelative(-1) },
  { mods = "LEADER", key = "n",          action = action.ActivateTabRelative(1) },
  { mods = "LEADER", key = "v",          action = action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  { mods = "LEADER", key = "s",          action = action.SplitVertical({ domain = "CurrentPaneDomain" }) },
  { mods = "LEADER", key = "h",          action = action.ActivatePaneDirection("Left") },
  { mods = "LEADER", key = "j",          action = action.ActivatePaneDirection("Down") },
  { mods = "LEADER", key = "k",          action = action.ActivatePaneDirection("Up") },
  { mods = "LEADER", key = "l",          action = action.ActivatePaneDirection("Right") },

  -- Reside panes without hitting leader multiple times
  { key = "r",       mods = "LEADER",    action = action.ActivateKeyTable({ name = "resize_pane", one_shot = false }) },

  -- Workspace bindings (similar to tmux sessions)
  { mods = "CMD",    key = "[",          action = action.SwitchWorkspaceRelative(1) },
  { mods = "CMD",    key = "]",          action = action.SwitchWorkspaceRelative(1) },
  { mods = "OPT",    key = "v",          action = action.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }) },
}

config.key_tables = {
  resize_pane = {
    { key = "h",      action = action.AdjustPaneSize({ "Left", 5 }) },
    { key = "j",      action = action.AdjustPaneSize({ "Down", 5 }) },
    { key = "k",      action = action.AdjustPaneSize({ "Up", 5 }) },
    { key = "l",      action = action.AdjustPaneSize({ "Right", 5 }) },
    { key = "Enter",  action = "PopKeyTable" },
    { key = "Escape", action = "PopKeyTable" },
  },
}

-- LEADER + number to activate that tab
for i = 1, 9 do
  table.insert(config.keys, {
    mods = "LEADER",
    key = tostring(i),
    action = action.ActivateTab(i - 1),
  })
end

config.mouse_bindings = {
  {
    event = { Up = { streak = 1, button = "Left" } },
    mods = "CTRL",
    action = action.OpenLinkAtMouseCursor,
  },
}

local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")
local separators = {
  left = wezterm.nerdfonts.ple_right_half_circle_thick,
  right = wezterm.nerdfonts.ple_left_half_circle_thick,
}
local current_working_directory = { "cwd", max_length = 50, padding = { left = 0, right = 1 } }

tabline.setup({
  options = {
    icons_enabled = true,
    theme = "Tokyo Night Moon",
    color_overrides = {},
    section_separators = separators,
    component_separators = separators,
    tab_separators = separators,
  },
  sections = {
    tabline_a = { "mode" },
    tabline_b = {},
    tabline_c = { " " },
    tab_active = {
      "tab_index",
      current_working_directory,
    },
    tab_inactive = {
      {
        "tab_index",
        padding = {
          left = 0,
          right = 1,
        },
      },
      current_working_directory,
    },
    tabline_x = {},
    tabline_y = {},
    tabline_z = {},
  },
  extensions = {},
})
tabline.apply_to_config(config)

wezterm.on("format-tab-title", function(tab)
  local pane = tab.active_pane
  local title = pane.title
  if pane.domain_name then
    title = title .. " - (" .. pane.domain_name .. ")"
  end
  return title
end)

wezterm.on("update-status", function(window)
  window:set_right_status(window:active_workspace() .. "  ")
end)

config.window_padding = {
  left = 2,
  right = 2,
  top = 15,
  bottom = 0,
}

return config
