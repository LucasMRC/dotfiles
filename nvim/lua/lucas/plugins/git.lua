local function map(mode, l, r, opts)
	opts = { desc = opts.desc or "", noremap = opts.noremap or true, silent = opts.silent or true }
	vim.keymap.set(mode, l, r, opts)
end

return {
	-- -- "ThePrimeagen/git-worktree.nvim", -- git worktrees
	-- {
	-- 	'polarmutex/git-worktree.nvim',
	-- 	version = '^2',
	-- 	dependencies = { "nvim-lua/plenary.nvim" }
	-- },
	{
		'akinsho/git-conflict.nvim',
		version = "*",
		config = function()
			require("git-conflict").setup({})
			map("n", "<leader>gq", ":GitConflictListQf<CR>", { desc = "[G]it [Q]uickfix" })
		end
	},
	{
		"tpope/vim-fugitive",      -- git
		event = "VeryLazy",
		config = function()
			map("n", "<leader>gg", ":Git<CR>", { desc = "[G]it status" })
			map("n", "<leader>gb", ":Git blame<CR>", { desc = "[G]it [B]lame" })
			map("n", "<leader>gd", ":Gvdiffsplit<CR>", { desc = "[G]it [D]iff" })
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

					local function mapbf(mode, l, r, opts)
						opts = { desc = opts.desc or "", noremap = opts.noremap or true, silent = opts.silent or true }
						opts.buffer = bufnr
						vim.keymap.set(mode, l, r, opts)
					end

					-- Navigation
					mapbf("n", "]c", function()
						if vim.wo.diff then
							return "]c"
						end
						vim.schedule(function()
							gs.next_hunk()
						end)
						return "<Ignore>"
					end, { expr = true })

					mapbf("n", "[c", function()
						if vim.wo.diff then
							return "[c"
						end
						vim.schedule(function()
							gs.prev_hunk()
						end)
						return "<Ignore>"
					end, { expr = true })

					-- Actions
					mapbf("n", "<leader>hs", gs.stage_hunk, { desc = "[H]unk [S]tage" })
					mapbf("n", "<leader>hr", gs.reset_hunk, { desc = "[H]unk [R]eset" })
					mapbf("v", "<leader>hs", function()
						gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end, { desc = "[H]unk [S]tage" })
					mapbf("v", "<leader>hr", function()
						gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end, { desc = "[H]unk [R]eset" })
					mapbf("n", "<leader>hu", gs.undo_stage_hunk, { desc = "[H]unk [U]nstage" })
					mapbf("n", "<leader>hp", gs.preview_hunk, { desc = "[H]unk [P]review" })
					mapbf("n", "<leader>hb", function()
						gs.blame_line({ full = true })
					end, { desc = "[H]unk [B]lame" })
					mapbf("n", "<leader>htb", gs.toggle_current_line_blame, { desc = "[H]unk: [T]oggle [B]lame" })
					mapbf("n", "<leader>htd", gs.toggle_deleted, { desc = "[H]unk: [T]oggle [D]eleted" })

					-- Text object
					mapbf({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", {})
				end,
			})
		end,
	}
}
