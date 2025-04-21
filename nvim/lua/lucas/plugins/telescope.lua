return { -- Fuzzy Finder (files, lsp, etc)
	"nvim-telescope/telescope.nvim",
	event = "VimEnter",
	branch = "0.1.x",
	dependencies = {
		{
			'polarmutex/git-worktree.nvim',
			branch = 'devel'
		},
		"nvim-lua/plenary.nvim",
		{ -- If encountering errors, see telescope-fzf-native README for install instructions
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			-- `cond` is a condition used to determine whether this plugin should be
			-- installed and loaded.
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
		{ "nvim-telescope/telescope-symbols.nvim" },
		{ "debugloop/telescope-undo.nvim" },
		{
			"nvim-tree/nvim-web-devicons",
			enabled = vim.g.have_nerd_font
		},
		{
			"nvim-telescope/telescope-live-grep-args.nvim",
			-- This will not install any breaking changes.
			-- For major updates, this must be adjusted manually.
			version = "^1.0.0",
		},
	},
	config = function()
		local status_ok, telescope = pcall(require, "telescope")
		if not status_ok then
			print("Telescope failed to load")
			return
		end
		local lga_actions = require("telescope-live-grep-args.actions")

		telescope.setup({
			defaults = {
				-- Default configuration for telescope goes here:
				path_display = { "smart" },
				vimgrep_arguments = {
					"rg",
					"-L",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--hidden",
					"--smart-case",
				},
				selection_strategy = "reset",
				sorting_strategy = "ascending",
				layout_strategy = "horizontal",
				layout_config = {
					horizontal = {
						prompt_position = "bottom",
						preview_width = 0.55,
						results_width = 0.8,
					},
					vertical = {
						mirror = false,
					},
					width = 0.87,
					height = 0.80,
					preview_cutoff = 120,
				},
				file_ignore_patterns = { "node_modules/", "^%.git/", "^%.vim/", "%-lock%.", "dist/" },
				set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
				file_previewer = require("telescope.previewers").vim_buffer_cat.new,
				grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
				qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
				file_sorter = require("telescope.sorters").get_fuzzy_file,
				winblend = 0,
				buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
			},
			pickers = {
				find_files = {
					no_ignore = true,
					hidden = true,
				},
				live_grep = {
					hidden = true,
					no_ignore = true,
					preview = true,
				},
				help_tags = {
					hidden = true,
					preview = true,
				},
				git_branches = {
					preview = false,
					initial_mode = "normal",
				},
				git_commits = {
					initial_mode = "normal",
				},
				git_status = {
					preview = true,
					initial_mode = "normal",
					disable_devicons = false,
				},
				buffers = {
					initial_mode = "normal",
					no_ignore = true,
					mappings = {
						n = {
							["x"] = require("telescope.actions").delete_buffer,
						},
					},
				},
			},
			extensions = {
				undo = {
					initial_mode = "normal",
					preview = true,
					no_ignore = true,
					mappings = {
						n = {
							["<CR>"] = require("telescope-undo.actions").restore,
						},
						i = {
							["<CR>"] = require("telescope-undo.actions").restore,
						},
					},
				},
				git_worktree = {
					initial_mode = "normal",
				},
				live_grep_args = {
					mappings = {
						n = {
							["<C-k>"] = lga_actions.quote_prompt()
						},
						i = {
							["<C-k>"] = lga_actions.quote_prompt()
						}
					}
				}
			},
		})

		telescope.load_extension("undo")
		telescope.load_extension("fzf")
		telescope.load_extension("live_grep_args")
		telescope.load_extension("git_worktree")

		-- Worktree hooks
		local Hooks = require("git-worktree.hooks")
		local update_on_switch = Hooks.builtins.update_current_buffer_on_switch

		Hooks.register(Hooks.type.SWITCH, function (path, prev_path)
			update_on_switch(path, prev_path)
		end)

		local builtin = require("telescope.builtin")

		Keymap("n", "<leader>sf", builtin.find_files, Desc("[S]earch [F]iles"))
		Keymap("n", "<leader>sB", builtin.git_branches, Desc("[S]earch [B]ranches"))
		Keymap("n", "<leader>sh", builtin.help_tags, Desc("[S]earch [H]elp"))
		Keymap("n", "<leader>sw", builtin.grep_string, Desc("[S]earch current [W]ord"))
		Keymap("n", "<leader>sg", telescope.extensions.live_grep_args.live_grep_args, Desc("[S]earch by [G]rep")) -- requires ripgrep installed
		Keymap("n", "<leader>sd", builtin.diagnostics, Desc("[S]earch [D]iagnostics"))
		Keymap("n", "<leader>se", builtin.symbols, Desc("[S]earch [E]moji"))
		Keymap("n", "<leader>su", "<CMD>Telescope undo<CR>", Desc("[S]earch [U]ndo"))
		Keymap("n", "<leader>st", "<CMD>Telescope git_worktree<CR>", Desc("[S]earch [T]ree"))
		Keymap("n", "<leader>sb", builtin.buffers, Desc("[S]earch [B]uffers"))
		Keymap("n", "<leader><tab>", builtin.commands, Desc("[S]earch Commands"))

		vim.api.nvim_create_autocmd("User", {
			pattern = "TelescopePreviewerLoaded",
			callback = function()
				vim.wo.wrap = true
			end,
		})
	end,
}
