local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable", -- latest stable release
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local status_ok, lazyvim = pcall(require, "lazy")
if not status_ok then
	print("Lazy.vim failed to load")
	return
end

require("lazy").setup({
	spec = {
		-- import your plugins
		{ import = "lucas/plugins" },
		{ import = "lucas/plugins/development" },
	},
	change_detection = {
		notify = false, -- hide notification when changes are found
	}
})
