return {
	"nvim-lualine/lualine.nvim", -- status line
	config = function()
		require("lualine").setup({
			options = {
				component_separators = "|",
				section_separators = "",
				disabled_filetypes = {
					statusline = { "NvimTree" },
				},
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { { "filename", path = 4 } },
				lualine_c = { { "branch", icons_enabled = true }, "diff", "diagnostics" },
				lualine_x = { "require('lsp-zero').status()" },
				lualine_y = {
					{ "filetype", fmt = string.upper },
				},
				lualine_z = { "location" },
			},
		})
	end,
}
