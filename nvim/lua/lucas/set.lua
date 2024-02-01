local set = vim.opt
local g = vim.g

g.mapleader = " "

-- Line number
set.nu = true

-- Indentation
set.tabstop = 4
set.softtabstop = 4
set.shiftwidth = 4
set.smartindent = true
set.expandtab = true
--

-- Big undo history
set.swapfile = false
set.backup = false
set.undodir = os.getenv("HOME") .. "/.vim/undodir"
set.undofile = true
--

-- Incremental search
set.incsearch = true

-- Better searching
set.ignorecase = true
set.smartcase = true

-- Enable 24-bit RGB colors
set.termguicolors = true

-- Always 5 lines above/below the cursor
set.scrolloff = 5
set.sidescrolloff = 5

set.updatetime = 50
set.colorcolumn = "80"

-- Show the matching part of the pair for [] {} and ()
set.showmatch = true

