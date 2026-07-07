return {
  {
    "plax-00/endscroll.nvim",
  
    config = function()
      require("endscroll").setup({
        scroll_at_end = true,
      })
    end,
  },
}
