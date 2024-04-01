return {
	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	}, -- Auto-pairing for quotes, parens, brackets, etc.
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup({
				padding = true,
			})
		end,
	}, -- toggle comments
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {},
		config = function()
			require("ibl").setup()
		end,
	},
	{
		"JoosepAlviste/palenightfall.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("palenightfall").setup()
		end,
	},
	{
		"AlexvZyl/nordic.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("nordic").load()
		end,
	},
	{
		"fladson/vim-kitty",
		lazy = true,
		event = "VeryLazy",
	},
	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},
	"nvim-lua/plenary.nvim", -- don't forget to add this one if you don't have it yet!
	"windwp/nvim-ts-autotag", -- auto close html tags
	"tpope/vim-fugitive", -- git
	"ThePrimeagen/git-worktree.nvim", -- git worktrees
}
