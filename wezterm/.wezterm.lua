local wezterm = require("wezterm")

local config = wezterm.config_builder()

require("keys")(config)
require("keys_resurrect")(config)
require("options")(config)
require("tabline")(config)

return config
