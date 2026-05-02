return {
    "esmuellert/codediff.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    cmd = "CodeDiff",
    keys = {
        { "<leader>cd", ":CodeDiff ", desc = "[C]ode [D]iff" },
    },
}
