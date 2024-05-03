return { -- Useful plugin to show you pending keybinds.
	"folke/which-key.nvim",
	event = "VimEnter", -- Sets the loading event to 'VimEnter'
	init = function() -- This is the function that runs BEFORE loading
		vim.opt.timeout = true
		vim.opt.timeoutlen = 1500
	end,
	config = function() -- This is the function that runs AFTER loading
		require("which-key").setup()
		-- Document existing key chains
		require("which-key").register({
			["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
			["<leader>d"] = { name = "[D]ocument", _ = "which_key_ignore" },
			["<leader>r"] = { name = "[R]ename", _ = "which_key_ignore" },
			["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
			["<leader>w"] = { name = "[W]orkspace", _ = "which_key_ignore" },
			["<leader>g"] = { name = "[G]it", _ = "which_key_ignore" },
			["<leader>h"] = { name = "[H]unks", _ = "which_key_ignore" },
			["<leader>o"] = { name = "[O]bsidian", _ = "which_key_ignore" },
			["<leader>p"] = { name = "[P]ane", _ = "which_key_ignore" },
			["<leader>t"] = { name = "[T]rouble", _ = "which_key_ignore" },
			["<leader>D"] = { name = "[D]atabase", _ = "which_key_ignore" },
		})
	end,
}
