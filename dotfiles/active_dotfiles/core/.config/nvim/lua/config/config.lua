-- Tabs
local tabSize = 3

local fileType = vim.fn.expand("%:e")

if fileType == "sh" or fileType == "nix" or fileType == "lua" then
   tabSize = 2
end

vim.opt.expandtab = true
vim.opt.shiftwidth = tabSize
vim.opt.tabstop = tabSize
vim.opt.softtabstop = tabSize

vim.opt.list = true
vim.opt.listchars = {
  tab = '>>',
  trail = '.',
  space = '·',
  extends  = '>',
  precedes = '<',
}


vim.opt.showmode = false
vim.opt.number = true

vim.opt.cuc = true
vim.opt.cursorline = true

vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.breakat = ' ,.!?;:='
vim.opt.showbreak = '->'
