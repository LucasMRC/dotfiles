return {
    "ray-x/go.nvim",
    lazy = true,
    event = "VeryLazy",
    dependencies = { -- optional packages
        "ray-x/guihua.lua",
    },
    config = function()
        local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
        vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "*.go",
            callback = function()
                require("go.format").goimport()
            end,
            group = format_sync_grp,
        })
        require("go").setup({
            sp_cfg = false,        -- true: apply go.nvim non-default gopls setup
            lsp_gofumpt = false,   -- true: set default gofmt in gopls format to gofumpt
            lsp_on_attach = false, -- if a on_attach function provided:  attach on_attach function to gopls
            gopls_cmd = nil
        })
    end,
}
