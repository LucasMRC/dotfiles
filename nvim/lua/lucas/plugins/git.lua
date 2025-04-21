return {
	{
		'akinsho/git-conflict.nvim',
		version = "*",
		config = function()
			require("git-conflict").setup({})
			Keymap("n", "<leader>gq", ":GitConflictListQf<CR>", Desc("[G]it [Q]uickfix"))
		end
	},
	{
		"tpope/vim-fugitive",      -- git
		event = "VeryLazy",
		config = function()
			Keymap("n", "<leader>gg", ":Git<CR>", Desc("[G]it status"))
			Keymap("n", "<leader>gb", ":Git blame<CR>", Desc("[G]it [B]lame"))
			Keymap("n", "<leader>gd", ":Gvdiffsplit<CR>", Desc("[G]it [D]iff"))
		end
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "+" },
					change = { text = "~" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
				},
				current_line_blame = true,
				current_line_blame_opts = {
					virt_text_pos = "eol",
				},
				current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
				on_attach = function(bufnr)
					local gs = package.loaded.gitsigns

					local function opts(opts)
						opts = { desc = opts.desc or "", noremap = opts.noremap or true, silent = opts.silent or true }
						opts.buffer = bufnr
						return opts
					end

					-- Navigation
					Keymap("n", "]c", function()
						if vim.wo.diff then
							return "]c"
						end
						vim.schedule(function()
							gs.next_hunk()
						end)
						return "<Ignore>"
					end, opts({ expr = true }))

					Keymap("n", "[c", function()
						if vim.wo.diff then
							return "[c"
						end
						vim.schedule(function()
							gs.prev_hunk()
						end)
						return "<Ignore>"
					end, opts({ expr = true }))

					-- Actions
					Keymap("n", "<leader>hs", gs.stage_hunk, Desc("[H]unk [S]tage"))
					Keymap("n", "<leader>hr", gs.reset_hunk, Desc("[H]unk [R]eset"))
					Keymap("v", "<leader>hs", function()
						gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end, Desc("[H]unk [S]tage"))
					Keymap("v", "<leader>hr", function()
						gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end, Desc("[H]unk [R]eset"))
					Keymap("n", "<leader>hu", gs.undo_stage_hunk, Desc("[H]unk [U]nstage"))
					Keymap("n", "<leader>hp", gs.preview_hunk, Desc("[H]unk [P]review"))
					Keymap("n", "<leader>hb", function()
						gs.blame_line({ full = true })
					end, Desc("[H]unk [B]lame"))
					Keymap("n", "<leader>htb", gs.toggle_current_line_blame, Desc("[H]unk: [T]oggle [B]lame"))
					Keymap("n", "<leader>htd", gs.toggle_deleted, Desc("[H]unk: [T]oggle [D]eleted"))

					-- Text object
					Keymap({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", {})
				end,
			})
		end,
	}
}
