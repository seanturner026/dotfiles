local wezterm = require("wezterm")

local config = wezterm.config_builder()

require("keys")(config)
require("options")(config)
require("tabline")(config)

return config
