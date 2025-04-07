local lss = {
	-- formatters
	'stylua', -- Used to format lua code
	-- linters
	-- 'quick-lint-js',
	'biome',
	'luacheck',
	'shellcheck',
	-- lsp servers
	'emmet_ls',
	'lua_ls',
	'ts_ls',
	'html',
	-- 'css_ls',
	'tailwindcss',
	'svelte',
	'json',
	'jsonnet_ls',
	'gopls'
}
vim.lsp.enable(lss)

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend('force', capabilities, require('blink.cmp').get_lsp_capabilities({}, false))

for _, s in ipairs(lss) do
	local settings = vim.lsp.config[s]
	settings.capabilities = capabilities
	vim.lsp.config[s] = settings
end

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lucas-lsp-attach", { clear = true }),
	callback = function(event)
		vim.diagnostic.config({
			severity_sort = true,
			underline = true,
			signs = true,
			float = {
				focusable = false,
				source = true,
				header = "",
			},
			virtual_text = {
				current_line = true
			},
		})

		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if client then
			if client:supports_method('textDocument/completion') then
				vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
			end
			if client.server_capabilities.documentHighlightProvider then
				vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
					buffer = event.buf,
					callback = vim.lsp.buf.document_highlight,
				})

				vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
					buffer = event.buf,
					callback = vim.lsp.buf.clear_references,
				})
			end
		end
	end,
})

-- delete NO NAME buffers
local function is_no_name_buf(buf)
	return
		vim.api.nvim_buf_is_loaded(buf)
		and vim.api.nvim_get_option_value('buflisted', { buf = 0 })
		and vim.api.nvim_buf_get_name(buf) == ''
		and vim.api.nvim_get_option_value('buftype', { buf = 0 }) == ''
		and vim.api.nvim_get_option_value('filetype', { buf = 0 }) == ''
end

vim.api.nvim_create_autocmd("BufAdd", {
	callback = function()
		local no_named_buffers = vim.tbl_filter(is_no_name_buf, vim.api.nvim_list_bufs())
		for _, buf_hndl in ipairs(no_named_buffers) do
			if vim.api.nvim_buf_is_loaded(buf_hndl) then
				vim.api.nvim_buf_delete(buf_hndl, { force = true })
			end
		end
	end,
})

