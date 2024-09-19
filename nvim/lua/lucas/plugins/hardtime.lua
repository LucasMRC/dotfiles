return {
	"m4xshen/hardtime.nvim",
	dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
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
}
