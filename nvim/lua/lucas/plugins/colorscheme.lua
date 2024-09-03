return {
	"JoosepAlviste/palenightfall.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		local c = require("palenightfall").colors

		require("palenightfall").setup({
			transparent = true,
			highlight_overrides = {
				NormalFloat = { fg = c.blue, bg = c.background },
				FloatBorder = { fg = c.blue_dark, bg = c.background },
				TelescopeBorder = { fg = c.blue_dark, bg = c.background },
				TelescopePromptNormal = { bg = c.background_darker },
				TelescopePromptBorder = { fg = c.paleblue, bg = c.background_darker },
				TelescopePromptTitle = { fg = c.blue, bg = c.background_darker },
				TelescopePromptPrefix = { fg = c.blue },
				-- TelescopeNormal = { bg = c.background_darker },
				-- TelescopeMatching = { fg = c.blue },
				-- TelescopeSelectionCaret = { fg = c.blue, bg = c.highlight },
				-- TelescopeSelection = { bg = c.references },
				Search = { fg = c.background_darker, bg = c.yellow },
				IncSearch = { fg = c.background_darker, bg = c.yellow },
				Whitespace = { fg = c.diff_add_background }
			},
		})

		vim.cmd.highlight("LineNr guifg=#6e7d9b")
		vim.cmd.highlight("Visual guibg=#3e4452 guifg=#d8dee9")
	end,
}
