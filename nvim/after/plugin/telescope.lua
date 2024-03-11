local status_ok, telescope = pcall(require, 'telescope')
if not status_ok then
    print("Telescope failed to load")
    return
end

telescope.setup{
    defaults = {
        -- Default configuration for telescope goes here:
        -- path_display = { "truncate" },
        preview = true,
        layout_strategy = "vertical",
        layout_config = {
            preview_height = 0.7,
            vertical = {
                size = {
                    height = 0.9,
                    width = 0.9
                }
            }
        },
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

vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>pb', builtin.git_branches, { desc = '[S]earch [B]ranches' })
vim.keymap.set('n', '<leader>ph', builtin.help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>pw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>pg', builtin.live_grep, { desc = '[S]earch by [G]rep' }) -- requires ripgrep installed
vim.keymap.set('n', '<leader>pd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>pe', builtin.symbols, { desc = '[S]earch [E]moji' })
vim.keymap.set('n', '<leader>pu', '<CMD>Telescope undo<CR>', { desc = '[S]earch [U]ndo' })
vim.keymap.set('n', '<leader>pb', builtin.buffers, { desc = '[S]earch existing buffers' })
vim.keymap.set('n', '<leader>pS', builtin.git_status, { desc = '' })

local wt_status_ok, git_wt = pcall(require, 'git-worktree')
if not wt_status_ok then
    print("git-worktree failed to load")
    return
else
    git_wt.setup()
    telescope.load_extension('git_worktree')
    vim.keymap.set('n', '<leader>pt', telescope.extensions.git_worktree.git_worktrees, { desc = '[S]earch [T]rees' })
    vim.keymap.set('n', '<leader>pn', telescope.extensions.git_worktree.create_git_worktree, {})
end
