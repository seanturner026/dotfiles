return {
    "Automattic/harper",
    config = function()
        require("lspconfig").harper_ls.setup({})
    end,
}
