local set = vim.opt
local g = vim.g

g.mapleader = " "
g.maplocalleader = " "

-- Line numbers
set.nu = true
set.numberwidth = 4 -- set number column width {default 4}
set.rnu = true

-- Indentation
set.tabstop = 4
set.softtabstop = 4
set.shiftwidth = 4
set.autoindent = true
set.smartindent = true
set.expandtab = false

vim.o.breakindent = true
--

-- Big undo history
set.swapfile = false
set.backup = false
set.undodir = os.getenv("HOME") .. "/.vim/undodir"
set.undofile = true
--

-- Incremental search
set.incsearch = true
set.hlsearch = true -- highlight all matches on previous search pattern
--

-- Better searching
set.ignorecase = true
set.smartcase = true
--

-- Enable 24-bit RGB colors
set.termguicolors = true
set.background = "dark"

-- Always 5 lines above/below the cursor
set.scrolloff = 5
set.sidescrolloff = 5
--

set.updatetime = 10

-- Show the matching part of the pair for [] {} and ()
set.showmatch = true

-- Disable mouse
set.mouse = ""

set.cmdheight = 1

set.completeopt = { "menuone", "noselect" } -- Completion options

set.pumheight = 10 -- pop up menu height
set.pumblend = 10

-- set.showmode = false -- we don't need to see things like -- INSERT -- anymore
set.splitbelow = true -- force all horizontal splits to go below current window
set.splitright = true -- force all vertical splits to go to the right of current window

set.cursorline = true -- highlight the current line

set.laststatus = 3 -- show status line always and only on last window
set.signcolumn = "yes" -- always show the sign column, otherwise it would shift the text each time
set.guifont = "monospace:h17" -- the font used in graphical neovim applications
set.title = true

set.conceallevel = 1 -- markdown syntax concealing
set.concealcursor = "c" -- markdown syntax concealing visibility

g.editorconfig = false -- disable .editorconfig file search

set.backspace = "indent,eol,start"

set.listchars = "tab:->,trail:·,multispace:·"
set.list = true

set.formatoptions:remove "o" -- remove comment prefix on 'o/O'
-- vim.o.exrc = true -- enable per-directory .vimrc files
