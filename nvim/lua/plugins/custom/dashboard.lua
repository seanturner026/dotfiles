return {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "Amansingh-afk/milli.nvim",
    },
    opts = {
        theme = "doom",
        config = {
            center = {
                { icon = "  ", desc = "Find File", key = "f", action = "Telescope find_files" },
                { icon = "  ", desc = "Live Grep", key = "g", action = "Telescope live_grep" },
                { icon = "  ", desc = "Recent Files", key = "r", action = "Telescope oldfiles" },
                { icon = "  ", desc = "Quit", key = "q", action = "qa" },
            },
        },
    },
    config = function(_, opts)
        require("dashboard").setup(opts)
        require("milli").dashboard({ splash = "shader", loop = true })
    end,
}
