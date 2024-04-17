local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local status_ok, lazyvim = pcall(require, "lazy")
if not status_ok then
	print("Lazy.vim failed to load")
	return
end

lazyvim.setup("lucas/plugins", {
    change_detection = {
    notify = false, -- hide notification when changes are found
  }
})
