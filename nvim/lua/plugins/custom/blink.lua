return {
    "saghen/blink.cmp",
    event = "VimEnter",
    version = "1.*",
    dependencies = { "rafamadriz/friendly-snippets" },
    opts = {
        keymap = {
            preset = "default",
            ["<Tab>"] = { "select_and_accept", "fallback" },
        },
        appearance = { nerd_font_variant = "mono" },
        completion = { documentation = { auto_show = false, auto_show_delay_ms = 500 } },
        cmdline = {
            keymap = { preset = "inherit" },
            completion = { menu = { auto_show = true } },
        },
        sources = { default = { "lsp", "path", "snippets", "buffer" } },
        fuzzy = { implementation = "prefer_rust_with_warning" },
    },
}
