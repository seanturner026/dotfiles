return {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "Amansingh-afk/milli.nvim",
    },
    opts = function()
        local splash = require("milli").load({ splash = "shader" })
        return {
            theme = "doom",
            config = {
                header = splash.frames[1],
                center = {
                    {
                        icon = "  ",
                        desc = "Find File",
                        key = "f",
                        action = function()
                            Snacks.picker.files()
                        end,
                    },
                    {
                        icon = "  ",
                        desc = "Live Grep",
                        key = "g",
                        action = function()
                            Snacks.picker.grep()
                        end,
                    },
                    {
                        icon = "  ",
                        desc = "Recent Files",
                        key = "r",
                        action = function()
                            Snacks.picker.recent()
                        end,
                    },
                    { icon = "  ", desc = "Quit", key = "q", action = "qa" },
                },
            },
        }
    end,
    config = function(_, opts)
        require("dashboard").setup(opts)
        require("milli").dashboard({ splash = "shader", loop = true })
    end,
}
