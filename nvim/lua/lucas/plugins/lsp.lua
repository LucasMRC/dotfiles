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
                        signs = true,
                        underline = true,
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
                    float = {
                        focusable = false,
                        border = _border,
                        source = true,
                        header = "",
                    },
                    virtual_text = false,
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
            end,
        })

        vim.api.nvim_create_autocmd("BufAdd", {
            callback = function()
                for _, buf_hndl in ipairs(vim.api.nvim_list_bufs()) do
                    if vim.api.nvim_buf_is_loaded(buf_hndl) then
                        if vim.api.nvim_buf_get_name(buf_hndl) == "" then
                           vim.api.nvim_buf_delete(buf_hndl, { force = true })
                        end
                    end
                end
            end,
        })

        vim.filetype.add({
            extension = {
                html = function()
                    local ho = vim.fn.search("{{", "nw")
                    if ho == 0 then
                        return "html"
                    end
                    return "gohtmltmpl"
                end
            }
        })

        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

        local servers = {
            lua_ls = {
                settings = {
                    Lua = {
                        runtime = {
                            -- Tell the language server which version of Lua you're using (most likely LuaJIT)
                            version = 'LuaJIT',
                            -- Setup your lua path
                            -- path = runtime_path,
                        },
                        diagnostics = {
                            globals = { 'vim' },
                            disable = { 'missing-fields' }
                        },
                        workspace = {
                            library = vim.api.nvim_get_runtime_file('', true),
                            checkThirdParty = false,
                        },
                        -- Do not send telemetry data containing a randomized but unique identifier
                        telemetry = { enable = false },
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
            "prettierd",
            -- linters
            "eslint_d",
            "luacheck",
            "shellcheck",
            -- lsp servers
            "emmet_ls",
            "tsserver",
            "html",
            "cssls",
            "tailwindcss",
            "svelte",
            "jdtls", -- java
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
