return {
    "olimorris/codecompanion.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        require("codecompanion").setup({
            opts = {
                strategies = {
                    chat = {
                        adapter = "anthropic",
                    },
                    inline = {
                        adapter = "anthropic",
                    },
                    cmd = {
                        adapter = "anthropic",
                    },
                },
                opts = {
                    log_level = "DEBUG",
                },
            },
            adapters = {
                acp = {
                    anthropic = function()
                        return require("codecompanion.adapters").extend("anthropic", {
                            env = {
                                api_key = "CODE_COMPANION_ANTHROPIC_KEY",
                            },
                        })
                    end,
                },
                http = {
                    anthropic = function()
                        return require("codecompanion.adapters").extend("anthropic", {
                            env = {
                                api_key = "CODE_COMPANION_ANTHROPIC_KEY",
                            },
                        })
                    end,
                },
            },
        })
    end,
}
