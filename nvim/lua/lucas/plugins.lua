local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local status_ok, lazyvim = pcall(require, 'lazy')
if not status_ok then
    print("Lazy.vim failed to load")
    return
end

lazyvim.setup({
    'AlexvZyl/nordic.nvim', -- Nord theme
    'windwp/nvim-autopairs', -- Auto-pairing for quotes, parens, brackets, etc.
	'nvim-lua/plenary.nvim', -- don't forget to add this one if you don't have it yet!
    'numToStr/Comment.nvim', -- toggle comments
    'nvim-tree/nvim-tree.lua', -- file explorer
    'lewis6991/gitsigns.nvim', -- git signs
    'nvim-lualine/lualine.nvim', -- status line
    'windwp/nvim-ts-autotag', -- auto close html tags
    'mattn/emmet-vim', -- emmet
    'kdheepak/lazygit.nvim', -- lazygit
    {
        'zbirenbaum/copilot.lua',
        cmd = 'Copilot',
        event = 'InsertEnter',
        config = function()
            require('copilot').setup({
                suggestion = {
                    auto_trigger = true,
                    keymap = {
                        accept_word = '<C-M-l>',
                    },
                },
            })
        end,
    },
    -- Telescope
	{
		'nvim-telescope/telescope.nvim',
        tag = '0.1.5'
	},
    'nvim-telescope/telescope-symbols.nvim',
    'debugloop/telescope-undo.nvim',
    --
	{
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate'
	},
	{
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v3.x',
		dependencies = {
			--- Uncomment the two plugins below if you want to manage the language servers from neovim
			'williamboman/mason.nvim',
			'williamboman/mason-lspconfig.nvim',
			-- LSP Support
			'neovim/nvim-lspconfig',
			-- Autocompletion
			'hrsh7th/nvim-cmp',
			'hrsh7th/cmp-path',
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-buffer',
            {
                "ray-x/lsp_signature.nvim",
                event = "VeryLazy",
                config = function()
                    require("lsp_signature").setup({
                        hint_enable = false
                    })
                end
            },
			'L3MON4D3/LuaSnip',
		}
    }
})
