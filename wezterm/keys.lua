local wezterm = require("wezterm")
local action = wezterm.action

local function keys(config, workspace_manager)
  config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 10000 }

  local user_keys = {

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

    -- Resize panes without hitting leader multiple times
    {
      key = "r",
      mods = "LEADER",
      action = action.ActivateKeyTable({ name = "resize_pane", one_shot = false }),
    },

    -- Workspace bindings (similar to tmux sessions) — routed through workspace_manager
    -- so that switching restores tab/pane layout and scrollback.
    { mods = "CMD", key = "[", action = workspace_manager.previous_workspace() },
    { mods = "CMD", key = "]", action = workspace_manager.next_workspace() },
    { mods = "OPT", key = "v", action = workspace_manager.workspace_switcher() },
  }

  config.keys = config.keys or {}
  for _, k in ipairs(user_keys) do
    table.insert(config.keys, k)
  end

  config.key_tables = config.key_tables or {}
  config.key_tables.resize_pane = {
    { key = "h", action = action.AdjustPaneSize({ "Left", 5 }) },
    { key = "j", action = action.AdjustPaneSize({ "Down", 5 }) },
    { key = "k", action = action.AdjustPaneSize({ "Up", 5 }) },
    { key = "l", action = action.AdjustPaneSize({ "Right", 5 }) },
    { key = "Enter", action = "PopKeyTable" },
    { key = "Escape", action = "PopKeyTable" },
  }

  -- OPT + number to activate that tab
  for i = 1, 9 do
    table.insert(config.keys, {
      mods = "OPT",
      key = tostring(i),
      action = action.ActivateTab(i - 1),
    })
  end
end

return keys
