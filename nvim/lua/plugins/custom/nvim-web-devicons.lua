return {
    "nvim-tree/nvim-web-devicons",
    lazy = false,
    priority = 999,
    config = function()
        local devicons = require("nvim-web-devicons")
        devicons.setup({
            override_by_extension = {
                yaml = { icon = "", color = "#cb171e", cterm_color = "160", name = "Yaml" },
                yml = { icon = "", color = "#cb171e", cterm_color = "160", name = "Yml" },
            },
        })

        -- Snacks picker passes full paths (e.g. "docker/compose.yaml") to
        -- get_icon, but devicons only matches icons_by_filename on the
        -- basename — so files like compose.yaml, Dockerfile, go.mod fall
        -- through to the generic page icon. Strip the directory before
        -- the filename lookup.
        local get_icon = devicons.get_icon
        devicons.get_icon = function(name, ext, opts)
            if type(name) == "string" then
                name = name:match("[^/\\]+$") or name
            end
            return get_icon(name, ext, opts)
        end

        local get_icon_color = devicons.get_icon_color
        devicons.get_icon_color = function(name, ext, opts)
            if type(name) == "string" then
                name = name:match("[^/\\]+$") or name
            end
            return get_icon_color(name, ext, opts)
        end
    end,
}
