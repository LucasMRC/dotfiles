return {
	"m4xshen/hardtime.nvim",
	event = "VeryLazy",
	dependencies = {
		{ "MunifTanjim/nui.nvim", lazy = true },
		{ "nvim-lua/plenary.nvim", lazy = true }
	},
	opts = {
		disabled_filetypes = {
			"GHN",
			"mason",
			"help",
			"NvimTree",
			"fugitive",
			"octo",
			"lazy",
			"dapui_breakpoints",
			"dapui_scopes",
			"dapui_stacks",
			"dapui_watches",
			"dapui_breakpoints",
			"dapui_console",
			"dap_repl",
			"DressingInput"
		},
		disabled_keys = {
			-- ["<Space>"] = { "n", "x" },
			["<F1>"] = { "n", "x", "i" },
			["<F2>"] = { "n", "x", "i" },
			["<F3>"] = { "n", "x", "i" },
			["<F4>"] = { "n", "x", "i" },
			["<F5>"] = { "n", "x", "i" },
			["<F6>"] = { "n", "x", "i" },
			["<F7>"] = { "n", "x", "i" },
			["<F8>"] = { "n", "x", "i" },
			["<F9>"] = { "n", "x", "i" },
			["<F10>"] = { "n", "x", "i" },
			["<Up>"] = { "n", "x", "i" },
			["<Down>"] = { "n", "x", "i" },
			["<Left>"] = { "n", "x", "i" },
			["<Right>"] = { "n", "x", "i" },
		}
	},
	config = function()
		require('hardtime').setup({})
	end
}
