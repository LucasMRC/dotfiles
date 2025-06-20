return { -- Useful plugin to show you pending keybinds.
	"folke/which-key.nvim",
	event = "VimEnter", -- Sets the loading event to 'VimEnter'
	config = function() -- This is the function that runs AFTER loading
		local wk = require("which-key")
		wk.setup({
			delay = 2500,
			notify = false,
		})
		wk.add({
			{ "<leader>D", group = "[D]atabase" },
			{ "<leader>c", group = "[C]ode" },
			{ "<leader>d", group = "[D]ocument" },
			{ "<leader>g", group = "[G]it" },
			{ "<leader>h", group = "[H]unks" },
			{ "<leader>n", group = "[N]otes" },
			{ "<leader>o", group = "[O]cto" },
			{ "<leader>p", group = "[P]ane" },
			{ "<leader>r", group = "[R]ename" },
			{ "<leader>s", group = "[S]earch" },
			{ "<leader>t", group = "[T]rouble" },
			{ "<leader>w", group = "[W]orkspace" },
		})
	end,
}
