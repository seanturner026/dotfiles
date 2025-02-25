local wezterm = require("wezterm")

local function tabs(config)
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
end

return tabs
