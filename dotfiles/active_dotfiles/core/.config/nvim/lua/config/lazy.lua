-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)


require("config.keybinds")
require("config.lsp")

vim.opt.termguicolors = true


require("lazy").setup({
  -- Plugins
  spec = {
    -- Info
    { import = "plugins.info.tree" }, 
    { import = "plugins.info.lualine" },
    { import = "plugins.info.autocomplete" },

    -- Looks
    { import = "plugins.looks.coloring" },
    { import = "plugins.looks.alpha" },

    -- Quality of life
    { import = "plugins.qol.qol" },

    -- Scrolling
    { import = "plugins.scrolling" },
  },
  change_detection = {
    enabled = true,
    notify = false,
  },

  ui = {
    border = "rounded",
  },

  checker = { enabled = false },
})
