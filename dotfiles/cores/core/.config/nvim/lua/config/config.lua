-- Tabs
local tabSize = 3

local fileType = vim.fn.expand("%:e")

if fileType == "sh" or fileType == "nix" or fileType == "lua" or fileType == "qml" then
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
vim.opt.relativenumber = true

vim.opt.cursorline = true

vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.breakat = ',.!?;:='
vim.opt.showbreak = '│  ->'

-- vim.cmd("highlight StatusColumnSeparator guifg=#FF0000")
-- vim.cmd("highlight StatusColumnSeparatorCursor guifg=#FFFF00")
--vim.opt.statuscolumn = " %=%{v:virtnum > 0 ? ' ' : (v:relnum == 0 ? printf('%2d', v:lnum) : printf('%2d', v:relnum))} %{v:relnum == 0 ? '%#Cursor#│%*' : '%#StatusColumnSeparator#│%*'} "
--
-- function statuscol_separator()
--   if vim.v.relnum == 0 then
--     return "%#StatusColumnSeparatorCursor#│%*"
--   end
--
--   return "%#StatusColumnSeparator#│%*"
-- end
--
-- vim.opt.statuscolumn = " %=%{v:virtnum > 0 ? ' ' : (v:relnum == 0 ? printf('%2d', v:lnum) : printf('%2d', v:relnum))} " .. "%{%v:lua.statuscol_separator()%} "
