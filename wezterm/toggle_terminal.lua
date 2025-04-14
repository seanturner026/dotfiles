local wezterm = require("wezterm")

local function toggle_terminal(config)
  local terminal = wezterm.plugin.require("https://github.com/zsh-sage/toggle_terminal.wez")
  terminal.apply_to_config(config, { size = { Percent = 30 } })
end

return toggle_terminal
