local opts = { noremap = true, silent = true }
local desc = function(description)
	return { desc = description, noremap = true, silent = true }
end
local keymap = vim.api.nvim_set_keymap

vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", opts)

-- disable annoying commands
vim.keymap.set({ "n", "v" }, "<C-w>q", "<Nop>", opts) -- disable close window
keymap("c", "W<CR>", "w<CR>", opts) -- :W writes the file too
keymap("c", "Q<CR>", "q<CR>", opts) -- :Q closes the buffer too

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Disable arrow keys/mouse wheel
keymap("n", "<left>", '<cmd>echo "Use h to move!!"<CR>', opts)
keymap("n", "<right>", '<cmd>echo "Use l to move!!"<CR>', opts)
keymap("n", "<up>", '<cmd>echo "Use k to move!!"<CR>', opts)
keymap("n", "<down>", '<cmd>echo "Use j to move!!"<CR>', opts)
keymap("v", "<left>", '<cmd>echo "Use h to move!!"<CR>', opts)
keymap("v", "<right>", '<cmd>echo "Use l to move!!"<CR>', opts)
keymap("v", "<up>", '<cmd>echo "Use k to move!!"<CR>', opts)
keymap("v", "<down>", '<cmd>echo "Use j to move!!"<CR>', opts)
keymap("i", "<left>", '<cmd>echo "Use h to move!!"<CR>', opts)
keymap("i", "<right>", '<cmd>echo "Use l to move!!"<CR>', opts)
keymap("i", "<up>", '<cmd>echo "Use k to move!!"<CR>', opts)
keymap("i", "<down>", '<cmd>echo "Use j to move!!"<CR>', opts)

-- Cancel terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Move lines up and down
keymap("n", "<A-j>", ":m .+1<CR>==", opts)
keymap("n", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)
keymap("x", "<A-j>", ":m '>+1<CR>gv=gv", opts)
keymap("x", "<A-k>", ":m '<-2<CR>gv=gv", opts)

-- Center cursor when jumping half page
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)

-- Center cursor when moving using brackets
keymap("n", "{", "{zz", opts)
keymap("n", "}", "}zz", opts)

-- Clean search highlights
keymap("n", "<C-c>", ":noh<CR>", opts)

-- Open file tree
keymap("n", "<leader><Space>", ":NvimTreeToggle<CR>", opts)

-- Resize windows
keymap("n", "<C-Left>", ":vertical resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize -2<CR>", opts)

-- Navigate between buffers
keymap("n", "<C-PageUp>", ":bnext<CR>", opts)
keymap("n", "<C-PageDown>", ":bprevious<CR>", opts)
keymap("n", "<C-q>", ":bd<CR>", opts)

-- One-key persistent indenting
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Persistent pasting
keymap("v", "p", '"_dP', opts)

-- Move down and up by visual lines
keymap("v", "<C-j>", "gj", opts)
keymap("v", "<C-k>", "gk", opts)
keymap("n", "<C-j>", "gj", opts)
keymap("n", "<C-k>", "gk", opts)

-- Git
keymap("n", "<leader>gg", ":Git<CR>", opts)
keymap("n", "<leader>gb", ":Git blame<CR>", opts)
keymap("n", "<leader>gd", ":Gvdiffsplit<CR>", opts)

-- Autoformat
keymap("n", "<leader>==", "ggVG=<C-o>zz", opts)
-- Splits
keymap("n", "<leader>pv", "<C-w>v", desc("Split vertically"))
keymap("n", "<leader>ph", "<C-w>s", desc("Split horizontally"))
keymap("n", "<leader>pq", "<C-w>q", desc("Close window"))
keymap("n", "<leader>pe", "<C-w>=", desc("Equal size windows"))
