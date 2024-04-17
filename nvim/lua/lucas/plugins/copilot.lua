return {
	"zbirenbaum/copilot.lua",
	lazy = true,
	event = "VeryLazy",
	config = function()
		require("copilot").setup({
			suggestion = {
				auto_trigger = true,
				keymap = {
					accept_word = "<C-M-l>",
				},
			},
            filetypes = {
                go = false,
                ["*"] = true,
            }
		})
	end,
}
