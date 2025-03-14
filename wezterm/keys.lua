local wezterm = require("wezterm")
local action = wezterm.action

local resurrect = wezterm.plugin.require("https://github.com/MLFlexer/resurrect.wezterm")

local function keys(config)
  config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 10000 }
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
    {
      key = "r",
      mods = "LEADER",
      action = action.ActivateKeyTable({ name = "resize_pane", one_shot = false }),
    },

    -- Workspace bindings (similar to tmux sessions)
    { mods = "CMD", key = "[", action = action.SwitchWorkspaceRelative(1) },
    { mods = "CMD", key = "]", action = action.SwitchWorkspaceRelative(1) },
    { mods = "OPT", key = "v", action = action.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }) },

    {
      key = "s",
      mods = "ALT",
      action = wezterm.action_callback(function(win, pane)
        resurrect.state_manager.save_state(resurrect.workspace_state.get_workspace_state())
        resurrect.window_state.save_window_action()
        wezterm.log_info("Saved workspace")
      end),
    },
    {
      key = "r",
      mods = "ALT",
      action = wezterm.action_callback(function(win, pane)
        resurrect.fuzzy_loader.fuzzy_load(win, pane, function(id, label)
          local type = string.match(id, "^([^/]+)") -- match before '/'
          id = string.match(id, "([^/]+)$")         -- match after '/'
          id = string.match(id, "(.+)%..+$")        -- remove file extention
          local opts = {
            relative = true,
            restore_text = true,
            on_pane_restore = resurrect.tab_state.default_on_pane_restore,
          }
          if type == "workspace" then
            local state = resurrect.state_manager.load_state(id, "workspace")
            resurrect.workspace_state.restore_workspace(state, opts)
          elseif type == "window" then
            local state = resurrect.state_manager.load_state(id, "window")
            resurrect.window_state.restore_window(pane:window(), state, opts)
          elseif type == "tab" then
            local state = resurrect.state_manager.load_state(id, "tab")
            resurrect.tab_state.restore_tab(pane:tab(), state, opts)
          end
        end)
      end),
    },
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
end

return keys
