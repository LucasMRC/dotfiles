require('nvim-tree').setup({
    renderer = {
        icons = {
            show = {
                folder = false,
                file = false,
                git = false
            }
        },
    },
    disable_netrw = false,
    hijack_netrw = false,
})
