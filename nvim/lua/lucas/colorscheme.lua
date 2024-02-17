vim.cmd.colorscheme "default" -- Fall back to default colorscheme

local colorscheme = "nordic"

local status_ok, _ = pcall(vim.cmd.colorscheme, colorscheme)
if not status_ok then
    print("Couldn't load colorscheme " .. colorscheme)
    return
end

vim.cmd.highlight "LineNr guifg=#4C566A"
