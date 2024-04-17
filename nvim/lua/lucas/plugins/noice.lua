return {
    "folke/noice.nvim",
    event = "VeryLazy",
    config = function()
        require("noice").setup({
            messages = {
                view = "mini",
                view_error = "mini",
                view_warn = "mini",
            },
            notify = {
                view = "mini",
            },
            lsp = {
                message = {
                    view = "mini",
                },
                -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
                },
            },
            routes = {
                {
                    filter = { event = "notify", find = "No information available" },
                    opts = { skip = true },
                },
                {
                    filter = {
                        event = "msg_show",
                        find = "written",
                    },
                    opts = { skip = true },
                },
                {
                    filter = {
                        event = "msg_show",
                        find = "changes",
                    },
                    opts = { skip = true },
                },
                {
                    filter = {
                        event = "msg_show",
                        find = "lines",
                    },
                    opts = { skip = true },
                },
            },
        })
    end,
    dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
    },
}