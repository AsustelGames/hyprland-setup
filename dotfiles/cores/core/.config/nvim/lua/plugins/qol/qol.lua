return {
  {
    "romgrk/barbar.nvim",
    dependencies = "kyazdani42/nvim-web-devicons",

    config = function()
      require("barbar").setup({
        auto_hide = true,
        clickable = false,
        exclude_ft = { "NvimTree" },
        icons = {
          button = "",
          separator = {
            left = "",
            right = "",
          },
          filetype = { custom_colors = true, },
          separator_at_end = false,
          modified = { button = '●' },
          pinned = { button = '', filename = true },
        },

        maximum_padding = 1,
        minimum_padding = 1,

      })
    end,
  },

  {
    "numToStr/Comment.nvim",

    config = function()
      require("Comment").setup()
    end,
  },

  {
    "windwp/nvim-autopairs",

    config = function()
      require("nvim-autopairs").setup()
    end,
  },
}
