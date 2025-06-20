return {
	{
		"kndndrj/nvim-dbee",
		dependencies = {
			"MunifTanjim/nui.nvim",
			lazy = true
		},
		cmd = {
			"Dbee"
		},
		build = function()
			-- Install tries to automatically detect the install method.
			-- if it fails, try calling it with one of these parameters:
			--    "curl", "wget", "bitsadmin", "go"
			require("dbee").install()
		end,
		config = function()
			local db = require("dbee")

			require("dbee").setup {
				sources = {
					require("dbee.sources").MemorySource:new({
						{
							name = "LocalStorage",
							type = "sqlite",
							url = "~/Repositories/mine/test/https_www.amazon.com_0.db",
						},
						-- ...
					}),
					require("dbee.sources").EnvSource:new("DBEE_CONNECTIONS"),
					require("dbee.sources").FileSource:new(vim.fn.stdpath("cache") .. "/dbee/persistence.json"),
				},
			}
			Keymap("n", "<leader>DB", db.toggle, { noremap = true, silent = true, desc = "Toggle database "})
		end,
	},
}
