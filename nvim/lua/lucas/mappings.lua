local opts = { noremap = true, silent = true }
local desc = function(description)
	return { desc = description, noremap = true, silent = true }
end
local keymap = vim.keymap.set

-- disable annoying commands
keymap({ "n", "v" }, "<F1>", "<Nop>", opts)
keymap({ "n", "v" }, "<Space>", "<Nop>", opts)
keymap({ "n", "v" }, "<C-w>q", "<Nop>", opts) -- disable close window
keymap("c", "W<CR>", "w<CR>", opts)           -- :W writes the file too
keymap("c", "Q<CR>", "q<CR>", opts)           -- :Q closes the buffer too
keymap({ "n", "v", "i" }, "<S-left>", '<Nop>', opts)
keymap({ "n", "v", "i" }, "<S-right>", '<Nop>', opts)
keymap({ "n", "v", "i" }, "<S-up>", '<Nop>', opts)
keymap({ "n", "v", "i" }, "<S-down>", '<Nop>', opts)
keymap("n", "<C-f>", "<Nop>", opts)
keymap("n", "<C-w>q", "<Nop>", opts)

keymap({ "n", "v", "i", "c" }, "<F1>", '<Nop>', opts)
keymap({ "n", "v", "i", "c" }, "<F2>", '<Nop>', opts)
keymap({ "n", "v", "i", "c" }, "<F3>", '<Nop>', opts)
keymap({ "n", "v", "i", "c" }, "<F4>", '<Nop>', opts)
keymap({ "n", "v", "i", "c" }, "<F5>", '<Nop>', opts)
keymap({ "n", "v", "i", "c" }, "<F6>", '<Nop>', opts)
keymap({ "n", "v", "i", "c" }, "<F7>", '<Nop>', opts)
keymap({ "n", "v", "i", "c" }, "<F8>", '<Nop>', opts)
keymap({ "n", "v", "i", "c" }, "<F9>", '<Nop>', opts)
keymap({ "n", "v", "i", "c" }, "<F10>", '<Nop>', opts)

keymap({ "i" }, "<PageUp>", "<Nop>", opts)
keymap({ "i" }, "<PageDown>", "<Nop>", opts)

-- Disable arrow keys/mouse wheel
keymap({ "n", "v", "i" }, "<left>", '<Nop>', opts)
keymap({ "n", "v", "i" }, "<right>", '<Nop>', opts)
keymap({ "n", "v", "i" }, "<up>", '<Nop>', opts)
keymap({ "n", "v", "i" }, "<down>", '<Nop>', opts)

-- Diagnostic keymaps
keymap("n", "[d", vim.diagnostic.goto_prev, desc("Go to previous diagnostic"))
keymap("n", "]d", vim.diagnostic.goto_next, desc("Go to next diagnostic"))
keymap("n", "<leader>e", vim.diagnostic.open_float, desc("[E]rror messages"))

-- Cancel terminal mode
keymap("t", "<C-q>", "<C-\\><C-n>", desc("Exit terminal mode"))

-- Move lines up and down
keymap("n", "<A-j>", ":m .+1<CR>==", desc("Move line down"))
keymap("n", "<A-k>", ":m .-2<CR>==", desc("Move line up"))

keymap({ "x", "v" }, "<A-j>", ":m '>+1<CR>gv=gv", desc("Move lines down"))
keymap({ "x", "v" }, "<A-k>", ":m '<-2<CR>gv=gv", desc("Move lines up"))

-- Center cursor when jumping through the page
keymap("n", "<C-d>", "<C-d>zz", desc("Move half page down"))
keymap("n", "<C-u>", "<C-u>zz", desc("Move half page up"))
keymap("n", "n", "nzz", desc("Jump to next match"))
keymap("n", "N", "Nzz", desc("Jump to previous match"))

-- Center cursor when moving using brackets
keymap("n", "{", "[{zz", desc("Move to matching bracket"))
keymap("n", "}", "]}zz", desc("Move to matching bracket"))

-- Clean search highlights
keymap("n", "<C-c>", ":noh<CR>", desc("Clear search highlights"))

-- Open file tree
keymap("n", "<leader><Space>", ":NvimTreeToggle<CR>", desc("Toggle file tree"))

-- Resize windows
keymap("n", "<C-Left>", ":vertical resize +2<CR>", desc("Resize window left"))
keymap("n", "<C-Down>", ":resize +2<CR>", desc("Resize window down"))
keymap("n", "<C-Up>", ":resize -2<CR>", desc("Resize window up"))
keymap("n", "<C-Right>", ":vertical resize -2<CR>", desc("Resize window right"))

-- Navigate between buffers
keymap("n", "<C-PageUp>", ":bnext<CR>", desc("Next buffer"))
keymap("n", "<C-PageDown>", ":bprevious<CR>", desc("Previous buffer"))
keymap("n", "<C-q>", ":bd<CR>", desc("Close buffer"))

-- One-key persistent indenting
keymap("v", "<", "<gv", desc("Indent left"))
keymap("v", ">", ">gv", desc("Indent right"))

-- Persistent pasting
keymap("v", "p", '"_dP', desc("Paste without yanking"))

-- Copy to clipboard
keymap({ "v", "n" }, "<A-y>", "\"+y", desc("Copy to clipboard"))

-- Move down and up by visual lines
keymap({ "n", "v" }, "<C-j>", "gj", desc("Move down by visual line"))
keymap({ "n", "v" }, "<C-k>", "gk", desc("Move up by visual line"))
keymap({ "n", "v" }, "<C-l>", "$", desc("Move to end of line"))
keymap({ "n", "v" }, "<C-h>", "^", desc("Move to start of line"))

-- Autoformat
keymap("n", "<leader>=", "gg=G<C-o>", desc("Autoformat"))

-- Number increment/decrement
keymap({ "n", "v" }, "++", "<C-a>", desc("Increment number under cursor"))
keymap({ "n", "v" }, "--", "<C-x>", desc("Decrement number under cursor"))

-- Splits
keymap("n", "<leader>pv", "<C-w>v", desc("[P]ane: [V]ertical split"))
keymap("n", "<leader>ph", "<C-w>s", desc("[P]ane: [H]orizontal split"))
keymap("n", "<leader>pq", "<C-w>q", desc("[P]ane: [Q]uit"))
keymap("n", "<leader>pe", "<C-w>=", desc("[P]ane: [E]qual size"))
keymap("n", "<leader>pm", "<C-w>o", desc("[P]ane: [M]aximize"))

-- QuickFix List
keymap("n", "<leader>qn", ":cn<CR>", desc("[Q]uickFix [N]ext"))
keymap("n", "<leader>qq", ":cw<CR>", desc("[Q]uickfix list"))
