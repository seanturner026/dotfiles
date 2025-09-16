local wezterm = require("wezterm")
local action = wezterm.action

local function keys(config)
  config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 10000 }
  config.keys = {

    { key = "f", mods = "CTRL", action = action.ToggleFullScreen },

    -- Claude Code newline
    { key = "Enter", mods = "SHIFT", action = wezterm.action.SendString("\n") },

    -- Navigate words like iterm
    { mods = "OPT", key = "LeftArrow", action = action.SendKey({ mods = "ALT", key = "b" }) },
    { mods = "OPT", key = "RightArrow", action = action.SendKey({ mods = "ALT", key = "f" }) },
    { mods = "CMD", key = "LeftArrow", action = action.SendKey({ mods = "CTRL", key = "a" }) },
    { mods = "CMD", key = "RightArrow", action = action.SendKey({ mods = "CTRL", key = "e" }) },
    { mods = "CMD", key = "Backspace", action = action.SendKey({ mods = "CTRL", key = "u" }) },

    -- tmux-like bindings
    { mods = "LEADER", key = "c", action = action.SpawnTab("CurrentPaneDomain") },
    { mods = "LEADER", key = "x", action = action.CloseCurrentPane({ confirm = true }) },
    { mods = "LEADER", key = "b", action = action.ActivateTabRelative(-1) },
    { mods = "LEADER", key = "n", action = action.ActivateTabRelative(1) },
    { mods = "LEADER", key = "v", action = action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
    { mods = "LEADER", key = "s", action = action.SplitVertical({ domain = "CurrentPaneDomain" }) },
    { mods = "OPT", key = "h", action = action.ActivatePaneDirection("Left") },
    { mods = "OPT", key = "j", action = action.ActivatePaneDirection("Down") },
    { mods = "OPT", key = "k", action = action.ActivatePaneDirection("Up") },
    { mods = "OPT", key = "l", action = action.ActivatePaneDirection("Right") },

    -- Reside panes without hitting leader multiple times
    {
      key = "r",
      mods = "LEADER",
      action = action.ActivateKeyTable({ name = "resize_pane", one_shot = false }),
    },

    -- Workspace bindings (similar to tmux sessions)
    { mods = "CMD", key = "[", action = action.SwitchWorkspaceRelative(1) },
    { mods = "CMD", key = "]", action = action.SwitchWorkspaceRelative(1) },
    { mods = "OPT", key = "v", action = action.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }) },
  }

  config.key_tables = {
    resize_pane = {
      { key = "h", action = action.AdjustPaneSize({ "Left", 5 }) },
      { key = "j", action = action.AdjustPaneSize({ "Down", 5 }) },
      { key = "k", action = action.AdjustPaneSize({ "Up", 5 }) },
      { key = "l", action = action.AdjustPaneSize({ "Right", 5 }) },
      { key = "Enter", action = "PopKeyTable" },
      { key = "Escape", action = "PopKeyTable" },
    },
  }

  -- LEADER + number to activate that tab
  for i = 1, 9 do
    table.insert(config.keys, {
      mods = "OPT",
      key = tostring(i),
      action = action.ActivateTab(i - 1),
    })
  end
end

return keys
