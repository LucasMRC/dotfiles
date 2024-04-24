return {
    {
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
            require("go").setup()
        end,
    },
    {
        "mfussenegger/nvim-dap",
        ft = "go",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "theHamsta/nvim-dap-virtual-text",
            "leoluz/nvim-dap-go",
            "nvim-neotest/nvim-nio"
        },
        config = function()
            local dap = require('dap')
            local dapui = require('dapui')

            dapui.setup()
            require('dap-go').setup()
            require('nvim-dap-virtual-text').setup()
            vim.fn.sign_define('DapBreakpoint', {
                text='',
                texthl='DapBreakpoint',
                linehl='DapBreakpoint',
                numhl='DapBreakpoint'
            })

            dap.listeners.before.attach.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                dapui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                dapui.close()
            end

            vim.api.nvim_set_keymap('n', '<F5>', ":DapContinue<CR>", { noremap = true })
            vim.api.nvim_set_keymap('n', '<F10>', ":DapStepOver<CR>", { noremap = true })
            vim.api.nvim_set_keymap('n', '<F11>', ":DapStepInto<CR>", { noremap = true })
            vim.api.nvim_set_keymap('n', '<F12>', ":DapStepOut<CR>", { noremap = true })
            vim.api.nvim_set_keymap("n", "<leader>dt", ":DapUiToggle<CR>", { noremap=true })
            vim.api.nvim_set_keymap("n", "<leader>db", ":DapToggleBreakpoint<CR>", { noremap=true })
            vim.api.nvim_set_keymap("n", "<leader>dc", ":DapContinue<CR>", { noremap=true })
        end,
    },
}
