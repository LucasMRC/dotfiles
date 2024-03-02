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
        custom = { '\\.git$' }
    },
    live_filter = {
        always_show_folders = false,
        prefix = '> '
    }
})
