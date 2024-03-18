return {
	"epwalsh/obsidian.nvim",
	version = "*", -- recommended, use latest release instead of latest commit
	lazy = true,
	ft = "markdown",
	config = function()
		require("obsidian").setup({
			workspaces = {
				{
					name = "personal",
					path = "~/Notes/Personal",
				},
				{
					name = "work",
					path = "~/Notes/Work",
				},
			},
			completion = {
				-- Set to false to disable completion.
				nvim_cmp = true,
				-- Trigger completion at 2 chars.
				min_chars = 2,
			},
			mappings = {
				-- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
				["gf"] = {
					action = function()
						return require("obsidian").util.gf_passthrough()
					end,
					opts = { noremap = false, expr = true, buffer = true },
				},
				-- Toggle check-boxes.
				["<leader>ch"] = {
					action = function()
						return require("obsidian").util.toggle_checkbox()
					end,
					opts = { buffer = true },
				},
			},
			follow_url_func = function(url)
				-- Open the URL in the default web browser.
				vim.fn.jobstart({ "xdg-open", url }) -- linux
			end,
			note_id_func = function(title)
				return title
			end,
			note_frontmatter_func = function(note)
				-- This is equivalent to the default frontmatter function.
				local out = { id = note.id, aliases = note.aliases, tags = note.tags, area = "", project = "" }

				-- `note.metadata` contains any manually added fields in the frontmatter.
				-- So here we just make sure those fields are kept in the frontmatter.
				if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
					for k, v in pairs(note.metadata) do
						out[k] = v
					end
				end
				return out
			end,
			new_notes_location = "curr_dir",
			picker = {
				-- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', or 'mini.pick'.
				name = "telescope.nvim",
				-- Optional, configure key mappings for the picker. These are the defaults.
				-- Not all pickers support all mappings.
				mappings = {
					-- Create a new note from your query.
					new = "<C-x>",
					-- Insert a link to the selected note.
					insert_link = "<C-l>",
				},
			},
			attachments = {
				img_folder = "assets/imgs",
			},
			daily_notes = {
				-- Optional, if you keep daily notes in a separate directory.
				folder = "daily",
				-- Optional, if you want to change the date format for the ID of daily notes.
				date_format = "%Y-%m-%d",
				-- Optional, if you want to change the date format of the default alias of daily notes.
				alias_format = "%B %-d, %Y",
				-- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
				template = nil,
			},
			wiki_link_func = "use_path_only",
			markdown_link_func = function(opts)
				return require("obsidian.util").markdown_link(opts)
			end,

			-- Either 'wiki' or 'markdown'.
			preferred_link_style = "wiki",
			-- Optional, define your own callbacks to further customize behavior.
			callbacks = {
				enter_note = function(client, note)
					vim.cmd("ZenMode")
					vim.cmd("PencilSoft")
				end,
				leave_note = function(client, note)
					vim.cmd("ZenMode")
					vim.cmd("PencilOff")
				end,
			},
		})

		vim.keymap.set("n", "<leader>oo", ":ObsidianQuickSwitch<CR>", { noremap = true, silent = true })
		vim.keymap.set("n", "<leader>on", ":ObsidianNew<CR>", { noremap = true, silent = true })
		vim.keymap.set("n", "<leader>ot", ":ObsidianToday<CR>", { noremap = true, silent = true })
	end,
}
