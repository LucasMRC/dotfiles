Opts = { noremap = true, silent = true }
Desc = function(description)
	return { desc = description, noremap = true, silent = true }
end
Keymap = vim.keymap.set
P = function(v)
	print(vim.inspect(v))
	return v
end
