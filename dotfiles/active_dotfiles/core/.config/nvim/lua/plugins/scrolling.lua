return {
  {
    "plax-00/endscroll.nvim",
    config = function()
      require("endscroll").setup({ scroll_at_end = true })
    end,
  },

  {
    "nkakouros-original/scrollofffraction.nvim",
    config = function()
      require('scrollofffraction').setup({
        scrolloff_fraction = 0.47,
        scrolloff_absolute_value = 5
      })
    end,
  },
}
