return {
    "nvim-lualine/lualine.nvim", -- status line
    config = function()
        require("lualine").setup({
            options = {
                component_separators = "|",
                section_separators = "",
                theme = "palenight",
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { { "filename", path = 4 } },
                lualine_c = { { "branch", icons_enabled = true }, "diff", "diagnostics" },
                lualine_x = {
                    {
                        -- require("noice").api.status.mode.get,
                        -- cond = function()
                        --     local mode = require("noice").api.status.mode.get()
                        --     if mode == nil then
                        --         return false
                        --     else
                        --         if string.match(mode, "recording") then
                        --             return true
                        --         else
                        --             return false
                        --         end
                        --     end
                        -- end,
                        -- color = { fg = "#f0abfc" },
                    },
                },
                lualine_y = {
                    { "filetype", fmt = string.upper },
                },
                lualine_z = { "location" },
            },
        })
    end,
}
