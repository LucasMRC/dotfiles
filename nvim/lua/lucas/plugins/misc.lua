return {
	{
		"m4xshen/hardtime.nvim",
		dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
		opts = {
			disabled_filetypes = {
				"GHN",
				"help",
				"NvimTree",
				"fugitive",
				"octo"
			},
			disabled_keys = {
				["<Space>"] = { "n", "x" },
				["<F1>"] = { "i" },
				["<F2>"] = { "i" },
				["<F3>"] = { "i" },
				["<F4>"] = { "i" },
				["<F5>"] = { "i" },
				["<F6>"] = { "i" },
				["<F7>"] = { "i" },
				["<F8>"] = { "i" },
				["<F9>"] = { "i" },
				["<F10>"] = { "i" },
				["<Up>"] = { "n", "x", "i" },
				["<Down>"] = { "n", "x", "i" },
				["<Left>"] = { "n", "x", "i" },
				["<Right>"] = { "n", "x", "i" },
			}
		}
	},
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
			require("Comment.ft").set("gohtmltmpl", {"{{/*%s*/}}", "{{/*%s*/}}"})
		end,
	}, -- toggle comments
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
	"nvim-lua/plenary.nvim",          -- don't forget to add this one if you don't have it yet!
	"windwp/nvim-ts-autotag",         -- auto close html tags
	"phelipetls/vim-hugo",
}
