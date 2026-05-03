return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
        picker = {
            enabled = true,
            ui_select = true,
            sources = {
                smart = {
                    multi = { "buffers", "recent", "files" },
                    matcher = { frecency = true, cwd_bonus = true },
                    filter = { cwd = true },
                },
                files = {
                    matcher = { frecency = true, cwd_bonus = true },
                },
            },
        },
    },
    keys = {
        {
            "<leader>ff",
            function()
                Snacks.picker.smart()
            end,
            desc = "[F]ind [F]iles",
        },
        {
            "<leader>fg",
            function()
                Snacks.picker.grep()
            end,
            desc = "[F]ind by [G]rep",
        },
        {
            "<leader><space>",
            function()
                Snacks.picker.buffers()
            end,
            desc = "Find existing buffers",
        },
        {
            "<leader>gl",
            function()
                Snacks.picker.git_log()
            end,
            desc = "[G]it [L]og",
        },
    },
}
