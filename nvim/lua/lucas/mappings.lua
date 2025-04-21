-- disable annoying commands
Keymap({ "n", "v" }, "<F1>", "<Nop>", Opts)
Keymap({ "n", "v" }, "<Space>", "<Nop>", Opts)
Keymap({ "n", "v" }, "<C-w>q", "<Nop>", Opts) -- disable close window
Keymap("c", "W<CR>", "w<CR>", Opts)           -- :W writes the file too
Keymap("c", "Q<CR>", "q<CR>", Opts)           -- :Q closes the buffer too
Keymap({ "n", "v", "i" }, "<S-left>", '<Nop>', Opts)
Keymap({ "n", "v", "i" }, "<S-right>", '<Nop>', Opts)
Keymap({ "n", "v", "i" }, "<S-up>", '<Nop>', Opts)
Keymap({ "n", "v", "i" }, "<S-down>", '<Nop>', Opts)
Keymap("n", "<C-f>", "<Nop>", Opts)
Keymap("n", "<C-w>q", "<Nop>", Opts)

Keymap({ "n", "v", "i", "c" }, "<F1>", '<Nop>', Opts)
Keymap({ "n", "v", "i", "c" }, "<F2>", '<Nop>', Opts)
Keymap({ "n", "v", "i", "c" }, "<F3>", '<Nop>', Opts)
Keymap({ "n", "v", "i", "c" }, "<F4>", '<Nop>', Opts)
Keymap({ "n", "v", "i", "c" }, "<F5>", '<Nop>', Opts)
Keymap({ "n", "v", "i", "c" }, "<F6>", '<Nop>', Opts)
Keymap({ "n", "v", "i", "c" }, "<F7>", '<Nop>', Opts)
Keymap({ "n", "v", "i", "c" }, "<F8>", '<Nop>', Opts)
Keymap({ "n", "v", "i", "c" }, "<F9>", '<Nop>', Opts)
Keymap({ "n", "v", "i", "c" }, "<F10>", '<Nop>', Opts)

Keymap({ "i" }, "<PageUp>", "<Nop>", Opts)
Keymap({ "i" }, "<PageDown>", "<Nop>", Opts)

-- Disable arrow keys/mouse wheel
Keymap({ "n", "v", "i" }, "<left>", '<Nop>', Opts)
Keymap({ "n", "v", "i" }, "<right>", '<Nop>', Opts)
Keymap({ "n", "v", "i" }, "<up>", '<Nop>', Opts)
Keymap({ "n", "v", "i" }, "<down>", '<Nop>', Opts)

-- Diagnostic keymaps
Keymap("n", "[d", function() vim.diagnostic.jump({count=-1,float=true}) end, Desc("Go to previous diagnostic"))
Keymap("n", "]d", function() vim.diagnostic.jump({count=1,float=true}) end, Desc("Go to next diagnostic"))
Keymap("n", "<leader>e", vim.diagnostic.open_float, Desc("[E]rror messages"))

-- Cancel terminal mode
Keymap("t", "<C-q>", "<C-\\><C-n>", Desc("Exit terminal mode"))

-- Move lines up and down
Keymap("n", "<A-j>", ":m .+1<CR>==", Desc("Move line down"))
Keymap("n", "<A-k>", ":m .-2<CR>==", Desc("Move line up"))

Keymap({ "x", "v" }, "<A-j>", ":m '>+1<CR>gv=gv", Desc("Move lines down"))
Keymap({ "x", "v" }, "<A-k>", ":m '<-2<CR>gv=gv", Desc("Move lines up"))

-- Center cursor when jumping through the page
Keymap("n", "<C-d>", "<C-d>zz", Desc("Move half page down"))
Keymap("n", "<C-u>", "<C-u>zz", Desc("Move half page up"))
Keymap("n", "n", "nzz", Desc("Jump to next match"))
Keymap("n", "N", "Nzz", Desc("Jump to previous match"))

-- Center cursor when moving using brackets
Keymap("n", "{", "[{zz", Desc("Move to matching bracket"))
Keymap("n", "}", "]}zz", Desc("Move to matching bracket"))

-- Clean search highlights
Keymap("n", "<C-c>", ":noh<CR>", Desc("Clear search highlights"))

-- Open file tree
Keymap("n", "<leader><Space>", ":NvimTreeToggle<CR>", Desc("Toggle file tree"))

-- Resize windows
Keymap("n", "<C-Left>", ":vertical resize +2<CR>", Desc("Resize window left"))
Keymap("n", "<C-Down>", ":resize +2<CR>", Desc("Resize window down"))
Keymap("n", "<C-Up>", ":resize -2<CR>", Desc("Resize window up"))
Keymap("n", "<C-Right>", ":vertical resize -2<CR>", Desc("Resize window right"))

-- Navigate between buffers
Keymap("n", "<C-PageUp>", ":bnext<CR>", Desc("Next buffer"))
Keymap("n", "<C-PageDown>", ":bprevious<CR>", Desc("Previous buffer"))
Keymap("n", "<C-q>", ":bd<CR>", Desc("Close buffer"))

-- One-key persistent indenting
Keymap("v", "<", "<gv", Desc("Indent left"))
Keymap("v", ">", ">gv", Desc("Indent right"))

-- Persistent pasting
Keymap("v", "p", '"_dP', Desc("Paste without yanking"))

-- Copy to clipboard
Keymap({ "v", "n" }, "<A-y>", "\"+y", Desc("Copy to clipboard"))

-- Move down and up by visual lines
Keymap({ "n", "v" }, "<C-j>", "gj", Desc("Move down by visual line"))
Keymap({ "n", "v" }, "<C-k>", "gk", Desc("Move up by visual line"))
Keymap({ "n", "v" }, "<C-l>", "$", Desc("Move to end of line"))
Keymap({ "n", "v" }, "<C-h>", "^", Desc("Move to start of line"))

-- Autoformat
Keymap("n", "<leader>=", "gg=G<C-o>", Desc("Autoformat"))

-- Number increment/decrement
Keymap({ "n", "v" }, "++", "<C-a>", Desc("Increment number under cursor"))
Keymap({ "n", "v" }, "--", "<C-x>", Desc("Decrement number under cursor"))

-- Splits
Keymap("n", "<leader>pv", "<C-w>v", Desc("[P]ane: [V]ertical split"))
Keymap("n", "<leader>ph", "<C-w>s", Desc("[P]ane: [H]orizontal split"))
Keymap("n", "<leader>pq", "<C-w>q", Desc("[P]ane: [Q]uit"))
Keymap("n", "<leader>pe", "<C-w>=", Desc("[P]ane: [E]qual size"))
Keymap("n", "<leader>pm", "<C-w>o", Desc("[P]ane: [M]aximize"))

-- QuickFix List
Keymap("n", "<leader>qn", ":cn<CR>", Desc("[Q]uickFix [N]ext"))
Keymap("n", "<leader>qq", ":cw<CR>", Desc("[Q]uickfix list"))
