return {
    "j-hui/fidget.nvim",
    config = function()
        local fidget = require("fidget")
        fidget.setup({
            integration = {
                ["nvim-tree"] = {
                    enable = true, -- Integrate with nvim-tree/nvim-tree.lua (if installed)
                },
            },
            notification = {
                override_vim_notify = true,
                filter = vim.log.levels.INFO,
                view = {
                    group_separator_hl = "NormalFloat",
                },
                window = {
                    normal_hl = "Normal",
                },
            },
            logger = {
                level = vim.log.levels.INFO,
            }
        })
    end,
}
