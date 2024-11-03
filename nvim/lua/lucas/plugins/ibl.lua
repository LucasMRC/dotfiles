return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	event = "VeryLazy",
	config = function()
		local hooks = require("ibl.hooks")
		local indentFG = "3c3c3c"
		local ok, c = pcall(require, "palenightfall")
		if ok then
			indentFG = c.colors.diff_add_background
		end

		hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
			vim.api.nvim_set_hl(0, "Scope", { fg = indentFG })
			vim.api.nvim_set_hl(0, "Indent", { fg = "#3c3c3c" })
		end)

		require("ibl").setup({
			indent = { highlight = "Indent" },
			scope = {
				highlight = "Scope",
				show_start = false,
				show_end = false,
			},
		})
	end,
}
