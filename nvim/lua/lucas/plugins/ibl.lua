return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	opts = {},
	config = function()
		local hooks = require("ibl.hooks")

		vim.api.nvim_set_hl(0, "Scope", { fg = "#676e95" })
		vim.api.nvim_set_hl(0, "Indent", { fg = "#3c3c3c" })

		require("ibl").setup({
			indent = { highlight = "Indent" },
			scope = { highlight = "Scope" },
		})

		hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
	end,
}
