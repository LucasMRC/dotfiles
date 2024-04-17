return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
        local hooks = require("ibl.hooks")

        hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
            vim.api.nvim_set_hl(0, "Scope", { fg = "#676e95" })
            vim.api.nvim_set_hl(0, "Indent", { fg = "#3c3c3c" })
        end)

        require("ibl").setup({
            indent = { highlight = "Indent" },
            scope = {
                highlight = "Scope",
                show_start = false,
                show_end = false,
            },
        })
    end,
}
