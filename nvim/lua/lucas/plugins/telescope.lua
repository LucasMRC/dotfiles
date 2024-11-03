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
				file_ignore_patterns = { "node_modules/", "^%.git/", "^%.vim/", "%-lock%." },
				set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
				file_previewer = require("telescope.previewers").vim_buffer_cat.new,
				grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
				qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
				file_sorter = require("telescope.sorters").get_fuzzy_file,
				winblend = 0,
				buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
				-- preview = {
					-- mime_hook = function(filepath, bufnr, opts)
					-- 	local ok, image_api = pcall(require, 'image')
					-- 	if not ok then return end
					--
					-- 	local is_image = function(fp)
					-- 		local image_extensions = { 'png', 'jpg', 'svg', 'webm', 'jpeg', 'gif' } -- Supported image formats
					-- 		local split_path = vim.split(fp:lower(), '.', { plain = true })
					-- 		local extension = split_path[#split_path]
					-- 		return vim.tbl_contains(image_extensions, extension)
					-- 	end
					-- 	if is_image(filepath) then
					-- 		local image_in_preview = image_api.from_file(filepath, {
					-- 			buffer = bufnr,
					-- 			window = opts.winid
					-- 		})
					-- 		image_in_preview:render()
					-- 	else
					-- 		require("telescope.previewers.utils").set_preview_message(bufnr, opts.winid,
					-- 			"Binary cannot be previewed")
					-- 	end
					-- end
				-- }
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
		local builtin = require("telescope.builtin")

		vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
		vim.keymap.set("n", "<leader>sB", builtin.git_branches, { desc = "[S]earch [B]ranches" })
		vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
		vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
		vim.keymap.set("n", "<leader>sg", telescope.extensions.live_grep_args.live_grep_args, { silent = true, desc = "[S]earch by [G]rep" }) -- requires ripgrep installed
		vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
		vim.keymap.set("n", "<leader>se", builtin.symbols, { desc = "[S]earch [E]moji" })
		vim.keymap.set("n", "<leader>su", "<CMD>Telescope undo<CR>", { desc = "[S]earch [U]ndo" })
		vim.keymap.set("n", "<leader>sb", builtin.buffers, { desc = "[S]earch [B]uffers" })
		vim.keymap.set("n", "<leader><tab>", builtin.commands, { desc = "[S]earch Commands", noremap = false })
		vim.keymap.set("n", "<leader>sS", builtin.git_status, { desc = "[S]earch Git [S]tatus" })
		vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
		vim.keymap.set("n", "<leader>sc", builtin.git_commits, { desc = "[S]earch [C]ommits" })

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
		end

		vim.api.nvim_create_autocmd("User", {
			pattern = "TelescopePreviewerLoaded",
			callback = function()
				vim.wo.wrap = true
			end,
		})
	end,
}
