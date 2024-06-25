return {
	{
		"folke/zen-mode.nvim", -- zen mode
		dependencies = {
			{
				"preservim/vim-pencil",
			}, -- writing mode
			"folke/twilight.nvim", -- focus mode
		},
		config = function()
			require("zen-mode").setup({
				window = {
					backdrop = 0.95,
					width = 80, -- width of the Zen window
					height = 1, -- height of the Zen window
					options = {
						signcolumn = "no", -- disable signcolumn
						number = true, -- enable number column
						relativenumber = true, -- enable relative numbers
						-- cursorline = false, -- disable cursorline
						-- cursorcolumn = false, -- disable cursor column
						-- foldcolumn = "0", -- disable fold column
						list = true, -- disable whitespace characters
					},
				},
				plugins = {
					-- disable some global vim options (vim.o...)
					options = {
						enabled = true,
						ruler = false, -- disables the ruler text in the cmd line area
						showcmd = false, -- disables the command in the last line of the screen
						-- you may turn on/off statusline in zen mode by setting 'laststatus'
						-- statusline will be shown only if 'laststatus' == 3
						laststatus = 0, -- turn off the statusline in zen mode
					},
					twilight = { enabled = false }, -- enable to start Twilight when zen mode opens
					gitsigns = { enabled = false }, -- disables git signs
					tmux = { enabled = false }, -- disables the tmux statusline
					wezterm = {
						enabled = true,
						font = "+20", -- (10% increase per step)
					},
				},
			})

            -- Set concealing values for vim-pencil
            vim.cmd([[
                let g:pencil#conceallevel = 1
                let g:pencil#concealcursor = 'nc'
            ]])

			-- local group = vim.api.nvim_create_augroup("lucas-writer-mode", { clear = true })
			-- vim.api.nvim_create_autocmd("FileType", {
			-- 	pattern = { "markdown", "text" },
			-- 	group = group,
			-- 	callback = function(event)
			-- 		vim.api.nvim_create_autocmd("BufEnter", {
			-- 			buffer = event.buf,
			-- 			group = group,
			-- 			callback = function()
			-- 				vim.cmd("PencilSoft")
			-- 			end,
			-- 		})
			-- 		vim.api.nvim_create_autocmd("BufLeave", {
			-- 			buffer = event.buf,
			-- 			group = group,
			-- 			callback = function()
			-- 				vim.cmd("PencilOff")
			-- 			end,
			-- 		})
			-- 	end,
			-- })
		end,
	},
	{
		"epwalsh/obsidian.nvim",
		version = "*", -- recommended, use latest release instead of latest commit
		lazy = false, -- always load on start-up
		ft = "markdown",
		-- Required.
		dependencies = {
			-- Required.
			"nvim-lua/plenary.nvim",
		},
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
				new_notes_location = "notes_subdir",
				open_notes_in = "current",
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
					enter_note = function()
						vim.cmd("ZenMode")
                        vim.cmd("PencilSoft")
						-- vim.cmd("TwilightEnable")
					end,
					leave_note = function()
						vim.cmd("ZenMode")
                        vim.cmd("PencilOff")
						-- vim.cmd("TwilightDisable")
					end,
				},
                ui = {
                    enable = true,  -- set to false to disable all additional syntax features
                    update_debounce = 200,  -- update delay after a text change (in milliseconds)
                    max_file_length = 5000,  -- disable UI features for files with more than this many lines
                    -- Define how various check-boxes are displayed
                    checkboxes = {
                        -- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
                        [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
                        ["x"] = { char = "", hl_group = "ObsidianDone" },
                        [">"] = { char = "", hl_group = "ObsidianRightArrow" },
                        ["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
                        ["!"] = { char = "", hl_group = "ObsidianImportant" },
                        -- Replace the above with this if you don't have a patched font:
                        -- [" "] = { char = "☐", hl_group = "ObsidianTodo" },
                        -- ["x"] = { char = "✔", hl_group = "ObsidianDone" },

                        -- You can also add more custom ones...
                    },
                    -- Use bullet marks for non-checkbox lists.
                    bullets = { char = "•", hl_group = "ObsidianBullet" },
                    external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
                    -- Replace the above with this if you don't have a patched font:
                    -- external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
                    reference_text = { hl_group = "ObsidianRefText" },
                    highlight_text = { hl_group = "ObsidianHighlightText" },
                    tags = { hl_group = "ObsidianTag" },
                    block_ids = { hl_group = "ObsidianBlockID" },
                    hl_groups = {
                        -- The options are passed directly to `vim.api.nvim_set_hl()`. See `:help nvim_set_hl`.
                        ObsidianTodo = { bold = true, fg = "#f78c6c" },
                        ObsidianDone = { bold = true, fg = "#89ddff" },
                        ObsidianRightArrow = { bold = true, fg = "#f78c6c" },
                        ObsidianTilde = { bold = true, fg = "#ff5370" },
                        ObsidianImportant = { bold = true, fg = "#d73128" },
                        ObsidianBullet = { bold = true, fg = "#89ddff" },
                        ObsidianRefText = { underline = true, fg = "#c792ea" },
                        ObsidianExtLinkIcon = { fg = "#c792ea" },
                        ObsidianTag = { italic = true, fg = "#89ddff" },
                        ObsidianBlockID = { italic = true, fg = "#89ddff" },
                        ObsidianHighlightText = { bg = "#75662e" },
                    },
                }
			})

			vim.keymap.set("n", "<leader>oo", ":ObsidianQuickSwitch<CR>", { noremap = true, silent = true, desc = "[O]bsidian [o]pen"})
			vim.keymap.set("n", "<leader>on", ":ObsidianNew<CR>", { noremap = true, silent = true, desc = "[O]bsidian [n]ew"})
			vim.keymap.set("n", "<leader>ot", ":ObsidianToday<CR>", { noremap = true, silent = true, desc = "[O]bsidian [t]oday"})
			vim.keymap.set("n", "<leader>os", ":ObsidianSearch<CR>", { noremap = true, silent = true, desc = "[O]bsidian [s]earch"})
			vim.keymap.set("n", "<leader>ow", ":ObsidianWorkspace<CR>", { noremap = true, silent = true, desc = "[O]bsidian [w]orkspace"})
		end,
	},
}
