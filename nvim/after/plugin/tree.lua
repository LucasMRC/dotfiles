local function my_on_attach(bufnr)
    local api = require "nvim-tree.api"

    local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    -- default mappings
    api.config.mappings.default_on_attach(bufnr)

    -- custom mappings
    vim.keymap.set('n', 's', '<Nop>', opts('Run System'))
    vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
end

require('nvim-tree').setup({
    diagnostics = {
        enable = true,
        show_on_dirs = true,
        show_on_open_dirs = false
    },
    modified = {
        enable = true,
        show_on_open_dirs = false
    },
    git = {
        show_on_open_dirs = false
    },
    update_focused_file = {
        enable = true
    },
    renderer = {
        highlight_diagnostics = 'name',
        group_empty = true,
        icons = {
            show = {
                diagnostics = false,
                file = false,
                folder = false
            },
            git_placement = 'signcolumn'
        }
    },
    disable_netrw = true,
    hijack_netrw = true,
    actions = {
        open_file = {
            quit_on_open = true
        },
        expand_all = {
            exclude = { '.git', 'target', 'build', 'node_modules' }
        }
    },
    view = {
        width = 50,
        side = 'right',
        number = true
    },
    filters = {
        git_ignored = false,
        custom = { '^\\.git$' }
    },
    live_filter = {
        always_show_folders = false,
        prefix = '> '
    },
    on_attach = my_on_attach
})
