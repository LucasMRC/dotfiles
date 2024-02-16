-- local function my_on_attach(bufnr)
    -- local api = require('nvim-tree.api')
    --
    -- local function opts(desc)
    --     return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    -- end
    -- copy default mappings here from defaults in next section
    -- vim.keymap.set('n', '<Space>', api.node.open.edit, opts('Open'))
-- end

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
    disable_netrw = true,
    hijack_netrw = true,
    actions = {
        open_file = {
            quit_on_open = true
        }
    },
    view = {
        width = 50,
        side = 'right',
        number = true
    },
    -- on_attach = my_on_attach
})
