return {
    -- LSP Configuration & Plugins
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        -- Automatically install LSPs to stdpath for neovim
        { "mason-org/mason.nvim", config = true },
        "mason-org/mason-lspconfig.nvim",

        -- Useful status updates for LSP
        { "j-hui/fidget.nvim", opts = {} },

        -- Additional lua configuration, makes nvim stuff amazing!
        "folke/neodev.nvim",
        "saghen/blink.cmp",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
        require("mason").setup()

        local servers = {
            rust_analyzer = {},
            bashls = {},
            docker_compose_language_service = {},
            dockerls = {},
            harper_ls = {
                filetypes = { "markdown", "gitcommit", "text" },
            },
            helm_ls = {},
            html = { filetypes = { "html", "twig", "hbs" } },
            jsonls = {},
            lua_ls = {
                settings = {
                    Lua = {
                        workspace = { checkThirdParty = false },
                        telemetry = { enable = false },
                        diagnostics = {
                            disable = { "missing-fields" },
                            globals = {
                                "vim",
                                "require",
                            },
                        },
                    },
                },
            },
            postgres_lsp = {},
            terraformls = {},
            svelte = {},
            ts_ls = {},
            ty = {
                settings = {
                    completions = {
                        autoImport = true,
                    },
                },
            },
            yamlls = {
                settings = {
                    redhat = { telemetry = { enabled = false } },
                    yaml = {
                        completion = true,
                        hover = true,
                        validate = true,
                        format = {
                            enable = true,
                        },
                        schemaStore = {
                            -- Must disable built-in schemaStore support to use
                            -- schemas from SchemaStore.nvim plugin
                            enable = true,
                            -- Avoid TypeError: Cannot read properties of undefined (reading "length")
                            url = "",
                        },
                        schemas = {
                            ["kubernetes"] = "*.{yaml,yml}",
                            -- JSON & YAML schemas http://schemastore.org/json/
                            ["https://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
                            ["https://json.schemastore.org/circleciconfig"] = ".circleci/**/*.{yml,yaml}",
                            ["https://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
                            ["https://json.schemastore.org/github-workflow"] = ".github/workflows/*.{yml,yaml}",
                            ["https://json.schemastore.org/kustomization.json"] = "kustomization.{yml,yaml}",
                            ["https://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
                            ["https://json.schemastore.org/stylelintrc"] = ".stylelintrc.{yml,yaml}",
                        },
                    },
                },
            },
        }

        local capabilities = require("blink.cmp").get_lsp_capabilities()
        for name, server in pairs(servers) do
            server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
            vim.lsp.config(name, server)
            vim.lsp.enable(name)
        end

        local ensure_installed = vim.tbl_keys(servers)
        vim.list_extend(ensure_installed, { "stylua" })
        require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

        require("mason-lspconfig").setup({ ensure_installed = {} })

        vim.keymap.set("n", "<leader>dh", function()
            local clients = vim.lsp.get_clients({ name = "harper_ls" })
            if #clients > 0 then
                vim.cmd("LspStop harper_ls")
                vim.notify("Harper disabled", vim.log.levels.INFO)
            else
                vim.cmd("LspStart harper_ls")
                vim.notify("Harper enabled", vim.log.levels.INFO)
            end
        end, { desc = "Toggle [H]arper" })

        vim.keymap.set("n", "<leader>dH", function()
            local bufnr = vim.api.nvim_get_current_buf()
            local clients = vim.lsp.get_clients({ name = "harper_ls", bufnr = bufnr })
            if #clients == 0 then
                vim.notify("Harper not attached to this buffer", vim.log.levels.WARN)
                return
            end
            local client = clients[1]
            local ns = vim.lsp.diagnostic.get_namespace(client.id)
            local diagnostics = vim.diagnostic.get(bufnr, { namespace = ns })
            if #diagnostics == 0 then
                vim.notify("No Harper diagnostics", vim.log.levels.INFO)
                return
            end

            -- Apply fixes bottom-up so earlier positions stay valid after each edit.
            table.sort(diagnostics, function(a, b)
                if a.lnum ~= b.lnum then
                    return a.lnum > b.lnum
                end
                return a.col > b.col
            end)

            local applied = 0
            for _, diag in ipairs(diagnostics) do
                local lsp_diag = diag.user_data and diag.user_data.lsp
                local params = {
                    textDocument = vim.lsp.util.make_text_document_params(bufnr),
                    range = {
                        start = { line = diag.lnum, character = diag.col },
                        ["end"] = { line = diag.end_lnum or diag.lnum, character = diag.end_col or diag.col },
                    },
                    context = {
                        diagnostics = lsp_diag and { lsp_diag } or {},
                        triggerKind = vim.lsp.protocol.CodeActionTriggerKind.Invoked,
                    },
                }
                local resp = client:request_sync("textDocument/codeAction", params, 1000, bufnr)
                if resp and resp.result then
                    for _, action in ipairs(resp.result) do
                        if action.edit and (action.kind == "quickfix" or action.isPreferred) then
                            vim.lsp.util.apply_workspace_edit(action.edit, client.offset_encoding)
                            applied = applied + 1
                            break
                        end
                    end
                end
            end

            vim.notify(string.format("Harper: applied %d fix%s", applied, applied == 1 and "" or "es"), vim.log.levels.INFO)
        end, { desc = "Apply all [H]arper fixes" })

        -- Whenever an LSP attaches to a buffer, we will run this function.
        --
        -- See `:help LspAttach` for more information about this autocmd event.
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("kickstart-lsp-attach-format", { clear = true }),
            -- This is where we attach the autoformatting for reasonable clients
            callback = function(event)
                local map = function(keys, func, desc, mode)
                    mode = mode or "n"
                    vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
                end
                local code_action = function()
                    require("tiny-code-action").code_action()
                end
                map("<leader>ca", code_action, "[C]ode [A]ction", { "n", "x" })
                map("gra", code_action, "[G]oto Code [A]ction", { "n", "x" })
                map("grr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
                map("gri", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
                map("grd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
                map("gO", require("telescope.builtin").lsp_document_symbols, "Open Document Symbols")
                map("grt", require("telescope.builtin").lsp_type_definitions, "[G]oto [T]ype Definition")

                local function client_supports_method(client, method, bufnr)
                    if vim.fn.has("nvim-0.11") == 1 then
                        return client:supports_method(method, bufnr)
                    else
                        return client.supports_method(method, { bufnr = bufnr })
                    end
                end

                local client = vim.lsp.get_client_by_id(event.data.client_id)
                if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
                    local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
                    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                        buffer = event.buf,
                        group = highlight_augroup,
                        callback = vim.lsp.buf.document_highlight,
                    })

                    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                        buffer = event.buf,
                        group = highlight_augroup,
                        callback = vim.lsp.buf.clear_references,
                    })

                    vim.api.nvim_create_autocmd("LspDetach", {
                        group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
                        callback = function(event2)
                            vim.lsp.buf.clear_references()
                            vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
                        end,
                    })
                end
                if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
                    map("<leader>th", function()
                        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
                    end, "[T]oggle Inlay [H]ints")
                end
            end,
        })
    end,
}
