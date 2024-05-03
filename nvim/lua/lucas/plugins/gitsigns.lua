return {
	"lewis6991/gitsigns.nvim",
	config = function()
		require("gitsigns").setup({
			signs = {
				add = { hl = "GitSignsAdd", text = "+", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
				change = { hl = "GitSignsChange", text = "~", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
				delete = { hl = "GitSignsDelete", text = "_", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
				topdelete = {
					hl = "GitSignsDelete",
					text = "‾",
					numhl = "GitSignsDeleteNr",
					linehl = "GitSignsDeleteLn",
				},
				changedelete = {
					hl = "GitSignsChange",
					text = "~",
					numhl = "GitSignsChangeNr",
					linehl = "GitSignsChangeLn",
				},
			},
			current_line_blame = true,
			current_line_blame_opts = {
				virt_text_pos = "eol",
			},
			current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				-- Navigation
				map("n", "]c", function()
					if vim.wo.diff then
						return "]c"
					end
					vim.schedule(function()
						gs.next_hunk()
					end)
					return "<Ignore>"
				end, { expr = true })

				map("n", "[c", function()
					if vim.wo.diff then
						return "[c"
					end
					vim.schedule(function()
						gs.prev_hunk()
					end)
					return "<Ignore>"
				end, { expr = true })

				-- Actions
				map("n", "<leader>hs", gs.stage_hunk, { desc = "[H]unk [S]tage" })
				map("n", "<leader>hr", gs.reset_hunk, { desc = "[H]unk [R]eset" })
				map("v", "<leader>hs", function()
					gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "[H]unk [S]tage" })
				map("v", "<leader>hr", function()
					gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "[H]unk [R]eset" })
				map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "[H]unk [U]nstage" })
				map("n", "<leader>hp", gs.preview_hunk, { desc = "[H]unk [P]review" })
				map("n", "<leader>hb", function()
					gs.blame_line({ full = true })
				end, { desc = "[H]unk [B]lame" })
				map("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "[T]oggle [B]lame" })
				map("n", "<leader>td", gs.toggle_deleted, { desc = "[T]oggle [D]eleted" })

				-- Text object
				map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
			end,
		})
	end,
}
