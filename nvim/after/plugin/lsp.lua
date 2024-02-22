local lsp = require('lsp-zero')

lsp.preset("recommended")

-- Disables inline diagnostics 
vim.diagnostic.config({
  virtual_text = false
})

lsp.on_attach(function(_, bufnr)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    -- Adds diagnostics on space key
    vim.keymap.set('n', '<leader>', function() vim.diagnostic.open_float(nil, { focus = false }) end, opts)

    lsp.default_keymaps({
        buffer = bufnr,
        preserve_mappings = false
    })
end)

require('mason').setup({})
require('mason-lspconfig').setup({
    handlers = {
        lsp.default_setup,
        ["lua_ls"] = function ()
            local lspconfig = require("lspconfig")
            lspconfig.lua_ls.setup {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" }
                        }
                    }
                }
            }
        end,
    }
})
