return {
  {
    'nkakouros-original/scrollofffraction.nvim',
  
    config = function()
      require('scrollofffraction').setup({
        scrolloff_fraction = 0.47,
        scrolloff_absolute_value = 5
      })
    end,
  },
}
