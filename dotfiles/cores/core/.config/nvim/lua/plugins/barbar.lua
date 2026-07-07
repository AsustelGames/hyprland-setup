return {
  {
    "romgrk/barbar.nvim",
    dependencies = "kyazdani42/nvim-web-devicons",

    config = function()
      require("barbar").setup({
        auto_hide = true,
        clickable = false,
        exclude_ft = { "NvimTree" },
      })
    end,
  },
}
