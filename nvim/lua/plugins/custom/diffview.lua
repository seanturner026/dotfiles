return {
    "dlyongemallo/diffview-plus.nvim",
    version = "*",
    cmd = {
        "DiffviewOpen",
        "DiffviewToggle",
        "DiffviewFileHistory",
        "DiffviewDiffFiles",
        "DiffviewLog",
    },
    keys = {
        { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "[G]it [D]iffview" },
        { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "[G]it file [H]istory" },
    },
    opts = {},
}
