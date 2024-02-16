vim.g.mapleader = " "

-- Move lines up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '>-2<CR>gv=gv")

-- Center cursor when jumping half page
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Clean search highlights
vim.keymap.set('n', '<F9>', ':noh<CR>')

-- Open file tree
vim.keymap.set('n', '<leader>h', ':NvimTreeToggle<CR>')
