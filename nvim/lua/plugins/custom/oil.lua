return {
    "stevearc/oil.nvim",
    cmd = "Oil",
    keys = {
        { "-", "<CMD>Oil --float<CR>", desc = "Open parent directory" },
    },
    dependencies = {
        { "nvim-tree/nvim-web-devicons" },
        {
            "malewicz1337/oil-git.nvim",
            dependencies = { "stevearc/oil.nvim" },
            opts = {
                show_file_highlights = true,
                show_directory_highlights = false,
                show_ignored_files = true,
            },
        },
    },
    opts = {
        default_file_explorer = false,
        delete_to_trash = true,
        skip_confirm_for_simple_edits = true,
        view_options = {
            show_hidden = true,
            natural_order = true,
            is_always_hidden = function(name, _)
                local hidden_files = {
                    [".."] = true,
                    [".git"] = true,
                    [".DS_Store"] = true,
                }
                return hidden_files[name] == true
            end,
        },
        float = {
            padding = 2,
            max_width = 90,
            max_height = 0,
        },
        win_options = {
            wrap = true,
            winblend = 0,
        },
        keymaps = {
            ["q"] = "actions.close",
            ["<C-c>"] = false,
            ["<C-s>"] = { "actions.select", opts = { horizontal = true }, desc = "Open the entry in a horizontal split" },
            ["<C-v>"] = { "actions.select", opts = { vertical = true }, desc = "Open the entry in a vertical split" },
        },
    },
}
