return { -- LSP Configuration & Plugins
    "neovim/nvim-lspconfig",
    dependencies = {
        -- Automatically install LSPs and related tools to stdpath for neovim
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("lucas-lsp-attach", { clear = true }),
            callback = function(event)
                local map = function(keys, func, desc)
                    vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
                end
                map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
                map("<leader>sr", require("telescope.builtin").lsp_references, "[S]earch [R]eferences")
                map("<leader>si", require("telescope.builtin").lsp_implementations, "[S]earch [I]mplementation")
                map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
                map("<leader>ss", require("telescope.builtin").lsp_document_symbols, "[S]earch Document [S]ymbols")
                map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
                map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
                map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
                map("K", vim.lsp.buf.hover, "Hover Documentation")
                map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

                vim.lsp.handlers["textDocument/publishDiagnostics"] =
                    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
                        virtual_text = false,
                        severity_sort = true,
                        signs = false,
                        float = {
                            source = "always",
                        },
                    })

                local _border = "single"

                vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
                    border = _border,
                })

                vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
                    border = _border,
                })

                vim.diagnostic.config({
                    float = { border = _border },
                })

                require("lspconfig.ui.windows").default_options = {
                    border = _border,
                }

                local client = vim.lsp.get_client_by_id(event.data.client_id)
                if client and client.server_capabilities.documentHighlightProvider then
                    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                        buffer = event.buf,
                        callback = vim.lsp.buf.document_highlight,
                    })

                    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                        buffer = event.buf,
                        callback = vim.lsp.buf.clear_references,
                    })
                end

                vim.api.nvim_create_autocmd("BufWritePost", {
                    callback = function(data)
                        if data.file:match("%.md$") or data.file:match("COMMIT_EDITMSG") then
                            return
                        end
                        vim.lsp.buf.format()
                    end
                })
            end,
        })

        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

        local servers = {
            lua_ls = {
                settings = {
                    Lua = {
                        diagnostics = {
                            -- Get the language server to recognize the `vim` global
                            globals = {
                                "vim",
                            },
                        },
                    },
                },
            },
        }

        require("mason").setup()

        local ensure_installed = vim.tbl_keys(servers or {})
        vim.list_extend(ensure_installed, {
            -- formatters
            "stylua", -- Used to format lua code
            "prettier",
            -- linters
            "eslint_d",
            -- "luacheck",
            "shellcheck",
            "vint",
            -- lsp servers
            "emmet_ls",
            "tsserver",
            "html",
            "cssls",
            "tailwindcss",
            "svelte",
            "gopls",
        })
        require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

        require("mason-lspconfig").setup({
            handlers = {
                function(server_name)
                    local server = servers[server_name] or {}

                    server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
                    require("lspconfig")[server_name].setup(server)
                end,
            },
        })
    end,
}
