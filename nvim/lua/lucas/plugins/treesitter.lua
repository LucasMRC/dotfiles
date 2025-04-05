return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
		"nvim-treesitter/nvim-treesitter-context"
	},
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			-- A list of parser names
			ensure_installed = {
				"gomod",
				"gosum",
				"gotmpl",
				"go",
				"markdown",
				"markdown_inline",
				"css",
				"javascript",
				"typescript",
				"svelte",
				"lua",
				"vim",
				"vimdoc",
				"query",
				"sql",
				"json",
				"bash",
				"yaml",
				"scss",
				"jsdoc",
				"jsonnet", -- Grafana only
			},
			textobjects = {
				select = {
					enable = true,
					lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
					keymaps = {
						["aa"] = "@parameter.outer",
						["ia"] = "@parameter.inner",
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ib"] = "@block.inner",
						["ab"] = "@block.outer",
						["ac"] = "@comment.outer",
					},
				},
			},
			-- Install parsers synchronously (only applied to `ensure_installed`)
			sync_install = false,

			-- Automatically install missing parsers when entering buffer
			-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
			auto_install = false,
			highlight = {
				enable = true,
			},
			autotag = {
				enable = true,
			},
			indent = {
				enable = true,
			},
		})

		vim.filetype.add({
			extension = {
				html = function()
					local ho = vim.fn.search("{{", "nw")
					if ho == 0 then
						return "html"
					end
					return "gohtmltmpl"
				end,
			}
		})

	end,
}
