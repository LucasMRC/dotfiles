local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

-- Move lines up and down
keymap("n", "<A-j>", ":m .+1<CR>==", opts)
keymap("n", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "<A-j>", ":m '>+1<CR>gv", opts)
keymap("v", "<A-k>", ":m '<-2<CR>gv", opts)
keymap("x", "<A-j>", ":m '>+1<CR>gv", opts)
keymap("x", "<A-k>", ":m '<-2<CR>gv", opts)

-- Center cursor when jumping half page
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)

-- Clean search highlights
keymap('n', '<C-c>', ':noh<CR>', opts)

-- Open file tree
keymap('n', '<leader>h', ':NvimTreeToggle<CR>', opts)

-- Window navigation
keymap('n', '<C-h>', '<C-w>h', opts)
keymap('n', '<C-j>', '<C-w>j', opts)
keymap('n', '<C-k>', '<C-w>k', opts)
keymap('n', '<C-l>', '<C-w>l', opts)

-- Resize windows
keymap('n', '<C-Left>', ':vertical resize +2<CR>', opts)
keymap('n', '<C-Down>', ':resize +2<CR>', opts)
keymap('n', '<C-Up>', ':resize -2<CR>', opts)
keymap('n', '<C-Right>', ':vertical resize -2<CR>', opts)

-- Navigate between buffers
keymap('n', '<C-PageUp>', ':bnext<CR>', opts)
keymap('n', '<C-PageDown>', ':bprevious<CR>', opts)
keymap('n', '<C-w>', ':bd<CR>', opts)

-- Persistent indenting
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)

-- Persistent pasting
keymap('v', 'p', '"_dP', opts)

-- Move down and up by visual lines
keymap('n', 'j', 'gj', opts)
keymap('n', 'k', 'gk', opts)

-- Lazygit
keymap('n', '<leader>gs', ':LazyGit<CR>', opts)
