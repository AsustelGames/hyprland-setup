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
vim.opt.termguicolors = true


require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "plugins.lualine" },
    { import = "plugins.barbar" },
    { import = "plugins.colorizer" },
    { import = "plugins.autocomplete"},
    { import = "plugins.scrollofffraction" },
    { import = "plugins.endscroll" },
    { import = "plugins.autopairs" },
    { import = "plugins.alpha" },
    { import = "plugins.indentblankline" },
    { import = "plugins.tree" }, 
    { import = "plugins.comment"}, 
  },
  change_detection = {
    enabled = true,
    notify = false,
  },

  checker = { enabled = true },
})
