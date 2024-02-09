require('telescope').setup{
		defaults = {
				-- Default configuration for telescope goes here:
				path_display = { "truncate" },
				preview = true,
		},
        pickers = {
            find_files = {
                hidden = true
            },
            live_grep = {
                hidden = true
            },
            help_tags = {
                hidden = true
            },
            git_files = {
                hidden = true
            }
        }
}
local builtin = require("telescope.builtin")

vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<leader>pg', builtin.git_files, {})
vim.keymap.set('n', '<leader>ph', builtin.help_tags, {})
vim.keymap.set('n', '<leader>ps', builtin.live_grep, {}) -- requires ripgrep installed
