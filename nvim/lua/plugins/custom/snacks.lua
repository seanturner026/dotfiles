return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
        picker = { enabled = true, ui_select = true },
    },
    keys = {
        {
            "<leader>ff",
            function()
                Snacks.picker.files()
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
    },
}
