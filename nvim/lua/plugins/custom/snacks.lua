return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        gh = {},
        picker = {
            enabled = true,
            ui_select = true,
            sources = {
                smart = {
                    multi = { "buffers", "recent", "files" },
                    matcher = { frecency = true, cwd_bonus = true },
                    filter = { cwd = true },
                    hidden = true,
                },
                files = {
                    matcher = { frecency = true, cwd_bonus = true },
                    hidden = true,
                },
                recent = {
                    filter = { cwd = true },
                },
            },
        },
        terminal = {},
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
            "<leader>sr",
            function()
                Snacks.picker.resume()
            end,
            desc = "[S]earch [R]esume",
        },
        {
            "<leader>gl",
            function()
                Snacks.picker.git_log()
            end,
            desc = "[G]it [L]og",
        },
        {
            "<leader>gi",
            function()
                Snacks.picker.gh_issue()
            end,
            desc = "GitHub [I]ssues (open)",
        },
        {
            "<leader>gI",
            function()
                Snacks.picker.gh_issue({ state = "all" })
            end,
            desc = "GitHub [I]ssues (all)",
        },
        {
            "<leader>gp",
            function()
                Snacks.picker.gh_pr()
            end,
            desc = "GitHub [P]ull Requests (open)",
        },
        {
            "<leader>gP",
            function()
                Snacks.picker.gh_pr({ state = "all" })
            end,
            desc = "GitHub [P]ull Requests (all)",
        },
        {
            "<leader>tt",
            function()
                Snacks.terminal.toggle()
            end,
            desc = "[T]oggle [T]erminal",
            mode = { "n", "t" },
        },
    },
}
