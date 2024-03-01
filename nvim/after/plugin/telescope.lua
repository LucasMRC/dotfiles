local status_ok, telescope = pcall(require, 'telescope')
if not status_ok then
    print("Telescope failed to load")
    return
end

telescope.setup{
    defaults = {
        -- Default configuration for telescope goes here:
        path_display = { "truncate" },
        preview = true,
    },
    pickers = {
        find_files = {
            hidden = true,
            file_ignore_patterns = { "node_modules/", ".git/" }
        },
        live_grep = {
            hidden = true,
            file_ignore_patterns = { "node_modules/", ".git/", "%-lock.%" }
        },
        help_tags = {
            hidden = true,
            file_ignore_patterns = { "node_modules/", ".git/" }
        },
        git_files = {
            hidden = true,
            file_ignore_patterns = { "node_modules/", ".git/" }
        },
        git_branches = {
            initial_mode = "normal"
        }
    },
    extensions = {
        undo = {
            layout_config = {
                preview_width = 0.6
            },
            initial_mode = "normal",
            mappings = {
                n = {
                    ["<CR>"] = require("telescope-undo.actions").restore,
                },
                i = {
                    ["<CR>"] = require("telescope-undo.actions").restore,
                }
            }
        }
    }
}
telescope.load_extension('undo')
local builtin = require("telescope.builtin")

vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<leader>pg', builtin.git_branches, {})
vim.keymap.set('n', '<leader>ph', builtin.help_tags, {})
vim.keymap.set('n', '<leader>ps', builtin.live_grep, {}) -- requires ripgrep installed
vim.keymap.set('n', '<leader>pe', builtin.symbols, {})
vim.keymap.set('n', '<leader>pu', '<cmd>Telescope undo<CR>', {})
