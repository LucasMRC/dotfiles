return {
	{
		"windwp/nvim-autopairs",
		event = "VeryLazy",
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
		"folke/todo-comments.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-lua/plenary.nvim", lazy = true },
		opts = { signs = false },
	},
	{
		"windwp/nvim-ts-autotag",         -- auto close html tags
		ft = { "html", "htmlhugo", "svelte" },
	},
	{
		"phelipetls/vim-hugo",
		ft = "htmlhugo"
	},
	"nvim-lua/plenary.nvim",          -- don't forget to add this one if you don't have it yet!
}
