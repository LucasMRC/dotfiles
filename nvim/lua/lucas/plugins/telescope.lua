return { -- Fuzzy Finder (files, lsp, etc)
	"nvim-telescope/telescope.nvim",
	event = "VimEnter",
	branch = "0.1.x",
	dependencies = {
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
		{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
	},
	config = function()
		local status_ok, telescope = pcall(require, "telescope")
		if not status_ok then
			print("Telescope failed to load")
			return
		end

		telescope.setup({
			defaults = {
				-- Default configuration for telescope goes here:
				-- path_display = { "truncate" },
				preview = false,
				layout_strategy = "vertical",
				disable_devicons = true,
				layout_config = {
					preview_height = 0.7,
					vertical = {
						size = {
							height = 0.9,
							width = 0.9,
						},
					},
				},
				file_ignore_patterns = { "^node_modules/", "^%.git/", "^%.vim/", "%-lock%." },
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
			},
		})

		telescope.load_extension("undo")
		telescope.load_extension("fzf")
		local builtin = require("telescope.builtin")

		vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
		vim.keymap.set("n", "<leader>sb", builtin.git_branches, { desc = "[S]earch [B]ranches" })
		vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
		vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
		vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" }) -- requires ripgrep installed
		vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
		vim.keymap.set("n", "<leader>se", builtin.symbols, { desc = "[S]earch [E]moji" })
		vim.keymap.set("n", "<leader>su", "<CMD>Telescope undo<CR>", { desc = "[S]earch [U]ndo" })
		vim.keymap.set("n", "<leader>sb", builtin.buffers, { desc = "[S]earch existing buffers" })
		vim.keymap.set("n", "<leader><tab>", builtin.commands, { desc = "[S]earch [C]ommands", noremap = false })
		vim.keymap.set("n", "<leader>pS", builtin.git_status, { desc = "" })
		vim.keymap.set("n", "<leader>s.", function()
			builtin.find_files({ cwd = "~/.dotfiles/" })
		end, { desc = "[S]earch [.]dot files" })

		local wt_status_ok, git_wt = pcall(require, "git-worktree")
		if not wt_status_ok then
			print("git-worktree failed to load")
			return
		else
			git_wt.setup()
			telescope.load_extension("git_worktree")
			vim.keymap.set(
				"n",
				"<leader>st",
				telescope.extensions.git_worktree.git_worktrees,
				{ desc = "[S]earch [T]rees" }
			)
			vim.keymap.set("n", "<leader>sn", telescope.extensions.git_worktree.create_git_worktree, {})
		end
	end,
}
