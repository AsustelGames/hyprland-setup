return {
  {
    "nvim-tree/nvim-tree.lua",

    config = function()
      require("nvim-tree").setup({
        sync_root_with_cwd = true,
        respect_buf_cwd = true,
        filters = {
          dotfiles = true,
        },
        view = {
          width = 30,
        },
        git = {
          enable = false,
        },
      })
    end,
  },
}
