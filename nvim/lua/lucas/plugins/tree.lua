return {
	"nvim-tree/nvim-tree.lua", -- file explorer
	version = "*",
	lazy = false,
	config = function()
		require("nvim-tree").setup({
			on_attach = function(bufnr)
				local api = require "nvim-tree.api"
				local function opts(desc)
					return {
						desc = "nvim-tree: " .. desc,
						buffer = bufnr,
						noremap = true,
						silent = true,
						nowait = true,
					}
				end

				-- default mappings
				api.config.mappings.default_on_attach(bufnr)
				-- delete mappings
				vim.keymap.del('n', 's', { buffer = bufnr }) -- open in terminal
				vim.keymap.set('n', 'd', api.fs.trash, opts('Trash'))
				vim.keymap.set('n', 'D', api.fs.remove, opts('Remove'))
			end,
			hijack_unnamed_buffer_when_opening = true,
			diagnostics = {
				enable = true,
				show_on_dirs = true,
				show_on_open_dirs = false,
			},
			modified = {
				enable = true,
				show_on_open_dirs = false,
			},
			git = {
				show_on_open_dirs = false,
			},
			update_focused_file = {
				enable = true,
			},
			renderer = {
				highlight_diagnostics = "name",
				group_empty = true,
				icons = {
					show = {
						diagnostics = false,
						file = false,
						folder = false,
					},
					git_placement = "signcolumn",
				},
			},
			disable_netrw = true,
			hijack_netrw = true,
			actions = {
				open_file = {
					quit_on_open = true,
				},
				expand_all = {
					exclude = { ".git", "target", "build", "node_modules" },
				},
			},
			view = {
				width = 50,
				side = "right",
				number = true,
				relativenumber = true,
			},
			filters = {
				git_ignored = false,
				custom = { "^\\.git$" },
			},
			trash = {
				cmd = 'trash',
				require_confirm = true
			},
			live_filter = {
				always_show_folders = false,
				prefix = "> ",
			},
		})
	end,
}
