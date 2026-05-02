return {
    "github/copilot.vim",
    cond = function()
        return vim.fn.filereadable(vim.fn.stdpath("config") .. "/copilot.enabled") == 1
    end,
}
