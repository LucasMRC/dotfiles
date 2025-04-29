return {
	cmd = { 'lua-language-server' },
	root_markers = { '.gitignore', 'lazy-lock.json' },
	filetypes = { 'lua' },
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT)
				version = 'LuaJIT',
				-- Setup your lua path
				-- path = runtime_path,
			},
			diagnostics = {
				globals = { 'vim' },
				disable = { 'missing-fields' }
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file('', true),
				checkThirdParty = "ask",
				ignoreDir = {
					"~/Repositories/!(nvim)"
				}
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = { enable = false },
		},
	},
}
