local wezterm = require("wezterm")

local workspace_manager = wezterm.plugin.require(
  "https://github.com/ryanmsnyder/workspace-manager.wezterm"
)
workspace_manager.get_choices = false

local config = wezterm.config_builder()

workspace_manager.apply_to_config(config)

require("keys")(config, workspace_manager)
require("options")(config)
require("tabline")(config)

return config
