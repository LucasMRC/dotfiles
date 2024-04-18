return {
    'VonHeikemen/fine-cmdline.nvim',
    dependencies = {
        'MunifTanjim/nui.nvim'
    },
    config = function()
        require('fine-cmdline').setup({
            cmdline = {
                enable_keymaps = true,
                smart_history = true,
                prompt = ':'
            },
            popup = {
                position = {
                    row = '50%',
                    col = '50%',
                },
                size = {
                    width = '60%',
                },
                border = {
                    style = 'rounded',
                },
                win_options = {
                    winhighlight = 'Normal:Normal,FloatBorder:FloatBorder',
                },
            },
            hooks = {
                after_mount = function(input)
                    -- make escape go to normal mode
                    vim.keymap.set('i', '<Esc>', '<cmd>stopinsert<cr>', { buffer = input.bufnr })
                end
            }
        })

        vim.api.nvim_set_keymap('v', ':', ':<C-u>FineCmdline \'<,\'><CR>', { noremap = true })
        vim.api.nvim_set_keymap('n', ':', '<cmd>FineCmdline<CR>', { noremap = true })
    end
}