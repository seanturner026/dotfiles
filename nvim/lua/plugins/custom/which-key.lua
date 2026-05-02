return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        spec = {
            { "<leader>c", group = "[C]ode", mode = { "n", "x" } },
            { "<leader>d", group = "[D]iagnostic" },
            { "<leader>f", group = "[F]ind" },
            { "<leader>g", group = "[G]it" },
            { "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
            { "<leader>k", group = "[K]ustomize" },
            { "<leader>r", group = "[R]eplace", mode = { "n", "v" } },
            { "<leader>t", group = "[T]oggle" },
            { "gr", group = "[G]oto (LSP)" },
            { "z", group = "Fold" },
            { "zk", desc = "Peek Fold" },
            { "zM", desc = "Close all folds" },
            { "zR", desc = "Open all folds" },
        },
    },
    keys = {
        {
            "<leader>?",
            function()
                require("which-key").show({ global = false })
            end,
            desc = "Buffer Local Keymaps (which-key)",
        },
    },
}
