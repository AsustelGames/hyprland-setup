return {
  {
    "romgrk/barbar.nvim",
    dependencies = "kyazdani42/nvim-web-devicons",

    config = function()
      require("barbar").setup()
    end,
  },
}
