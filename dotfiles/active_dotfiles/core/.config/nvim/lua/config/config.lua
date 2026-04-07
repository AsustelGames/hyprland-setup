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
  extends  = '>',     -- character shown when line is too long (> screen)
  precedes = '<',     -- character shown when line continues before screen
}


vim.opt.showmode = false
vim.opt.number = true

vim.opt.cuc = true
vim.opt.cursorline = true

vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.breakat = ' ,.!?;:='
vim.opt.showbreak = '->'

vim.lsp.config['clangd'] = {
  -- Command and arguments to start the server
  cmd = { 'clangd', '--background-index', '--clang-tidy' },
  
  -- Filetypes to automatically attach to
  filetypes = { 'c', 'cpp', 'objc', 'objcpp' },
  
  -- Sets the "workspace" to the directory where any of these files is found
  root_markers = { 'compile_commands.json', '.git' },
  
  -- Specific settings to send to the server
  settings = {
    clangd = {
      -- Example settings: enable completion, semantic highlighting, etc.
      completion = {
        detailedLabel = true
      },
      diagnostics = {
        clangTidy = true
      }
    }
  }
}

vim.lsp.enable('clangd')

