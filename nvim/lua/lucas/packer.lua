-- This file can be loaded by calling `lua require('plugins')` from your init.vim
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({
        'git',
        'clone',
        '--depth',
        '1',
        'https://github.com/wbthomason/packer.nvim',
        install_path
    })
    print "Installing packer, close and reopen neovim"
end

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

local status_ok, packer = pcall(require, 'packer')
if not status_ok then
    print("Packer failed to load")
    return
end

return packer.startup(function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

	-- Simple plugins can be specified as strings
    use 'AlexvZyl/nordic.nvim' -- Nord theme
    use 'windwp/nvim-autopairs' -- Auto-pairing for quotes, parens, brackets, etc.
	use 'nvim-lua/plenary.nvim' -- don't forget to add this one if you don't have it yet!
    use 'numToStr/Comment.nvim' -- toggle comments
    use 'nvim-tree/nvim-tree.lua' -- file explorer
    use 'lewis6991/gitsigns.nvim' -- git signs
    use 'nvim-lualine/lualine.nvim' -- status line
	use 'tpope/vim-fugitive' -- git commands
    use 'windwp/nvim-ts-autotag' -- auto close html tags
    use 'mattn/emmet-vim' -- emmet
    use 'kdheepak/lazygit.nvim' -- lazygit

    use {
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
        }

    -- Telescope
	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.5',
	}
    use 'nvim-telescope/telescope-symbols.nvim'
    use 'debugloop/telescope-undo.nvim'
    --

	use {
		'nvim-treesitter/nvim-treesitter',
		run = function()
			local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
			ts_update()
		end,
	}

	use {
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v3.x',
		requires = {
			--- Uncomment the two plugins below if you want to manage the language servers from neovim
			{'williamboman/mason.nvim'},
			{'williamboman/mason-lspconfig.nvim'},

			-- LSP Support
			{'neovim/nvim-lspconfig'},
			-- Autocompletion
			{'hrsh7th/nvim-cmp'},
			{'hrsh7th/cmp-path'},
			{'hrsh7th/cmp-nvim-lsp'},
			{'hrsh7th/cmp-buffer'},
			{'L3MON4D3/LuaSnip'},
		}
	}
end)
